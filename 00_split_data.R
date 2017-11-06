setwd('/Users/krishnakalyan3/MOOC/Porto')
set.seed(123)

library(caTools)
library(tidyverse)
library(readr)

train_data <- read_csv('data/train.csv')

# Replace -1s to NAs
train_data[train_data == -1] <- NA
glimpse(train_data)

split = sample.split(train_data$target, SplitRatio = 0.95)

train_split = subset(train_data, split == TRUE)
val_split = subset(train_data, split == FALSE)
nrow(val_split)

write_csv(train_split, 'data/train_split.csv')
write_csv(val_split, 'data/val_split.csv')
