### Explore the aggregated touchdown, field goal, extra point, two point conversion
### and safety data

#============================#
#=== Touchdown Histograms ===#
#============================#

# Visualize the number of touchdowns (appears to be poisson)
ggplot(data = data.frame(touchdowns = c(game_data$home_team_TD, game_data$away_team_TD)), 
       aes(x = touchdowns)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Touchdowns in NFL Games",
       x = "Number of Touchdowns",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize touchdown density distribution with poisson overlay
ggplot(data = data.frame(touchdowns = c(game_data$home_team_TD, game_data$away_team_TD)), 
       aes(x = touchdowns, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Touchdowns in NFL Games (w/ Poisson Overlay)",
       x = "Number of Touchdowns",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  geom_point(data = data.frame(x = 0:10, y = dpois(0:10, lambda = mean(c(game_data$home_team_TD, game_data$away_team_TD)))),
             aes(x = x, y = y), color = 'red', size = 3)

#=============================#
#=== Field Goal Histograms ===#
#=============================#

# Visualize the number of field goals (appears to be poisson)
ggplot(data = data.frame(field_goals = c(game_data$home_team_FG, game_data$away_team_FG)), 
       aes(x = field_goals)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Field Goals in NFL Games",
       x = "Number of Field Goals",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 8, by = 2))

# Visualize field goal distribution with poisson overlay
ggplot(data = data.frame(field_goals = c(game_data$home_team_FG, game_data$away_team_FG)), 
       aes(x = field_goals, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Field Goals in NFL Games (w/ Poisson Overlay)",
       x = "Number of Field Goals",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 8, by = 2)) +
  geom_point(data = data.frame(x = 0:8, y = dpois(0:8, lambda = mean(c(game_data$home_team_FG, game_data$away_team_FG)))),
             aes(x = x, y = y), color = 'red', size = 3)

#==============================#
#=== Extra Point Histograms ===#
#==============================#

# Visualize the number of extra points (appears to be poisson)
ggplot(data = data.frame(extra_points = c(game_data$home_team_XP, game_data$away_team_XP)), 
       aes(x = extra_points)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Extra Points in NFL Games",
       x = "Number of Extra Points",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize extra point distribution with poisson overlay
ggplot(data = data.frame(extra_points = c(game_data$home_team_XP, game_data$away_team_XP)), 
       aes(x = extra_points, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Extra Points in NFL Games (w/ Poisson Overlay)",
       x = "Number of Extra Points",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  geom_point(data = data.frame(x = 0:10, y = dpois(0:10, lambda = mean(c(game_data$home_team_XP, game_data$away_team_XP)))),
             aes(x = x, y = y), color = 'red', size = 3)

#=================================#
#=== Two Conversion Histograms ===#
#=================================#

# Visualize the number of two point conversions (appears to be poisson)
ggplot(data = data.frame(two_points = c(game_data$home_team_TWO_PT, game_data$away_team_TWO_PT)), 
       aes(x = two_points)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Two Point Conversions in NFL Games",
       x = "Number of Two Point Conversions",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 4, by = 1))

# Visualize two point conversion distribution with poisson overlay
ggplot(data = data.frame(two_points = c(game_data$home_team_TWO_PT, game_data$away_team_TWO_PT)), 
       aes(x = two_points, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Two Point Conversions in NFL Games (w/ Poisson Overlay)",
       x = "Number of Two Point Conversions",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 4, by = 1)) +
  geom_point(data = data.frame(x = 0:4, y = dpois(0:4, lambda = mean(c(game_data$home_team_TWO_PT, game_data$away_team_TWO_PT)))),
             aes(x = x, y = y), color = 'red', size = 3)

#=========================#
#=== Safety Histograms ===#
#=========================#

# Visualize the number of safeties (appears to be poisson)
ggplot(data = data.frame(safety = c(game_data$home_team_SAFETY, game_data$away_team_SAFETY)), 
       aes(x = safety)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Safeties in NFL Games",
       x = "Number of Safeties",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 2, by = 1))

# Visualize safety distribution with poisson overlay
ggplot(data = data.frame(safety = c(game_data$home_team_SAFETY, game_data$away_team_SAFETY)), 
       aes(x = safety, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Safeties in NFL Games (w/ Poisson Overlay)",
       x = "Number of Safeties",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 2, by = 1)) +
  geom_point(data = data.frame(x = 0:2, y = dpois(0:2, lambda = mean(c(game_data$home_team_SAFETY, game_data$away_team_SAFETY)))),
             aes(x = x, y = y), color = 'red', size = 3)



#=======================================#
#=== Touchdown Pairwise Scatterplots ===#
#=======================================#

# Visualize the number of touchdowns vs. field goals (appears to be negatively correlated)
ggplot(game_data, aes(x = home_team_TD, y = home_team_FG)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_TD, y = away_team_FG), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Field Goals in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Field Goals") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize the number of touchdowns vs. extra points (appears to be positively correlated)
ggplot(game_data, aes(x = home_team_TD, y = home_team_XP)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_TD, y = away_team_XP), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Extra Points in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Extra Points") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize the number of touchdowns vs. two point conversions
ggplot(game_data, aes(x = home_team_TD, y = home_team_TWO_PT)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_TD, y = away_team_TWO_PT), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Two Point Conversions in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Two Point Conversions") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize the number of touchdowns vs. safeties
ggplot(game_data, aes(x = home_team_TD, y = home_team_SAFETY)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_TD, y = away_team_SAFETY), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Touchdowns vs Safeties in NFL Games",
       x = "Number of Touchdowns",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

#========================================#
#=== Field Goal Pairwise Scatterplots ===#
#========================================#

# Visualize the number of field goals vs. extra points (appears to be negatively correlated)
ggplot(game_data, aes(x = home_team_FG, y = home_team_XP)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_FG, y = away_team_XP), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Field Goals vs Extra Points in NFL Games",
       x = "Number of Field Goals",
       y = "Number of Extra Points") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize the number of field goals vs. two point conversions (appear to be negatively correlated)
ggplot(game_data, aes(x = home_team_FG, y = home_team_TWO_PT)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_FG, y = away_team_TWO_PT), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Field Goals vs Two Point Conversions in NFL Games",
       x = "Number of Field Goals",
       y = "Number of Two Point Conversions") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize the number of field goals vs. safeties
ggplot(game_data, aes(x = home_team_FG, y = home_team_SAFETY)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_FG, y = away_team_SAFETY), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Field Goals vs Safeties in NFL Games",
       x = "Number of Field Goals",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

#=========================================#
#=== Extra Point Pairwise Scatterplots ===#
#=========================================#

# Visualize the number of extra points vs. two point conversions (appear to be negatively correlated)
ggplot(game_data, aes(x = home_team_XP, y = home_team_TWO_PT)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_XP, y = away_team_TWO_PT), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Extra Points vs Two Point Conversions in NFL Games",
       x = "Number of Extra Points",
       y = "Number of Two Point Conversions") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize the number of extra points vs. safeties
ggplot(game_data, aes(x = home_team_XP, y = home_team_SAFETY)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_XP, y = away_team_SAFETY), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Extra Points vs Safeties in NFL Games",
       x = "Number of Extra Points",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

#===================================================#
#=== Two Point Conversions Pairwise Scatterplots ===#
#===================================================#

# Visualize the number of two point conversions vs. safeties
ggplot(game_data, aes(x = home_team_TWO_PT, y = home_team_SAFETY)) +
  geom_point(position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  geom_point(aes(x = away_team_TWO_PT, y = away_team_SAFETY), 
             position = position_jitter(width = 0.2, height = 0.2), 
             color = "black", size = 3, alpha = 0.7, shape = 16) +
  labs(title = "Two Point Conversions vs Safeties in NFL Games",
       x = "Number of Two Point Conversions",
       y = "Number of Safeties") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))
