setwd('/Users/krishnakalyan3/MOOC/Porto')
set.seed(123)
library(dplyr)
library(readr)
library(caret)
library(doMC)
library(tidyverse)
library(magrittr)
library(caTools)
registerDoMC(4)
source('utils.R')

dtrain <- read_csv('data/train_split.csv')
dval <- read_csv('data/val_split.csv')
dtest <- read_csv('data/test.csv')

# Check the size of data in memory
print(object.size(dtrain), units = 'Mb')

# as Factor categories
cat_vars <- names(dtrain)[grepl('_cat$', names(dtrain))]
dtrain %<>% mutate_at(cat_vars, funs(factor(.)))
dtest  %<>% mutate_at(cat_vars, funs(factor(.)))

# OHE
dtrain <- as.data.frame(model.matrix(~. - 1, data = dtrain))
dtest <- as.data.frame(model.matrix(~ . - 1, data = dtest))

# Sample Split 
# spl = sample.split(dtrain$target,SplitRatio = 0.8)
# x_traind <- dtrain[spl, ]
# x_testd <- dtest[spl==FALSE,]

formual1 <- formula(target ~ . - id)
gbm_model <- train(formual1, data=x_traind, method="glmnet")
test_yhat <- predict(gbm_model, dtest)
test_yhat <- round(test_yhat, 4)

submit_file <- data.frame(as.integer(dtest$id), test_yhat)
names(submit_file) <- c('id', 'target')
write_csv(submit_file, 'submit_glmnet.csv')
