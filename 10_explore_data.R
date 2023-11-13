### Explore the aggregated touchdown and field goal data

# Visualize the number of touchdowns (appears to be poisson)
ggplot(data = data.frame(touchdowns = c(game_data$home_team_TD, game_data$away_team_TD)), 
       aes(x = touchdowns)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Touchdowns in NFL Games",
       x = "Number of Touchdowns",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2))

# Visualize touchdown density distribution with poisson overlay
ggplot(data = data.frame(touchdowns = c(game_data$home_team_TD, game_data$away_team_TD)), 
       aes(x = touchdowns, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Density Distribution of Touchdowns in NFL Games",
       x = "Number of Touchdowns",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 10, by = 2)) +
  geom_point(data = data.frame(x = 0:10, y = dpois(0:10, lambda = mean(c(game_data$home_team_TD, game_data$away_team_TD)))),
             aes(x = x, y = y), color = 'red', size = 3)

# Visualize the number of field goals (appears to be poisson)
ggplot(data = data.frame(field_goals = c(game_data$home_team_FG, game_data$away_team_FG)), 
       aes(x = field_goals)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = stat(count)), vjust = -0.5, color = "black") +
  labs(title = "Distribution of Field Goals in NFL Games",
       x = "Number of Field Goals",
       y = "Frequency") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 8, by = 2))

# Visualize field goal density distribution with poisson overlay
ggplot(data = data.frame(field_goals = c(game_data$home_team_FG, game_data$away_team_FG)), 
       aes(x = field_goals, y = after_stat(density))) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Density Distribution of Field Goals in NFL Games",
       x = "Number of Field Goals",
       y = "Density") +
  theme(plot.title = element_text(hjust = 0.5)) +
  scale_x_continuous(breaks = seq(0, 8, by = 2)) +
  geom_point(data = data.frame(x = 0:8, y = dpois(0:8, lambda = mean(c(game_data$home_team_FG, game_data$away_team_FG)))),
             aes(x = x, y = y), color = 'red', size = 3)

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
