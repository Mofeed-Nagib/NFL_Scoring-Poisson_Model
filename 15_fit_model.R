### Fit univariate and multivariate linear and poisson regression models

# subset data for home teams and corresponding score breakdown
home_game_data <- game_betting %>%
                  select(game_id, game_date, season, week_of_season,
                         home_team, away_team, home_TD_count, home_FG_count) %>%
                  mutate(home_or_away = "home") %>%
                  relocate(home_or_away, .after = away_team)

# subset data for away teams and corresponding score breakdown
away_game_data <- game_betting %>%
                  select(game_id, game_date, season, week_of_season,
                         away_team, home_team, away_TD_count, away_FG_count) %>%
                  mutate(home_or_away = "away") %>%
                  relocate(home_or_away, .after = home_team)

# rename columns to match for home team data
colnames(home_game_data) <- c('game_id', 'game_date', 'season', 'week_of_season',
                              'team', 'opp.team', 'home_or_away', 'num_TD', 'num_FG')

# rename columns to match for away team data
colnames(away_game_data) <- c('game_id', 'game_date', 'season', 'week_of_season',
                              'team', 'opp.team', 'home_or_away', 'num_TD', 'num_FG')

# bind the home game and away game data together (now have two rows for each game)
combined_game_data <- bind_rows(home_game_data, away_game_data) %>%
                      arrange(game_date, game_id)

# convert columns to desired data type for performing regression
combined_game_data$season <- as.character(combined_game_data$season)
combined_game_data$week_of_season <- as.character(combined_game_data$week_of_season)


#=========================#
#=== Linear Regression ===#
#=========================#

# fit a univariate Linear regression to aggregate touchdown data
TD_lm <- lm(num_TD ~ team + opp.team + season + week_of_season + home_or_away,
            data = combined_game_data)
summary(TD_lm)

head(resid(TD_lm)) # residuals (same)
head(fitted(TD_lm)) # fitted values (same)
coef(TD_lm) # coefficients (same)
sigma(TD_lm) # residual standard error (same)
head(vcov(TD_lm)) # variance-covariance matrix (same as top left)

# fit a univariate Linear regression to aggregate field goal data
FG_lm <- lm(num_FG ~ team + opp.team + season + week_of_season + home_or_away,
            data = combined_game_data)
summary(FG_lm)

head(resid(FG_lm)) # residuals (same)
head(fitted(FG_lm)) # fitted values (same)
coef(FG_lm) # coefficients (same)
sigma(FG_lm) # residual standard error (same)
head(vcov(FG_lm)) # variance-covariance matrix (same as bottom right)

# fit a multivariate Linear regression to both touchdown and field goal data
combined_lm <- lm(cbind(num_TD, num_FG) ~ team + opp.team + season + week_of_season + home_or_away,
                  data = combined_game_data)
summary(combined_lm)

head(resid(combined_lm)) # residuals (same)
head(fitted(combined_lm)) # fitted values (same)
coef(combined_lm) # coefficients (same)
sigma(combined_lm) # residual standard error (same)
head(vcov(combined_lm)) # variance-covariance matrix (diff in top right and bottom left)

library(car)
Anova(combined_lm) # all predictors are significant except week_of_season

final_lm <- update(combined_lm, . ~ . - week_of_season) # remove week_of_season as a predictor
anova(combined_lm, final_lm) # confirms that the model fits just as well w/o week_of_season
summary(final_lm)

#==========================#
#=== Poisson Regression ===#
#==========================#

# fit a univariate Poisson regression to aggregate touchdown data
TD_glm <- glm(num_TD ~ team + opp.team + season + home_or_away,
              data = combined_game_data, family = poisson)
summary(TD_glm)

# fit a univariate Poisson regression to aggregate field goal data
FG_glm <- glm(num_FG ~ team + opp.team + season + home_or_away,
              data = combined_game_data, family = poisson)
summary(FG_glm)

# construct design matrix for all the predictor variables
matrix_w_constant <- model.matrix(~ team + opp.team + season +
                                    home_or_away, data = combined_game_data)
matrix_wo_constant <- matrix_w_constant[, -c(1)] # drop intercept column

# fit a multivariate Poisson regression to both touchdown and field goal data
constants_only_indep <- bpglm(combined_game_data[,c("num_TD", "num_FG")], mtype = 1)
constants_only_dep <- bpglm(combined_game_data[,c("num_TD", "num_FG")], mtype = 2)

# independent bivariate Poisson regression (returns same coefficients)
full_indep_model <- bpglm(combined_game_data[,c("num_TD", "num_FG")],
                          matrix_wo_constant, matrix_wo_constant, mtype = 1)

# dependent bivariate Poisson regression (returns diff coefficients)
full_dep_model <- bpglm(combined_game_data[,c("num_TD", "num_FG")],
                        matrix_wo_constant, matrix_wo_constant, mtype = 2)
