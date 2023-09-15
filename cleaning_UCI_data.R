## packages for this script:
library(vroom)
library(data.table)
library(reshape2)
library(plyr)
library(dplyr)
## Starting under the assumption you have downloaded the files and the folder 'getdata_projectfiles_UCI Har Dataset' is in your working directory
## File path for each data frame we need for this project: activity_labels, features, subject_test, x_test, y_test, subject_train, x_train, y_train
filepath_activityLables <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt"
filepath_features <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt"
filepath_Xtrain <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt"
filepath_Ytrain <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt"
filepath_SubjectTrain <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt"
filepath_Xtest <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt"
filepath_Ytest <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt"
filepath_SubjectTest <- "./getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt"
## Load each of those files into their own data frame 
activityLables <- fread(filepath_activityLables, col.names = c("classlabel", "activityname"))
features <- fread(filepath_features, col.names = c("featureindex", "featurename"))
Xtrain <- fread(filepath_Xtrain, col.names = features$featurename)
Ytrain <- fread(filepath_Ytrain, col.names = "classlabel")
trainSubjects <- fread(filepath_SubjectTrain, col.names = "subjectid")
Xtest <- fread(filepath_Xtest, col.names = features$featurename)
Ytest <- fread(filepath_Ytest, col.names = "classlabel")
testSubjects <- fread(filepath_SubjectTest, col.names = "subjectid")
## Matches the activity labels for the values in the y data frames which relates which activity each measurement variable assigns to
YtrainLabels <- Ytrain %>% mutate(activityname = 
                                      activityLables$activityname[match(Ytrain$classlabel, 
                                                                        activityLables$classlabel)])
YtestLabels <- Ytest %>% mutate(activityname = 
                                    activityLables$activityname[match(Ytest$classlabel,
                                                                      activityLables$classlabel)])
## Binds the labeled y activity data to the test results (x data)
train <- cbind(trainSubjects, YtrainLabels, Xtrain)
test <- cbind(testSubjects, YtestLabels, Xtest)
## Creates a single data frame with all of the data
UCIcombined <- rbind(train, test)
## Creates a new data frame that identifies any variable with mean or standard deviation in the name
UCI_stdMean <- subset(UCIcombined, select = 
                          grep("subjectid|activityname|mean|std", colnames(UCIcombined), 
                               ignore.case = TRUE))
## Creates a new data frame that reports an average of every measurement for each activity of each subject
UCI_stdMean_ave <- UCI_stdMean %>% group_by(activityname, subjectid) %>% summarize_all(mean)