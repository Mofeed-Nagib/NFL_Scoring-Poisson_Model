### This script reads in the raw NFL play-by-play files downloaded from the
### nflfastR package (https://github.com/nflverse/nflverse-data/releases/tag/pbp)

# TODO: Need to catch sum of field goal and two point attempts doesn't equal
# number of touchdowns (might be because some of the overtime scores don't count)
# TODO: Need to catch defensive two point conversions and defensive safeties

# load in play-by-play data for every season (1999 - Present)
pbp_data <- load_pbp(seasons = TRUE)

saveRDS(pbp_data, file = "data/raw_play-by-play_data.RDS")

game_data <- data.frame(game_id = character(0), game_date = character(0),
                        home_team = character(0), away_team = character(0),
                        home_final_score = character(0), away_final_score = character(0),
                        home_TD_count = character(0), away_TD_count = character(0),
                        home_FG_count = character(0), home_FG_attempts = character(0),
                        away_FG_count = character(0), away_FG_attempts = character(0),
                        home_XP_count = character(0), home_XP_attempts = character(0),
                        away_XP_count = character(0), away_XP_attempts = character(0),
                        home_TWO_PT_count = character(0), home_TWO_PT_attempts = character(0),
                        away_TWO_PT_count = character(0), away_TWO_PT_attempts = character(0),
                        home_SAFETY_count = character(0), away_SAFETY_count = character(0))

for (i in 1:length(unique(pbp_data$game_id))) {
  
  game_id <- unique(pbp_data$game_id)[i]
  
  cat(game_id, '')
  
  subset_game_data <- pbp_data[pbp_data$game_id == game_id,]
  # subset_game_data <- subset_game_data[!duplicated(subset_game_data$play_id),]
  
  home_team <- subset_game_data$home_team[1]
  away_team <- subset_game_data$away_team[1]
  game_date <- subset_game_data$game_date[1]
  home_final_score <- subset_game_data$home_score[1]
  away_final_score <- subset_game_data$away_score[1]
  
  # count the number of touchdowns for each team
  home_team_TD_count <- nrow(subset_game_data[(!is.na(subset_game_data$touchdown) &
                                                 subset_game_data$touchdown == 1 &
                                                 subset_game_data$td_team == home_team),])
  
  away_team_TD_count <- nrow(subset_game_data[(!is.na(subset_game_data$touchdown) &
                                                 subset_game_data$touchdown == 1 &
                                                 subset_game_data$td_team == away_team),])
  
  # count the number of field goals attempted and made
  home_team_FG_count <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                                 subset_game_data$field_goal_attempt == 1 &
                                                 subset_game_data$posteam == home_team),])
  
  home_team_FG_made <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                                subset_game_data$field_goal_attempt == 1 &
                                                subset_game_data$posteam == home_team &
                                                subset_game_data$field_goal_result == "made"),])
  
  away_team_FG_count <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                                 subset_game_data$field_goal_attempt == 1 &
                                                 subset_game_data$posteam == away_team),])
  
  away_team_FG_made <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                                subset_game_data$field_goal_attempt == 1 &
                                                subset_game_data$posteam == away_team &
                                                subset_game_data$field_goal_result == "made"),])
  
  # count the number of field goals attempted and made
  home_team_XP_count <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                                 subset_game_data$extra_point_attempt == 1 &
                                                 subset_game_data$posteam == home_team),])
  
  home_team_XP_made <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                                subset_game_data$extra_point_attempt == 1 &
                                                subset_game_data$posteam == home_team &
                                                subset_game_data$extra_point_result == "good"),])
  
  away_team_XP_count <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                                 subset_game_data$extra_point_attempt == 1 &
                                                 subset_game_data$posteam == away_team),])
  
  away_team_XP_made <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                                subset_game_data$extra_point_attempt == 1 &
                                                subset_game_data$posteam == away_team &
                                                subset_game_data$extra_point_result == "good"),])
  
  # count the number of two point attempted and made
  home_team_TWO_PT_count <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                     subset_game_data$two_point_attempt == 1 &
                                                     subset_game_data$posteam == home_team),])
  
  home_team_TWO_PT_made <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                    subset_game_data$two_point_attempt == 1 &
                                                    subset_game_data$posteam == home_team &
                                                    subset_game_data$two_point_conv_result == "success"),])
  
  away_team_TWO_PT_count <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                     subset_game_data$two_point_attempt == 1 &
                                                     subset_game_data$posteam == away_team),])
  
  away_team_TWO_PT_made <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                    subset_game_data$two_point_attempt == 1 &
                                                    subset_game_data$posteam == away_team &
                                                    subset_game_data$two_point_conv_result == "success"),])
  
  # count the number of touchdowns for each team
  home_team_SAFETY_count <- nrow(subset_game_data[(!is.na(subset_game_data$safety) &
                                                     subset_game_data$safety == 1 &
                                                     subset_game_data$defteam == home_team),])
  
  away_team_SAFETY_count <- nrow(subset_game_data[(!is.na(subset_game_data$safety) &
                                                     subset_game_data$safety == 1 &
                                                     subset_game_data$defteam == away_team),])
  
  game_data_row <- c(game_id = game_id,
                     game_date = game_date,
                     home_team = home_team,
                     away_team = away_team,
                     home_final_score = home_final_score,
                     away_final_score = away_final_score,
                     home_TD_count = home_team_TD_count,
                     away_TD_count = away_team_TD_count,
                     home_FG_count = home_team_FG_made,
                     home_FG_attempts = home_team_FG_count,
                     away_FG_count = away_team_FG_made,
                     away_FG_attempts = away_team_FG_count,
                     home_XP_count = home_team_XP_made,
                     home_XP_attempts = home_team_XP_count,
                     away_XP_count = away_team_XP_made,
                     away_XP_attempts = away_team_XP_count,
                     home_TWO_PT_count = home_team_TWO_PT_made,
                     home_TWO_PT_attempts = home_team_TWO_PT_count,
                     away_TWO_PT_count = away_team_TWO_PT_made,
                     away_TWO_PT_attempts = away_team_TWO_PT_count,
                     home_SAFETY_count = home_team_SAFETY_count,
                     away_SAFETY_count = away_team_SAFETY_count)
  
  game_data <- rbind(game_data, game_data_row)
}

colnames(game_data) <- c("game_id", "game_date", "home_team", "away_team",
                         "home_final_score", "away_final_score",
                         "home_TD_count", "away_TD_count",
                         "home_FG_count", "home_FG_attempts",
                         "away_FG_count", "away_FG_attempts",
                         "home_XP_count", "home_XP_attempts",
                         "away_XP_count", "away_XP_attempts",
                         "home_TWO_PT_count", "home_TWO_PT_attempts",
                         "away_TWO_PT_count", "away_TWO_PT_attempts",
                         "home_SAFETY_count", "away_SAFETY_count")

# Convert columns to desired data type
game_data$game_date <- as.Date(game_data$game_date)
game_data$home_final_score <- as.integer(game_data$home_final_score)
game_data$away_final_score <- as.integer(game_data$away_final_score)
game_data$home_TD_count <- as.integer(game_data$home_TD_count)
game_data$away_TD_count <- as.integer(game_data$away_TD_count)
game_data$home_FG_count <- as.integer(game_data$home_FG_count)
game_data$home_FG_attempts <- as.integer(game_data$home_FG_attempts)
game_data$away_FG_count <- as.integer(game_data$away_FG_count)
game_data$away_FG_attempts <- as.integer(game_data$away_FG_attempts)
game_data$home_XP_count <- as.integer(game_data$home_XP_count)
game_data$home_XP_attempts <- as.integer(game_data$home_XP_attempts)
game_data$away_XP_count <- as.integer(game_data$away_XP_count)
game_data$away_XP_attempts <- as.integer(game_data$away_XP_attempts)
game_data$home_TWO_PT_count <- as.integer(game_data$home_TWO_PT_count)
game_data$home_TWO_PT_attempts <- as.integer(game_data$home_TWO_PT_attempts)
game_data$away_TWO_PT_count <- as.integer(game_data$away_TWO_PT_count)
game_data$away_TWO_PT_attempts <- as.integer(game_data$away_TWO_PT_attempts)
game_data$home_SAFETY_count <- as.integer(game_data$home_SAFETY_count)
game_data$away_SAFETY_count <- as.integer(game_data$away_SAFETY_count)

# Add new season variable column and place it after game_date column
game_data$season <- as.integer(format(game_data$game_date, "%Y"))
game_data <- game_data %>%
             relocate(season, .after = game_date)

# Verify aggregated data for the home team
game_data$calculated_home_final_score <- 6 * game_data$home_TD_count +
                                         3 * game_data$home_FG_count +
                                         1 * game_data$home_XP_count +
                                         2 * game_data$home_TWO_PT_count +
                                         2 * game_data$home_SAFETY_count

# Verify aggregated data for the away team
game_data$calculated_away_final_score <- 6 * game_data$away_TD_count +
                                         3 * game_data$away_FG_count +
                                         1 * game_data$away_XP_count +
                                         2 * game_data$away_TWO_PT_count +
                                         2 * game_data$away_SAFETY_count

bad_home <- game_data[game_data$home_final_score != game_data$calculated_home_final_score,]
bad_away <- game_data[game_data$away_final_score != game_data$calculated_away_final_score,]

game_data <- game_data[!(game_data$game_id %in% bad_home$game_id) &
                       !(game_data$game_id %in% bad_away$game_id),]

saveRDS(game_data, file = "data/aggregate_game_data.RDS")
