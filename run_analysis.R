## Project: Getting and Cleaning Data Course
## Analyst: Larry
## Date: September 28, 2020
## Goal: This script collects, works with, and cleans data collected from Samsung
## Galaxy S smartphone accelerometers. Activity was collected for 30 subjects.


## Load packages used in this data analysis:
library(readr)	## the readr package is used to read the data files into a tibble
library(dplyr)  ## the dplyr package is used to manipulate and transform the data 


## Get System Information:
sessionInfo()	  ## list the version of R and the versions of the packages used
## R Version Used: R version 4.0.2 (2020-06-22), x86_64-w64-mingw32/x64 (64-bit)
## Main packages dplyr_1.0.2, readr_1.3.1 


## setup the working directory
getwd()
setwd("C:/Users/Larry/Documents/Coursera/Johns_Hopkins/Project_Get_and_Clean_Data")


## download files from internet to working directory and unzip the files
myUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
workDir <- getwd()
fileDest <- paste(workDir, "UCI HAR Dataset.zip", sep ="/")  ## create destination
## download and unzip files only if they haven't been already downloaded 
if(!file.exists(fileDest)) {
  download.file(url = myUrl, destfile = fileDest)
  dateDownloaded <- date()  ## get the date and time for the data download
  unzip(fileDest)  
}
## Data was downloaded on: Sun Sep 20 20:18:21 2020


## list the files and sub-directories in the data directory
fileDir <- gsub(".zip", "", fileDest)  ## create the name of unzipped data directory 
dataFiles <- list.files(fileDir, recursive = TRUE)  
print(dataFiles)  ## print list of the data files


## read_table2() reads files in as a tibble and parses columns based on whitespace
## file.path() creates a file path based on the inputs provided

  ## read in the list of 561 features and feature ids
  features <- read_table2(file.path(fileDir, "features.txt"), 
                          col_names = c("feature_id", "feature")) 

  ## read in the list of 6 activities and activity ids
  activity_labels <- read_table2(file.path(fileDir, "activity_labels.txt"), 
                          col_names = c("activity_id", "activity")) 

  ## read training data in:
  ## read in the subject list file (the subject associated with the observation)
  subject_train <- read_table2(file.path(fileDir, "train", "subject_train.txt"), 
                            col_names = c("subject_id")) 
  ## read in the X_train file (561 measurements associated with the observation)
  x_train <- read_table2(file.path(fileDir, "train", "X_train.txt"), 
                               col_names = FALSE) 
  ## read in the y_train file (the activity id for the observation)
  y_train <- read_table2(file.path(fileDir, "train", "y_train.txt"), 
                         col_names = c("activity_id")) 
  
  ## read test data in:
  ## read in the subject list file (the subject associated with the observation)
  subject_test <- read_table2(file.path(fileDir, "test", "subject_test.txt"), 
                               col_names = c("subject_id")) 
  ## read in the X_test file (measurements associated with the observation)
  x_test <- read_table2(file.path(fileDir, "test", "X_test.txt"), 
                        col_names = FALSE) 
  ## read in the y_test file (the activity id for the observation)
  y_test <- read_table2(file.path(fileDir, "test", "y_test.txt"), 
                        col_names = c("activity_id"))
  
  
## get dataset dimensions and basic info:
  
  dim_subject_train <- dim(subject_train)    
  dim_subject_test <- dim(subject_test)
  
  dim_x_train <- dim(x_train)
  dim_x_test <- dim(x_test)
  
  dim_y_train <- dim(y_train)
  dim_y_test <- dim(y_test)
  
  ## determine how many of the 30 subjects are used in training and test datasets
  unique_subject_train <- nrow(unique(subject_train))  ## 21 subjects in training
  unique_subject_test <- nrow(unique(subject_test))  ## 9 subjects in test
  

## 1a. Combine the test and training sets into an x, subject, and activities datasets
## Add a source column to identify whether data from the train or test datasets
  
  ## identify whether the subject data came from training or test
  subject_train2 <- subject_train %>% mutate(source = "train")
  subject_test2 <- subject_test %>% mutate(source = "test")
  ## combine subject_train2 and subject_test2 datasets
  subject <- bind_rows(subject_train2, subject_test2)
  
  ## identify whether the x data came from training or test
  x_train2 <- x_train %>% mutate(source = "train")
  x_test2 <- x_test %>% mutate(source = "test")
  ## combine x_train2 and x_test2 datasets
  x <- bind_rows(x_train2, x_test2)

  ## identify whether the y data came from training or test
  y_train2 <- y_train %>% mutate(source = "train")
  y_test2 <- y_test %>% mutate(source = "test")
  ## combine y_train2 and y_test2 datasets
  activities <- bind_rows(y_train2, y_test2)

  ## Step 1b. will later combine the x, subject, and activities into a single dataset
  
  
## 4. Appropriately labels the data set with descriptive variable names. 
## Add the feature names (contained in the feature table) to the x dataset
  
  ## transpose the 561 feature names into a row vector 
  featureNMs <- t(features[2])  
  names(x) <- c(featureNMs, "source")  ## source identifies training or test data
  
  
## 2. Extract only the measurements on the mean and standard deviation for 
## each measurement. 
  
  ## Identify elements with feature names that contain mean() or std().
  ## Use regular expressions. The \\ says the () is a literal and not meta-character
  index <- grep("mean\\()|std\\()", featureNMs)  
  print(length(index))  ## there are 66 elements
  
  
  subsetFeatures <- features[index,]  ## list feature names with mean() or std().
  x2 <- x[, index]  ## keep only columns with feature names with mean() or std().
  str(x2)  ## verify that columns are for means and standard deviations only
  
  
## 3. Use descriptive activity names to name the activities in the data set 
  ## Add the activity_names to the y dataset (we will merge later with x and subject)
  activities2 <- merge(activities, activity_labels, by.x = "activity_id", by.y = "activity_id")
  

## 1b. Merge the training and the test sets to create one data set.
## merge the x, subject, and activities2 datasets 
  x3 <- bind_cols(subject_id = subject$subject_id, activity = activities2$activity, x2)

  ## The x3 dataset is tidy: (1) all variables are in columns, (2) all observations
  ## are in rows, and (3) the table focuses on one topic
  
  ## The activity column in the x3 dataset uses descriptive activity names 
  ## to name the activities in the data set
  
  ## The x3 dataset combines the training and the test sets to create one data set. 
  ## The dataset also identifies the subject the data is associated with and 
  ## the activity the subject was performing

  
## 5. create a second, independent tidy data set with the average of each variable 
## for each activity and each subject. Using dplyr functions:
  
  ## informational: get the number of unique combinations of activity and subject_id in x3
  uniqueCombos <- nrow(unique(x3[, 1:2]))
  uniqueCombos  ## running on 9/26/2020 I got 35 combinations
  
  averagex3 <- x3 %>% group_by (activity, subject_id) %>%
               summarize_all(mean)
  
  dim(averagex3)  ## verify that we get 35 unique rows x 68 columns
  
  ## append "avg" as prefix to the column names and remove dashes and parentheses
  ## from variable names
  colNms <- names(averagex3[ ,3:68])
  colNms2 <- paste("avg", colNms, sep ="")
  colNms3 <- c(names(averagex3[ ,1:2]), colNms2)
  colNms4 <- gsub("-", "", colNms3)  ## get rid of the dash (-)
  colNms5 <- gsub("\\()", "", colNms4)  ## get rid of the parentheses
  
  names(averagex3) <- colNms5  ## update column names to reflect that they are averages
  
  ## meanx3 contains the average of the means and standard deviation measurements
  ## measurements for each activity and each subject.
  names(averagex3)
  
  
## write the dataset out   
  write.csv(averagex3, "averagex3.csv")
  
  
  
  
  