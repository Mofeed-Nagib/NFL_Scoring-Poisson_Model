# Final Capstone Project
## Project Proposal
In the realm of NFL score prediction models, it is common practice to generate forecasts that treat scores as continuous variables. However, in the real world of football games, final scores frequently materialize as intricate combinations of multiples of 3 and 7. Recall that Poisson random variables are discrete, making them a suitable choice for modeling count data and effectively representing the probabilistic aspects of scoring events in a football game. Hence, for my capstone project, I aim to create a predictive model utilizing Poisson distributions to simulate the discrete nature of NFL scores more accurately, while also assessing the model's effectiveness in outperforming the betting line or spread.

The core of this project relies on a comprehensive dataset of NFL game scores. This dataset encompasses play-by-play score data from every regular season and postseason NFL game between 1999 and 2023. The dataset, acquired from the nflfastR package, includes critical information such as participating teams, home teams, scoring events, and other game details. This rich dataset serves as the foundation for our study, allowing us to investigate how well a Poisson distribution-based model can predict NFL scores accurately and whether it offers a competitive advantage over conventional sports betting models.

To re-summarize, the primary objectives of this capstone project are as follows:
* Develop a predictive model based on Poisson distributions to simulate NFL scores.
*	Assess the model's accuracy in predicting NFL scores compared to traditional methods.
*	Investigate whether the Poisson distribution-based model can outperform the betting line or spread in predicting game outcomes.
*	Explore applications of the trained model in daily fantasy sports and proposition betting to determine its real-world utility.

To achieve these objectives, we will employ advanced statistical techniques, including Poisson regression and machine learning algorithms, to build and train the predictive model. We will rigorously evaluate the model's performance through cross-validation and statistical metrics, such as mean absolute error, root mean square error, and accuracy in predicting game outcomes.
