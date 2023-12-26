### Simulate the bivariate Linear model, and the univariate and bivariate 
### Poisson models

############################################
#--- Bivariate Linear Model Simulations ---#
############################################

# select game_id, predictors, and touchdown and field goal counts
biv_lm_sim <- combined_game_data %>%
              select(-c(game_date))

# predict the number of touchdowns and field goals for bivariate lm
biv_lm_sim$y_TD <- predict(biv_lm, biv_lm_sim, type = "response")[,1]
biv_lm_sim$y_FG <- predict(biv_lm, biv_lm_sim, type = "response")[,2]

# calculate the predicted score for
biv_lm_sim$predicted_score <- 7 * biv_lm_sim$y_TD + 3 * biv_lm_sim$y_FG


# pivot the bivariate linear game simulation dataframe to longer format
biv_lm_pivoted <- biv_lm_sim %>%
                  # grouping by game_id
                  group_by(game_id) %>%
                  # calculate the difference and sum of scores for each simulation of each game
                  summarise(across(starts_with("predicted_score"), ~ .[1] - .[2], .names = "difference_{.col}"),
                            across(starts_with("predicted_score"), ~ .[1] + .[2], .names = "sum_{.col}")) %>%
                  # rename the corresponding difference and sum columns appropriately
                  rename_all(~ gsub("difference_predicted_score", "score_difference", .)) %>%
                  rename_all(~ gsub("sum_predicted_score", "score_sum", .))

# re-merge match details and corresponding betting information to the pivoted longer data
biv_lm_betting <- game_betting %>%
                  # subset game and correspding betting data
                  select(game_id, home_team, away_team, 
                         home_final_score, away_final_score, 
                         team_favorite_id, spread_favorite, over_under_line) %>%
                  # join with the pivoted simulation output
                  left_join(biv_lm_pivoted, by = "game_id") %>%
                  relocate(home_team, away_team, home_final_score,
                           away_final_score, .after = game_id) %>%
                  # change spread to positive if away team is favorited
                  mutate(spread_favorite = if_else(team_favorite_id == home_team, 
                                                   abs(spread_favorite), spread_favorite),
                         team_favorite_id = NULL)


##############################################
#--- Univariate Poisson Model Simulations ---#
##############################################

# select game_id, predictors, and touchdown and field goal counts
uni_pois_sim <- combined_game_data %>%
                select(-c(game_date))

# predict the lambdas for the separate univariate models
uni_pois_sim$TD_lambda <- predict(TD_glm, uni_pois_sim, type = "response")
uni_pois_sim$FG_lambda <- predict(FG_glm, uni_pois_sim, type = "response")

# loop from 1 to 1,000
for (i in 1:1000) {
  
  # generate corresponding touchdown y hat by randomly sampling from the Poisson touchdown lambda hat distribution
  y_TD <- paste0("y_TD_", i)
  uni_pois_sim[[y_TD]] <- c(rpois(uni_pois_sim$TD_lambda, lambda = uni_pois_sim$TD_lambda))
  
  # generate corresponding field goal y hat by randomly sampling from the Poisson field goal lambda hat distribution
  y_FG <- paste0("y_FG_", i)
  uni_pois_sim[[y_FG]] <- c(rpois(uni_pois_sim$FG_lambda, lambda = uni_pois_sim$FG_lambda))
  
  # compute the corresponding final score using the current touchdown y hat and field goal y hat
  predicted_score <- paste0("predicted_score_", i)
  uni_pois_sim[[predicted_score]] <- 7 * uni_pois_sim[[y_TD]] + 3 * uni_pois_sim[[y_FG]]
}

# pivot the bivariate poisson game simulation dataframe to longer format
uni_pois_pivoted <- uni_pois_sim %>%
                    # grouping by game_id
                    group_by(game_id) %>%
                    # calculate the difference and sum of scores for each simulation of each game
                    summarise(across(starts_with("predicted_score"), ~ .[1] - .[2], .names = "difference_{.col}"),
                              across(starts_with("predicted_score"), ~ .[1] + .[2], .names = "sum_{.col}")) %>%
                    # rename the corresponding difference and sum columns appropriately
                    rename_all(~ gsub("difference_predicted_score", "score_difference", .)) %>%
                    rename_all(~ gsub("sum_predicted_score", "score_sum", .)) %>%
                    # pivot the dataset from wider to longer so that each simulation and corresponding values separate rows
                    pivot_longer(cols = starts_with("score_difference_") | starts_with("score_sum_"), 
                                 names_to = c(".value", "simulation_number"),
                                 names_pattern = "([^_]+)_(\\d+)$") %>%
                    # rename the columns of the pivoted longer dataframe
                    rename(score_difference = difference, score_sum = sum)

# re-merge match details and corresponding betting information to the pivoted longer data
uni_pois_betting <- game_betting %>%
                    # subset game and correspding betting data
                    select(game_id, home_team, away_team, 
                           home_final_score, away_final_score, 
                           team_favorite_id, spread_favorite, over_under_line) %>%
                    # join with the pivoted simulation output
                    left_join(uni_pois_pivoted, by = "game_id") %>%
                    relocate(home_team, away_team, home_final_score,
                             away_final_score, .after = game_id) %>%
                    # change spread to positive if away team is favorited
                    mutate(spread_favorite = if_else(team_favorite_id == home_team, 
                                                     abs(spread_favorite), spread_favorite),
                           team_favorite_id = NULL)


#############################################
#--- Bivariate Poisson Model Simulations ---#
#############################################

# select game_id, predictors, and touchdown and field goal counts
biv_pois_sim <- combined_game_data %>%
                select(-c(game_date))

# extract coefficients and standard errors for our predictors
biv_pois_coeffs <- full_dep_model$coeff[, c("Var.Names", "Coeff", "s.e", "Adj.s.e")]

# loop from 1 to 1,000
for (i in 1:1000) {
  
  # generate new set of beta hats by randomly sampling from Normal beta distributions
  beta <- paste0("beta_", i)
  biv_pois_coeffs[[beta]] <- c(rnorm(176, mean = biv_pois_coeffs$Coeff, sd = biv_pois_coeffs$Adj.s.e))
  
  # calculate corresponding touchdown lambda hat for the current set of beta hats
  TD_lambda <- paste0("TD_lambda_", i)
  biv_pois_sim[[TD_lambda]] <- c(exp(matrix_w_constant %*% biv_pois_coeffs[[beta]][1:88]))
  
  # calculate corresponding field goal lambda hat for the current set of beta hats
  FG_lambda <- paste0("FG_lambda_", i)
  biv_pois_sim[[FG_lambda]] <- c(exp(matrix_w_constant %*% biv_pois_coeffs[[beta]][89:176]))
  
  # generate corresponding touchdown y hat by randomly sampling from the Poisson touchdown lambda hat distribution
  y_TD <- paste0("y_TD_", i)
  biv_pois_sim[[y_TD]] <- c(rpois(biv_pois_sim[[TD_lambda]], lambda = biv_pois_sim[[TD_lambda]]))
  
  # generate corresponding field goal y hat by randomly sampling from the conditional Poisson field goal lambda hat distribution
  y_FG <- paste0("y_FG_", i)
  biv_pois_sim[[y_FG]] <- c(rpois(biv_pois_sim[[FG_lambda]], lambda = (biv_pois_sim[[FG_lambda]] * biv_pois_sim[[y_TD]])))
  
  # compute corresponding final score using the current touchdown y hat and field goal y hat
  predicted_score <- paste0("predicted_score_", i)
  biv_pois_sim[[predicted_score]] <- 7 * biv_pois_sim[[y_TD]] + 3 * biv_pois_sim[[y_FG]]
}

# pivot the bivariate poisson game simulation dataframe to longer format
biv_pois_pivoted <- biv_pois_sim %>%
                    # grouping by game_id
                    group_by(game_id) %>%
                    # calculate the difference and sum of scores for each simulation of each game
                    summarise(across(starts_with("predicted_score"), ~ .[1] - .[2], .names = "difference_{.col}"),
                              across(starts_with("predicted_score"), ~ .[1] + .[2], .names = "sum_{.col}")) %>%
                    # rename the corresponding difference and sum columns appropriately
                    rename_all(~ gsub("difference_predicted_score", "score_difference", .)) %>%
                    rename_all(~ gsub("sum_predicted_score", "score_sum", .)) %>%
                    # pivot the dataset from wider to longer so that each simulation and corresponding values separate rows
                    pivot_longer(cols = starts_with("score_difference_") | starts_with("score_sum_"), 
                                 names_to = c(".value", "simulation_number"),
                                 names_pattern = "([^_]+)_(\\d+)$") %>%
                    # rename the columns of the pivoted longer dataframe
                    rename(score_difference = difference, score_sum = sum)

# re-merge match details and corresponding betting information to the pivoted longer data
biv_pois_betting <- game_betting %>%
                    # subset game and correspding betting data
                    select(game_id, home_team, away_team, 
                           home_final_score, away_final_score, 
                           team_favorite_id, spread_favorite, over_under_line) %>%
                    # join with the pivoted simulation output
                    left_join(biv_pois_pivoted, by = "game_id") %>%
                    relocate(home_team, away_team, home_final_score,
                             away_final_score, .after = game_id) %>%
                    # change spread to positive if away team is favorited
                    mutate(spread_favorite = if_else(team_favorite_id == home_team, 
                                                     abs(spread_favorite), spread_favorite),
                           team_favorite_id = NULL)
