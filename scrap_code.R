### 05_get_data.R

# # extract scoring data for all possible scoring events
# TD_pbp_data <- distinct(pbp_data[(!is.na(pbp_data$touchdown)) & (pbp_data$touchdown == 1),])
# FG_pbp_data <- distinct(pbp_data[(!is.na(pbp_data$field_goal_attempt)) & (pbp_data$field_goal_attempt == 1),])
# XP_pbp_data <- pbp_data[(!is.na(pbp_data$extra_point_attempt)) & (pbp_data$extra_point_attempt == 1),]
# TWO_PT_pbp_data <- pbp_data[(!is.na(pbp_data$two_point_attempt)) & (pbp_data$two_point_attempt == 1),]
# SAFETY_pbp_data <- pbp_data[(!is.na(pbp_data$safety)) & (pbp_data$safety == 1),]
# 
# 
# 
# 
# 
# ### Aggregate touchdowns
# Subset_TD_pbp_data <- select(TD_pbp_data, "game_id", "home_team", "away_team",
#                              "posteam", "home_score", "away_score",
#                              "game_date", "td_team")
# 
# TD_game_data <- data.frame(game_id = character(0),
#                            home_team = character(0),
#                            away_team = character(0),
#                            home_team_TD = character(0),
#                            away_team_TD = character(0),
#                            home_final_score = character(0),
#                            away_final_score = character(0),
#                            game_date = character(0))
# 
# for (game in unique(Subset_TD_pbp_data$game_id)) {
#   Subset_game_data <- Subset_TD_pbp_data[Subset_TD_pbp_data$game_id == game,]
#   
#   # count the number of touchdowns for each team
#   home_team_TD_count <- sum(Subset_game_data$td_team == Subset_game_data$home_team)
#   away_team_TD_count <- sum(Subset_game_data$td_team == Subset_game_data$away_team)
#   
#   game_data_row <- c(game_id = game,
#                      home_team = Subset_game_data$home_team[1],
#                      away_team = Subset_game_data$away_team[1],
#                      home_team_TD = home_team_TD_count,
#                      away_team_TD = away_team_TD_count,
#                      home_final_score = Subset_game_data$home_score[1],
#                      away_final_score = Subset_game_data$away_score[1],
#                      game_date = Subset_game_data$game_date[1])
#   
#   # add the touchdown counts to TD_game_data
#   TD_game_data <- rbind(TD_game_data, game_data_row)
# }
# 
# colnames(TD_game_data) <- c("game_id", "home_team",
#                             "away_team", "home_team_TD",
#                             "away_team_TD", "home_final_score",
#                             "away_final_score", "game_date")
# 
# 
# 
# ### Aggregate field goals
# Subset_FG_pbp_data <- select(FG_pbp_data, "game_id", "home_team", "away_team",
#                              "home_score", "away_score", "posteam", 
#                              "field_goal_result", "game_date")
# 
# FG_game_data <- data.frame(game_id = character(0),
#                            home_team = character(0),
#                            away_team = character(0),
#                            home_team_FG = character(0),
#                            home_team_FG_attempts = character(0),
#                            away_team_FG = character(0),
#                            away_team_FG_attempts = character(0),
#                            home_final_score = character(0),
#                            away_final_score = character(0),
#                            game_date = character(0))
# 
# for (game in unique(Subset_FG_pbp_data$game_id)) {
#   Subset_game_data <- Subset_FG_pbp_data[Subset_FG_pbp_data$game_id == game,]
#   
#   # count the number of field goals attempted and made
#   home_team_FG_count <- sum(Subset_game_data$posteam == Subset_game_data$home_team)
#   home_team_FG_made <- sum(Subset_game_data$posteam == Subset_game_data$home_team &
#                              Subset_game_data$field_goal_result == "made")
#   away_team_FG_count <- sum(Subset_game_data$posteam == Subset_game_data$away_team)
#   away_team_FG_made <- sum(Subset_game_data$posteam == Subset_game_data$away_team &
#                              Subset_game_data$field_goal_result == "made")
#   
#   game_data_row <- c(game_id = game,
#                      home_team = Subset_game_data$home_team[1],
#                      away_team = Subset_game_data$away_team[1],
#                      home_team_FG = home_team_FG_made,
#                      home_team_FG_attempts = home_team_FG_count,
#                      away_team_FG = away_team_FG_made,
#                      away_team_FG_attempts = away_team_FG_count,
#                      home_score = Subset_game_data$home_score[1],
#                      away_score = Subset_game_data$away_score[1],
#                      game_date = Subset_game_data$game_date[1])
#   
#   # add the field goals counts to FG_game_data
#   FG_game_data <- rbind(FG_game_data, game_data_row)
# }
# 
# colnames(FG_game_data) <- c("game_id", "home_team", "away_team",
#                             "home_team_FG", "home_team_FG_attempts",
#                             "away_team_FG", "away_team_FG_attempts",
#                             "home_score", "away_score", "game_date")
# 
# 
# 
# ### Aggregate extra points
# Subset_XP_pbp_data <- select(XP_pbp_data, "game_id", "home_team", "away_team",
#                              "home_score", "away_score", "posteam",
#                              "extra_point_result", "game_date")
# 
# XP_game_data <- data.frame(game_id = character(0),
#                            home_team = character(0),
#                            away_team = character(0),
#                            home_team_XP = character(0),
#                            home_team_XP_attempts = character(0),
#                            away_team_XP = character(0),
#                            away_team_XP_attempts = character(0),
#                            home_final_score = character(0),
#                            away_final_score = character(0),
#                            game_date = character(0))
# 
# for (game in unique(Subset_XP_pbp_data$game_id)) {
#   Subset_game_data <- Subset_XP_pbp_data[Subset_XP_pbp_data$game_id == game,]
#   
#   # count the number of field goals attempted and made
#   home_team_XP_count <- sum(Subset_game_data$posteam == Subset_game_data$home_team)
#   home_team_XP_made <- sum(Subset_game_data$posteam == Subset_game_data$home_team &
#                              Subset_game_data$extra_point_result == "good")
#   away_team_XP_count <- sum(Subset_game_data$posteam == Subset_game_data$away_team)
#   away_team_XP_made <- sum(Subset_game_data$posteam == Subset_game_data$away_team &
#                              Subset_game_data$extra_point_result == "good")
#   
#   game_data_row <- c(game_id = game,
#                      home_team = Subset_game_data$home_team[1],
#                      away_team = Subset_game_data$away_team[1],
#                      home_team_XP = home_team_XP_made,
#                      home_team_XP_attempts = home_team_XP_count,
#                      away_team_XP = away_team_XP_made,
#                      away_team_XP_attempts = away_team_XP_count,
#                      home_score = Subset_game_data$home_score[1],
#                      away_score = Subset_game_data$away_score[1],
#                      game_date = Subset_game_data$game_date[1])
#   
#   # add the extra point counts to XP_game_data
#   XP_game_data <- rbind(XP_game_data, game_data_row)
# }
# 
# colnames(XP_game_data) <- c("game_id", "home_team", "away_team",
#                             "home_team_XP", "home_team_XP_attempts",
#                             "away_team_XP", "away_team_XP_attempts",
#                             "home_score", "away_score", "game_date")
# 
# 
# 
# ### Aggregate two point conversions
# Subset_TWO_PT_pbp_data <- select(TWO_PT_pbp_data, "game_id", "home_team",
#                                  "away_team", "home_score",
#                                  "away_score", "posteam",
#                                  "two_point_conv_result",
#                                  "game_date")
# 
# TWO_PT_game_data <- data.frame(game_id = character(0),
#                                home_team = character(0),
#                                away_team = character(0),
#                                home_team_TWO_PT = character(0),
#                                home_team_TWO_PT_attempts = character(0),
#                                away_team_TWO_PT = character(0),
#                                away_team_TWO_PT_attempts = character(0),
#                                home_final_score = character(0),
#                                away_final_score = character(0),
#                                game_date = character(0))
# 
# for (game in unique(Subset_TWO_PT_pbp_data$game_id)) {
#   Subset_game_data <- Subset_TWO_PT_pbp_data[Subset_TWO_PT_pbp_data$game_id == game,]
#   
#   # count the number of field goals attempted and made
#   home_team_TWO_PT_count <- sum(Subset_game_data$posteam == Subset_game_data$home_team)
#   home_team_TWO_PT_made <- sum(Subset_game_data$posteam == Subset_game_data$home_team &
#                                  Subset_game_data$two_point_conv_result == "success")
#   away_team_TWO_PT_count <- sum(Subset_game_data$posteam == Subset_game_data$away_team)
#   away_team_TWO_PT_made <- sum(Subset_game_data$posteam == Subset_game_data$away_team &
#                                  Subset_game_data$two_point_conv_result == "success")
#   
#   game_data_row <- c(game_id = game,
#                      home_team = Subset_game_data$home_team[1],
#                      away_team = Subset_game_data$away_team[1],
#                      home_team_TWO_PT = home_team_TWO_PT_made,
#                      home_team_TWO_PT_attempts = home_team_TWO_PT_count,
#                      away_team_TWO_PT = away_team_TWO_PT_made,
#                      away_team_TWO_PT_attempts = away_team_TWO_PT_count,
#                      home_score = Subset_game_data$home_score[1],
#                      away_score = Subset_game_data$away_score[1],
#                      game_date = Subset_game_data$game_date[1])
#   
#   # add the two point conversion counts to TWO_PT_game_data
#   TWO_PT_game_data <- rbind(TWO_PT_game_data, game_data_row)
# }
# 
# colnames(TWO_PT_game_data) <- c("game_id", "home_team", "away_team",
#                                 "home_team_TWO_PT", "home_team_TWO_PT_attempts",
#                                 "away_team_TWO_PT", "away_team_TWO_PT_attempts",
#                                 "home_score", "away_score", "game_date")
# 
# 
# ### Aggregate safeties
# Subset_SAFETY_pbp_data <- select(SAFETY_pbp_data, "game_id", "home_team",
#                                  "away_team", "defteam",
#                                  "home_score", "away_score",
#                                  "game_date")
# 
# SAFETY_game_data <- data.frame(game_id = character(0),
#                                home_team = character(0),
#                                away_team = character(0),
#                                home_team_SAFETY = character(0),
#                                away_team_SAFETY = character(0),
#                                home_final_score = character(0),
#                                away_final_score = character(0),
#                                game_date = character(0))
# 
# for (game in unique(Subset_SAFETY_pbp_data$game_id)) {
#   Subset_game_data <- Subset_SAFETY_pbp_data[Subset_SAFETY_pbp_data$game_id == game,]
#   
#   # count the number of touchdowns for each team
#   home_team_SAFETY_count <- sum(Subset_game_data$defteam == Subset_game_data$home_team)
#   away_team_SAFETY_count <- sum(Subset_game_data$defteam == Subset_game_data$away_team)
#   
#   game_data_row <- c(game_id = game,
#                      home_team = Subset_game_data$home_team[1],
#                      away_team = Subset_game_data$away_team[1],
#                      home_team_SAFETY = home_team_SAFETY_count,
#                      away_team_SAFETY = away_team_SAFETY_count,
#                      home_final_score = Subset_game_data$home_score[1],
#                      away_final_score = Subset_game_data$away_score[1],
#                      game_date = Subset_game_data$game_date[1])
#   
#   # add the touchdown counts to TD_game_data
#   SAFETY_game_data <- rbind(SAFETY_game_data, game_data_row)
# }
# 
# colnames(SAFETY_game_data) <- c("game_id", "home_team",
#                                 "away_team", "home_team_SAFETY",
#                                 "away_team_SAFETY", "home_final_score",
#                                 "away_final_score", "game_date")
# 
# 
# 
# ### join all the dataframes and clean up
# game_data <- left_join(TD_game_data, FG_game_data, by = "game_id") %>%
#   left_join(., XP_game_data, by = "game_id") %>%
#   left_join(., TWO_PT_game_data, by = "game_id") %>%
#   left_join(., SAFETY_game_data, by = "game_id") %>%
#   mutate_all(~replace(., is.na(.), 0))
# 
# game_data <- select(game_data, "game_id", "game_date.x", "home_team.x",
#                     "away_team.x", "home_final_score.x",
#                     "away_final_score.x", "home_team_TD",
#                     "away_team_TD", "home_team_FG",
#                     "home_team_FG_attempts", "away_team_FG",
#                     "away_team_FG_attempts", "home_team_XP",
#                     "home_team_XP_attempts", "away_team_XP",
#                     "away_team_XP_attempts", "home_team_TWO_PT",
#                     "home_team_TWO_PT_attempts", "away_team_TWO_PT",
#                     "away_team_TWO_PT_attempts", "home_team_SAFETY",
#                     "away_team_SAFETY")
# 
# colnames(game_data) <- c("game_id", "game_date", "home_team",
#                          "away_team", "home_final_score",
#                          "away_final_score", "home_team_TD",
#                          "away_team_TD", "home_team_FG",
#                          "home_team_FG_attempts", "away_team_FG",
#                          "away_team_FG_attempts", "home_team_XP",
#                          "home_team_XP_attempts", "away_team_XP",
#                          "away_team_XP_attempts", "home_team_TWO_PT",
#                          "home_team_TWO_PT_attempts", "away_team_TWO_PT",
#                          "away_team_TWO_PT_attempts", "home_team_SAFETY",
#                          "away_team_SAFETY")
