### Check spread and over/under betting accuracy of univariate and bivariate
### Poisson models

###########################################
#--- Bivariate Linear Model Evaluation ---#
###########################################

# calculate proportion of predicted outcomes based on simulation results
biv_lm_bet_stats <- biv_lm_betting %>%
                    group_by(game_id) %>%
                    summarise(prop_over_under = mean(score_sum > over_under_line),
                              prop_under_over = mean(score_sum < over_under_line),
                              prop_over_spread = mean(score_difference > spread_favorite),
                              prop_under_spread = mean(score_difference < spread_favorite))

# determine predicted spread and over/under bets based on simulation results
biv_lm_pred_bets <- biv_lm_bet_stats %>%
                    mutate(spread_bet = ifelse(prop_over_spread > prop_under_spread, "home", "away"),
                           over_under_bet = ifelse(prop_over_under > prop_under_over, "over", "under"))

# calculate actual game outcomes and corresponding spread and over/under information
actual_win_bets <- game_betting %>%
                   mutate(actual_sum = home_final_score + away_final_score,
                          actual_difference = home_final_score - away_final_score) %>%
                   mutate(spread_favorite = ifelse(home_team == team_favorite_id, abs(spread_favorite), spread_favorite)) %>%
                   mutate(correct_spread_bet = ifelse(actual_difference > spread_favorite, "home", "away")) %>%
                   mutate(correct_over_under_bet = ifelse(actual_sum > over_under_line, "over", "under"))

# create a new dataframe that holds the predicted and actual outcomes for comparison
biv_lm_compare <- merge(biv_lm_pred_bets %>% select(game_id, spread_bet, over_under_bet),
                        actual_win_bets %>% select(game_id, correct_spread_bet, correct_over_under_bet),
                        by = "game_id")

# calculate accuracy of spread predictions
biv_lm_spread_accuracy <- sum(biv_lm_compare$spread_bet == biv_lm_compare$correct_spread_bet) / nrow(biv_lm_pred_bets)
# calculate accuracy of over/under predictions
biv_lm_over_under_accuracy <- sum(biv_lm_compare$over_under_bet == biv_lm_compare$correct_over_under_bet) / nrow(biv_lm_pred_bets)

# output the results
biv_lm_spread_accuracy
biv_lm_over_under_accuracy



#############################################
#--- Univariate Poisson Model Evaluation ---#
#############################################

# calculate proportion of predicted outcomes based on simulation results
uni_pois_bet_stats <- uni_pois_betting %>%
                      group_by(game_id) %>%
                      summarise(prop_over_under = mean(score_sum > over_under_line),
                                prop_under_over = mean(score_sum < over_under_line),
                                prop_over_spread = mean(score_difference > spread_favorite),
                                prop_under_spread = mean(score_difference < spread_favorite))

# determine predicted spread and over/under bets based on simulation results
uni_pois_pred_bets <- uni_pois_bet_stats %>%
                      mutate(spread_bet = ifelse(prop_over_spread > prop_under_spread, "home", "away"),
                             over_under_bet = ifelse(prop_over_under > prop_under_over, "over", "under"))

# calculate actual game outcomes and corresponding spread and over/under information
actual_win_bets <- game_betting %>%
                   mutate(actual_sum = home_final_score + away_final_score,
                          actual_difference = home_final_score - away_final_score) %>%
                   mutate(spread_favorite = ifelse(home_team == team_favorite_id, abs(spread_favorite), spread_favorite)) %>%
                   mutate(correct_spread_bet = ifelse(actual_difference > spread_favorite, "home", "away")) %>%
                   mutate(correct_over_under_bet = ifelse(actual_sum > over_under_line, "over", "under"))

# create a new dataframe that holds the predicted and actual outcomes for comparison
uni_pois_compare <- merge(uni_pois_pred_bets %>% select(game_id, spread_bet, over_under_bet),
                          actual_win_bets %>% select(game_id, correct_spread_bet, correct_over_under_bet),
                          by = "game_id")

# calculate accuracy of spread predictions
uni_pois_spread_accuracy <- sum(uni_pois_compare$spread_bet == uni_pois_compare$correct_spread_bet) / nrow(uni_pois_pred_bets)
# calculate accuracy of over/under predictions
uni_pois_over_under_accuracy <- sum(uni_pois_compare$over_under_bet == uni_pois_compare$correct_over_under_bet) / nrow(uni_pois_pred_bets)

# output the results
uni_pois_spread_accuracy
uni_pois_over_under_accuracy



############################################
#--- Bivariate Poisson Model Evaluation ---#
############################################

# calculate proportion of predicted outcomes based on simulation results
biv_pois_bet_stats <- biv_pois_betting %>%
                      group_by(game_id) %>%
                      summarise(prop_over_under = mean(score_sum > over_under_line),
                                prop_under_over = mean(score_sum < over_under_line),
                                prop_over_spread = mean(score_difference > spread_favorite),
                                prop_under_spread = mean(score_difference < spread_favorite))

# determine predicted spread and over/under bets based on simulation results
biv_pois_pred_bets <- biv_pois_bet_stats %>%
                      mutate(spread_bet = ifelse(prop_over_spread > prop_under_spread, "home", "away"),
                             over_under_bet = ifelse(prop_over_under > prop_under_over, "over", "under"))

# calculate actual game outcomes and corresponding spread and over/under information
actual_win_bets <- game_betting %>%
                   mutate(actual_sum = home_final_score + away_final_score,
                          actual_difference = home_final_score - away_final_score) %>%
                   mutate(spread_favorite = ifelse(home_team == team_favorite_id, abs(spread_favorite), spread_favorite)) %>%
                   mutate(correct_spread_bet = ifelse(actual_difference > spread_favorite, "home", "away")) %>%
                   mutate(correct_over_under_bet = ifelse(actual_sum > over_under_line, "over", "under"))

# create a new dataframe that holds the predicted and actual outcomes for comparison
biv_pois_compare <- merge(biv_pois_pred_bets %>% select(game_id, spread_bet, over_under_bet),
                          actual_win_bets %>% select(game_id, correct_spread_bet, correct_over_under_bet),
                          by = "game_id")

# calculate accuracy of spread predictions
biv_pois_spread_accuracy <- sum(biv_pois_compare$spread_bet == biv_pois_compare$correct_spread_bet) / nrow(biv_pois_pred_bets)
# calculate accuracy of over/under predictions
biv_pois_over_under_accuracy <- sum(biv_pois_compare$over_under_bet == biv_pois_compare$correct_over_under_bet) / nrow(biv_pois_pred_bets)

# output the results
biv_pois_spread_accuracy
biv_pois_over_under_accuracy


##############################
#--- Check for dispersion ---#
##############################

# copy game dataframe to check dispersion ratio of the bivariate Poisson model
game_data_disp <- combined_game_data

# extract coefficients and standard errors for our predictors
biv_pois_coeffs <- full_dep_model$coeff[, c("Var.Names", "Coeff", "s.e", "Adj.s.e")]

# compute lambda hat values for touchdowns and field goals
game_data_disp$TD_pred <- c(exp(matrix_w_constant %*% biv_pois_coeffs[,"Coeff"][1:88]))
game_data_disp$FG_pred <- c(exp(matrix_w_constant %*% biv_pois_coeffs[,"Coeff"][89:176])
                            * game_data_disp$TD_pred)

# calculate residuals for touchdowns and field goals
game_data_disp$TD_res <- c(game_data_disp$num_TD - game_data_disp$TD_pred)
game_data_disp$FG_res <- c(game_data_disp$num_FG - game_data_disp$FG_pred)

# standardized residuals (z-scores) for touchdowns and field goals
game_data_disp$TD_z_res <- c((game_data_disp$TD_res - mean(game_data_disp$TD_pred))
                             / sqrt(game_data_disp$TD_pred))
game_data_disp$FG_z_res <- c((game_data_disp$FG_res - mean(game_data_disp$FG_pred))
                             / sqrt(game_data_disp$FG_pred))

# dispersion calculation for touchdowns and field goals (suggests overdispersion)
# perhaps a negative binomial model may better fit the data
disp_TD <- sum(game_data_disp$TD_z_res ^ 2) / (nrow(game_data_disp) - 2)
disp_FG <- sum(game_data_disp$FG_z_res ^ 2) / (nrow(game_data_disp) - 2)
