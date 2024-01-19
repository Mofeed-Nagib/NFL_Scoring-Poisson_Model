### Explore the aggregated touchdown, field goal, extra point, two point 
### conversion and safety data

# read combined game and betting data
game_betting <- readRDS("data/game_betting_data.RDS")

#========================#
#=== Data Exploration ===#
#========================#

# summary statistics for numerical variables
game_betting %>%
select(-c(game_id, home_team, away_team, 
          home_final_score, away_final_score, 
          team_favorite_id)) %>%
summary()

# create new dataframe with aggregated scoring events
score_events <- data.frame(cbind(TD = c(game_betting$home_TD_count, game_betting$away_TD_count),
                                 FG = c(game_betting$home_FG_count, game_betting$away_FG_count),
                                 XP = c(game_betting$home_XP_count, game_betting$away_XP_count),
                                 TWO_PT = c(game_betting$home_TWO_PT_count, game_betting$away_TWO_PT_count),
                                 SAFETY = c(game_betting$home_SAFETY_count, game_betting$away_SAFETY_count),
                                 row.names = NULL))

# subset game_betting dataframe to aggregated scoring events by team
team_score_events <- game_betting %>%
                     select(c(home_TD_count, away_TD_count,
                              home_FG_count, away_FG_count,
                              home_XP_count, away_XP_count,
                              home_TWO_PT_count, away_TWO_PT_count,
                              home_SAFETY_count, away_SAFETY_count))

# visualize correlation matrices (scoring events and scoring events by teams)
corrplot.mixed(cor(score_events), upper = "ellipse")
corrplot.mixed(cor(team_score_events), upper = "ellipse", tl.cex = 0.6)

#============================#
#=== Touchdown Histograms ===#
#============================#

# visualize the number of touchdowns (appears to be poisson)
ggplot(data = data.frame(TD = score_events$TD),
       aes(x = TD)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Touchdowns in NFL Games",
       x = "Number of Touchdowns",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# visualize touchdown density distribution with poisson overlay
ggplot(data = data.frame(TD = score_events$TD),
       aes(x = TD, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Touchdowns in NFL Games (w/ Poisson Overlay)",
       x = "Number of Touchdowns",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  geom_point(data = data.frame(x = 0:10, y = dpois(0:10, lambda = mean(score_events$TD))),
             aes(x = x, y = y), color = 'red', size = 3)

#=============================#
#=== Field Goal Histograms ===#
#=============================#

# visualize the number of field goals (appears to be poisson)
ggplot(data = data.frame(field_goals = score_events$FG),
       aes(x = field_goals)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Field Goals in NFL Games",
       x = "Number of Field Goals",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 8, by = 2))

# visualize field goal distribution with poisson overlay
ggplot(data = data.frame(field_goals = score_events$FG),
       aes(x = field_goals, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Field Goals in NFL Games (w/ Poisson Overlay)",
       x = "Number of Field Goals",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 8, by = 2)) +
  geom_point(data = data.frame(x = 0:8, y = dpois(0:8, lambda = mean(score_events$FG))),
             aes(x = x, y = y), color = 'red', size = 3)

#==============================#
#=== Extra Point Histograms ===#
#==============================#

# visualize the number of extra points (appears to be poisson)
ggplot(data = data.frame(extra_points = score_events$XP),
       aes(x = extra_points)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Extra Points in NFL Games",
       x = "Number of Extra Points",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# visualize extra point distribution with poisson overlay
ggplot(data = data.frame(extra_points = score_events$XP),
       aes(x = extra_points, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Extra Points in NFL Games (w/ Poisson Overlay)",
       x = "Number of Extra Points",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  geom_point(data = data.frame(x = 0:10, y = dpois(0:10, lambda = mean(score_events$XP))),
             aes(x = x, y = y), color = 'red', size = 3)

#=================================#
#=== Two Conversion Histograms ===#
#=================================#

# visualize the number of two point conversions (appears to be poisson)
ggplot(data = data.frame(two_points = score_events$TWO_PT), 
       aes(x = two_points)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Two Point Conversions in NFL Games",
       x = "Number of Two Point Conversions",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 4, by = 1))

# visualize two point conversion distribution with poisson overlay
ggplot(data = data.frame(two_points = score_events$TWO_PT), 
       aes(x = two_points, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Two Point Conversions in NFL Games (w/ Poisson Overlay)",
       x = "Number of Two Point Conversions",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 4, by = 1)) +
  geom_point(data = data.frame(x = 0:4, y = dpois(0:4, lambda = mean(score_events$TWO_PT))),
             aes(x = x, y = y), color = 'red', size = 3)

#=========================#
#=== Safety Histograms ===#
#=========================#

# visualize the number of safeties (appears to be poisson)
ggplot(data = data.frame(safety = score_events$SAFETY), 
       aes(x = safety)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Safeties in NFL Games",
       x = "Number of Safeties",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 2, by = 1))

# visualize safety distribution with poisson overlay
ggplot(data = data.frame(safety = score_events$SAFETY), 
       aes(x = safety, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Safeties in NFL Games (w/ Poisson Overlay)",
       x = "Number of Safeties",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 2, by = 1)) +
  geom_point(data = data.frame(x = 0:2, y = dpois(0:2, lambda = mean(score_events$SAFETY))),
             aes(x = x, y = y), color = 'red', size = 3)



#=======================================#
#=== Touchdown Pairwise Scatterplots ===#
#=======================================#

# visualize the number of touchdowns vs. field goals (appears to be negatively correlated)
ggplot(game_betting, aes(x = home_TD_count, y = home_FG_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_TD_count, y = away_FG_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Field Goals in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Field Goals") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# visualize the number of touchdowns vs. extra points (appears to be positively correlated)
ggplot(game_betting, aes(x = home_TD_count, y = home_XP_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_TD_count, y = away_XP_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Extra Points in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Extra Points") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  scale_y_continuous(breaks = seq(0, 10, by = 2))

# visualize the number of touchdowns vs. two point conversions
ggplot(game_betting, aes(x = home_TD_count, y = home_TWO_PT_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_TD_count, y = away_TWO_PT_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Two Point Conversions in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Two Point Conversions") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize the number of touchdowns vs. safeties
ggplot(game_betting, aes(x = home_TD_count, y = home_SAFETY_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_TD_count, y = away_SAFETY_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Safeties in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  scale_y_continuous(breaks = seq(0, 2, by = 1))

#========================================#
#=== Field Goal Pairwise Scatterplots ===#
#========================================#

# visualize the number of field goals vs. extra points (appears to be negatively correlated)
ggplot(game_betting, aes(x = home_FG_count, y = home_XP_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_FG_count, y = away_XP_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Field Goals vs Extra Points in NFL Games",
       x = "Number of Field Goals",
       y = "Number of Extra Points") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  scale_y_continuous(breaks = seq(0, 10, by = 2))

# visualize the number of field goals vs. two point conversions (appear to be negatively correlated)
ggplot(game_betting, aes(x = home_FG_count, y = home_TWO_PT_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_FG_count, y = away_TWO_PT_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Field Goals vs Two Point Conversions in NFL Games",
       x = "Number of Field Goals",
       y = "Number of Two Point Conversions") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# visualize the number of field goals vs. safeties
ggplot(game_betting, aes(x = home_FG_count, y = home_SAFETY_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_FG_count, y = away_SAFETY_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Field Goals vs Safeties in NFL Games",
       x = "Number of Field Goals",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  scale_y_continuous(breaks = seq(0, 2, by = 1))

#=========================================#
#=== Extra Point Pairwise Scatterplots ===#
#=========================================#

# visualize the number of extra points vs. two point conversions (appear to be negatively correlated)
ggplot(game_betting, aes(x = home_XP_count, y = home_TWO_PT_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_XP_count, y = away_TWO_PT_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Extra Points vs Two Point Conversions in NFL Games",
       x = "Number of Extra Points",
       y = "Number of Two Point Conversions") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# visualize the number of extra points vs. safeties
ggplot(game_betting, aes(x = home_XP_count, y = home_SAFETY_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_XP_count, y = away_SAFETY_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Extra Points vs Safeties in NFL Games",
       x = "Number of Extra Points",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  scale_y_continuous(breaks = seq(0, 2, by = 1))

#===================================================#
#=== Two Point Conversions Pairwise Scatterplots ===#
#===================================================#

# visualize the number of two point conversions vs. safeties (appear to be negatively correlated)
ggplot(game_betting, aes(x = home_TWO_PT_count, y = home_SAFETY_count)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_TWO_PT_count, y = away_SAFETY_count), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Two Point Conversions vs Safeties in NFL Games",
       x = "Number of Two Point Conversions",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  scale_y_continuous(breaks = seq(0, 2, by = 1))
