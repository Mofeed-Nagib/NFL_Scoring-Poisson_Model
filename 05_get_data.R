### This script reads in the raw NFL play-by-play files downloaded from the nflfastR
### package (https://github.com/nflverse/nflverse-data/releases/tag/pbp) and betting data
### downloaded from (https://www.kaggle.com/datasets/tobycrabtree/nfl-scores-and-betting-data)


###########################
#--- Game Scoring Data ---#
###########################

# load in play-by-play data for every season (1999 - present)
pbp_data <- load_pbp(seasons = TRUE)

# save raw play-by-play data
saveRDS(pbp_data, file = "rawdata/raw_play-by-play.RDS")

# initialize empty dataframe to store aggregated game data
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

# loop through the number of unique game_id's
for (i in 1:length(unique(pbp_data$game_id))) {
  
  # extract the game_id at the current index
  game_id <- unique(pbp_data$game_id)[i]
  
  # print the current game_id
  cat(game_id, '')
  
  # subset the play-by-play data for just the current game_id
  subset_game_data <- pbp_data[pbp_data$game_id == game_id,]
  
  # extract the home team, away team, game date, home final score & away final score
  home_team <- subset_game_data$home_team[1]
  away_team <- subset_game_data$away_team[1]
  game_date <- subset_game_data$game_date[1]
  home_final_score <- subset_game_data$home_score[1]
  away_final_score <- subset_game_data$away_score[1]
  
  # count the number of touchdowns
  home_team_TD_count <- nrow(subset_game_data[(!is.na(subset_game_data$touchdown) &
                                               subset_game_data$touchdown == 1 &
                                               subset_game_data$td_team == home_team),])
  
  away_team_TD_count <- nrow(subset_game_data[(!is.na(subset_game_data$touchdown) &
                                               subset_game_data$touchdown == 1 &
                                               subset_game_data$td_team == away_team),])
  
  # count the number of field goals attempted
  home_team_FG_count <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                               subset_game_data$field_goal_attempt == 1 &
                                               subset_game_data$posteam == home_team),])
  
  away_team_FG_count <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                               subset_game_data$field_goal_attempt == 1 &
                                               subset_game_data$posteam == away_team),])
  
  # count the number of field goals made
  home_team_FG_made <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                              subset_game_data$field_goal_attempt == 1 &
                                              subset_game_data$posteam == home_team &
                                              subset_game_data$field_goal_result == "made"),])
  
  away_team_FG_made <- nrow(subset_game_data[(!is.na(subset_game_data$field_goal_attempt) &
                                              subset_game_data$field_goal_attempt == 1 &
                                              subset_game_data$posteam == away_team &
                                              subset_game_data$field_goal_result == "made"),])
  
  # count the number of extra points attempted
  home_team_XP_count <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                               subset_game_data$extra_point_attempt == 1 &
                                               subset_game_data$posteam == home_team),])
  
  away_team_XP_count <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                               subset_game_data$extra_point_attempt == 1 &
                                               subset_game_data$posteam == away_team),])
  
  # count the number of extra points made
  home_team_XP_made <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                              subset_game_data$extra_point_attempt == 1 &
                                              subset_game_data$posteam == home_team &
                                              subset_game_data$extra_point_result == "good"),])
  
  away_team_XP_made <- nrow(subset_game_data[(!is.na(subset_game_data$extra_point_attempt) &
                                              subset_game_data$extra_point_attempt == 1 &
                                              subset_game_data$posteam == away_team &
                                              subset_game_data$extra_point_result == "good"),])
  
  # count the number of two point conversions attempted
  home_team_TWO_PT_count <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                   subset_game_data$two_point_attempt == 1 &
                                                   subset_game_data$posteam == home_team),])
  
  away_team_TWO_PT_count <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                   subset_game_data$two_point_attempt == 1 &
                                                   subset_game_data$posteam == away_team),])
  
  # count the number of successful two point conversions
  home_team_TWO_PT_made <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                  subset_game_data$two_point_attempt == 1 &
                                                  subset_game_data$posteam == home_team &
                                                  subset_game_data$two_point_conv_result == "success"),])
  
  away_team_TWO_PT_made <- nrow(subset_game_data[(!is.na(subset_game_data$two_point_attempt) &
                                                  subset_game_data$two_point_attempt == 1 &
                                                  subset_game_data$posteam == away_team &
                                                  subset_game_data$two_point_conv_result == "success"),])
  
  # count the number of safeties
  home_team_SAFETY_count <- 0
  away_team_SAFETY_count <- 0
  
  SAFETY <- subset_game_data[(!is.na(subset_game_data$safety) & subset_game_data$safety == 1),]
  if (nrow(SAFETY) > 0) {
    for (i in 1:nrow(SAFETY)) {
      index <- which(subset_game_data$play_id == SAFETY[i,]$play_id)
      if (subset_game_data[index - 1,]$total_home_score < subset_game_data[index,]$total_home_score) {
        home_team_SAFETY_count <- home_team_SAFETY_count + 1
      }
      else if (subset_game_data[index - 1,]$total_away_score < subset_game_data[index,]$total_away_score) {
        away_team_SAFETY_count <- away_team_SAFETY_count + 1
      }
    }
  }
  
  # combine aggregated data for that game_id into a vector
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
  
  # rbind that vector to the game_data dataframe
  game_data <- rbind(game_data, game_data_row)
}

# rename columns appropriately
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

# convert columns to desired data type
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
game_data$season <- as.integer(substr(game_data$game_id, start = 1, stop = 4))
game_data <- game_data %>%
             relocate(season, .after = game_date)

# verify aggregated data for the home team
game_data$calculated_home_final_score <- 6 * game_data$home_TD_count +
                                         3 * game_data$home_FG_count +
                                         1 * game_data$home_XP_count +
                                         2 * game_data$home_TWO_PT_count +
                                         2 * game_data$home_SAFETY_count

# verify aggregated data for the away team
game_data$calculated_away_final_score <- 6 * game_data$away_TD_count +
                                         3 * game_data$away_FG_count +
                                         1 * game_data$away_XP_count +
                                         2 * game_data$away_TWO_PT_count +
                                         2 * game_data$away_SAFETY_count

# extract the games where the manually calculated final scores from the aggregated
# data do not match (essentially the games with defensive two point conversions)
bad_home <- game_data[game_data$home_final_score != game_data$calculated_home_final_score,]
bad_away <- game_data[game_data$away_final_score != game_data$calculated_away_final_score,]

# drop the games where the manually calculated final scores do not match
game_data <- game_data[!(game_data$game_id %in% bad_home$game_id) &
                       !(game_data$game_id %in% bad_away$game_id),]

# drop the manually calculated final score columns
game_data <- game_data %>% select(-c(calculated_home_final_score,
                                     calculated_away_final_score))


##################################
#--- Game Betting Market Data ---#
##################################

# read betting data and corresponding team dictionary data
betting_data <- read_csv("rawdata/nfl_betting.csv")
nfl_team <- read_csv("rawdata/nfl_teams.csv")

# extract betting data since 1999 that are not NAs and drop unnecessary columns
betting_data <- betting_data[betting_data$schedule_season >= 1999 &
                             !(is.na(betting_data$team_favorite_id)),] %>%
                select(-c(schedule_season, schedule_week, schedule_playoff,
                          score_home, score_away, stadium, stadium_neutral,
                          weather_temperature, weather_wind_mph,
                          weather_humidity, weather_detail))

# convert columns to desired data type
betting_data$schedule_date <- as.Date(betting_data$schedule_date, "%m/%d/%y")

# make favorite team names consistent with game data abbreviation convention
betting_data[betting_data$team_favorite_id == "LVR",]$team_favorite_id <- "LV"
betting_data[betting_data$team_favorite_id == "LAR",]$team_favorite_id <- "LA"

# extract team name and abbreviation from team dictionary data
nfl_team <- nfl_team %>%
            select(team_name, team_id)

# make team names consistent with game data abbreviation convention
nfl_team[nfl_team$team_id == "LVR",]$team_id <- "LV"
nfl_team[nfl_team$team_id == "LAR",]$team_id <- "LA"

# merge updated team names into betting data and dropping old names
betting_data <- betting_data %>%
                merge(nfl_team, by.x = "team_home", by.y = "team_name") %>%
                select(-team_home) %>%
                rename(team_home = team_id) %>%
                merge(nfl_team, by.x = "team_away", by.y = "team_name") %>%
                select(-team_away) %>%
                rename(team_away = team_id)

# drop games where point spread is 0 (i.e. essentially a moneyline bets)
betting_data <- betting_data[!(betting_data$team_favorite_id == "PICK"),]

# fix specific game_ids
# 1999-2000 Superbowl
betting_data[betting_data$schedule_date == "2000-01-30",]$team_home <- "TEN"
betting_data[betting_data$schedule_date == "2000-01-30",]$team_away <- "LA"
# 2000-2001 Superbowl
betting_data[betting_data$schedule_date == "2001-01-28",]$team_home <- "NYG"
betting_data[betting_data$schedule_date == "2001-01-28",]$team_away <- "BAL"
# 2001-2002 Superbowl
betting_data[betting_data$schedule_date == "2002-02-03",]$team_home <- "NE"
betting_data[betting_data$schedule_date == "2002-02-03",]$team_away <- "LA"
# 2002-2003 Superbowl
betting_data[betting_data$schedule_date == "2003-01-26",]$team_home <- "TB"
betting_data[betting_data$schedule_date == "2003-01-26",]$team_away <- "LV"
# 2006-2007 Superbowl
betting_data[betting_data$schedule_date == "2007-02-04",]$team_home <- "CHI"
betting_data[betting_data$schedule_date == "2007-02-04",]$team_away <- "IND"


########################################
#--- Combined Game and Betting Data ---#
########################################

# merge the game and betting dataset by common columns (game date, home team, away team)
game_betting <- game_data %>% 
                merge(betting_data, by.x = c("game_date", "home_team", "away_team"),
                      by.y = c("schedule_date", "team_home", "team_away")) %>%
                relocate(game_date, game_id, season)
  
# drop games that do not have betting data available
game_betting <- game_betting[!is.na(game_betting$team_favorite_id),]

# save combined game and betting data to RDS
saveRDS(game_betting, file = "data/game_betting_data.RDS")
