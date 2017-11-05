setwd('/Users/krishnakalyan3/MOOC/Porto')
set.seed(123)
library(dplyr)
library(readr)
library(caret)
library(doMC)
registerDoMC(4)

train_data <- read_csv('data/train_split.csv')
val_data <- read_csv('data/val_split.csv')

# See data
train_data$target <- as.factor(train_data$target)
plot(train_data$target)

formual1 <- formula(target ~ . - id)
model <- gbm(formual1, family=binomial(link='logit'), data=train_data)

# GLM model is rank deficient : insufficient information contained
# in your data to estimate the model you desire

gbm_model <- train(formual1, data=train_data, method="glmnet")
summary(gbm_model)

# Super Imablanced data set. Try to balance the classes

