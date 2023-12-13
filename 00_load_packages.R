### This script loads all of the necessary packages for my final capstone project

library(knitr)
library(plotly)
library(scales)
library(DT)
library(leaflet)
library(gganimate)
library(corrplot)
library(GGally)
library(ggmap)
library(shiny)
library(MASS)
library(lme4)
library(merTools)
library(arm)
library(pROC)
library(MLmetrics)
library(viridis)
library(RSelenium)
library(rvest)
library(randomForest)
library(FNN)
library(caret)
library(pls)
library(lubridate)
library(stringr)
library(devtools)
library(splines)
library(RecordLinkage)
library(rsconnect)
library(tidyverse)
library(pubtheme)

# load the packages for parallel processing
library(doSNOW)
library(foreach)
library(parallel)


######################################
#--- Additional Required Packages ---#
######################################

# install nflfastR package (which contains the raw dataset)
if (!("nflfastR" %in% installed.packages()[,1])) {
  install.packages("nflfastR", dependencies = TRUE)
}
# load nflfastR package
library(nflfastR)

# install bpglm package (which contains the bivariate poisson regression)
if (!("bpglm" %in% installed.packages()[,1])) {
  devtools::install_github("https://github.com/chowdhuryri/bpglm")
}
# load bpglm package
library(bpglm)
