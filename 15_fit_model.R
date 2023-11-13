### 

home_game_data <- game_data %>%
                  select(game_id, game_date, season, home_team, home_team_TD,
                         home_team_FG, home_final_score, away_team, away_team_TD,
                         away_team_FG, away_final_score) %>%
                  mutate(home_or_away = "home")

away_game_data <- game_data %>%
                  select(game_id, game_date, season, away_team, away_team_TD,
                         away_team_FG, away_final_score, home_team, home_team_TD,
                         home_team_FG, home_final_score) %>%
                  mutate(home_or_away = "away")

colnames(home_game_data) <- c('game_id', 'game_date', 'season', 'team', 'num_TD', 
                              'num_FG', 'score', 'opp.team', 'opp.num_TD',
                              'opp.num_FG', 'opp.score', 'home_or_away')

colnames(away_game_data) <- c('game_id', 'game_date', 'season', 'team', 'num_TD', 
                              'num_FG', 'score', 'opp.team', 'opp.num_TD',
                              'opp.num_FG', 'opp.score', 'home_or_away')

combined_game_data <- bind_rows(home_game_data, away_game_data) %>%
                      arrange(game_date, game_id)

# Fit a univariate Poisson regression to our touchdown and field goal data
# SHOULD WE INCLUDE OPPONENT NUMBER OF FIELD GOALS AND TOUCHDOWNS?
TD_glm <- glm(num_TD ~ team + num_FG + opp.team + opp.num_TD + opp.num_FG
              + home_or_away, data = combined_game_data, family = "poisson")
summary(TD_glm)

FG_glm <- glm(num_FG ~ team + num_TD + opp.team + opp.num_TD + opp.num_FG
              + home_or_away, data = combined_game_data, family = "poisson")
summary(FG_glm)

# Fit a multivariate Poisson regression to both touchdown and field goal data




# predict distribution of number of touchdowns and field goals
# (not distribution of score)

# create df with to have num touchdowns, num field goals, off, def and another line score, def, off

# Use glm(family = poisson)


# weights argument in lm, glm


# consider each team in each season to be a different entity

