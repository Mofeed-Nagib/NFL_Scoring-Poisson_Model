# Final Capstone Project

## Project Proposal
In the realm of NFL score prediction models, it is common practice to generate forecasts that treat scores as continuous variables. However, in the real world of football games, final scores frequently materialize as intricate combinations of multiples of 3 and 7. Recall that Poisson random variables are discrete, making them a suitable choice for modeling count data and effectively representing the probabilistic aspects of scoring events in a football game. Hence, for my capstone project, I aim to create a predictive model utilizing Poisson distributions to simulate the discrete nature of NFL scores more accurately, while also assessing the model's effectiveness in outperforming the betting line or spread.

The core of this project relies on a comprehensive dataset of NFL game scores. This dataset encompasses play-by-play score data from every regular season and postseason NFL game between 1999 and 2023. The dataset, acquired from the nflfastR package, includes critical information such as participating teams, home teams, scoring events, and other game details. This rich dataset serves as the foundation for our study, allowing us to investigate how well a Poisson distribution-based model can predict NFL scores accurately and whether it offers a competitive advantage over conventional sports betting models.

To re-summarize, the primary objectives of this capstone project are as follows:
* Develop a predictive model based on Poisson distributions to simulate NFL scores.
*	Assess the model's accuracy in predicting NFL scores compared to traditional methods.
*	Investigate how well the Poisson distribution-based model can predict game outcomes and outperform Vegas lines.

## File Hierarchy
* **00_load_packages.R:** This R script initializes all the necessary R packages for our data processing and Poisson regression model.
* **05_get_data.R:** This R script performs the data extraction and preparation that aggregates game-by-game scoring breakdown data from the play-by-play data sourced from the [nflfastR](https://CRAN.R-project.org/package=nflfastR) package, and merges it with the corresponding game betting data sourced from [Kaggle](https://www.kaggle.com/datasets/tobycrabtree/nfl-scores-and-betting-data).
* **10_explore_data.R:** This R script contains summary statistics and various descriptive plots of the aggregated scoring data, including various histograms and pairwise plots, as well as a correlation matrix.
* **15_fit_model.R:** This R script fits the univariate and bivariate Linear and Poisson regression models to the aggregated scoring data.
* **20_model_simulations.R:** This R script simulations the game result using each of our 4 regression models and calculates the predicted score sum and predicted score difference.
* **25_model_evaluation.R:** This R script compares the simulated score sum and score difference to the over/under line and the point spread to determine the best bet, and evaluates the quality of the model predictions by comparing the accuracy of those bets to the true outcome of the game.
* **90_run_process.R:** This R script runs the analysis, builds the model, and simulates the output (i.e. calls all the previous files).
* **Final_Capstone_Project.Rproj:** This is the R project file for this capstone.
* **rawdata/**
	* **raw_play-by-play.RDS:** This RDS object file contains the raw play-by-play data for every game since 1999.
	* **nfl_betting.csv:** This CSV file contains the point spread and over/under betting data for every game since 1966.
	* **nfl_teams.csv:** This CSV file contains a dictionary of team information (e.g. team name, abbreviation, conference, division) for all past and present teams.
* **data/**
	* **game_data.RDS:** This RDS object file contains the aggregated scoring data (i.e. number of touchdowns, field goals, extra points, two-point conversions, and safeties) for every game since 1999.
	* **game_betting_data.RDS:** This RDS object file contains the merged scoring and betting data (i.e. point spread and over/under line) for every game since 1999.
