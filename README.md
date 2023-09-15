# Getting-and-Cleaning-Data-Project
Course project for the third step in JHU/Coursera's Data Science Specialization

cleaning_UCI_data.R takes the source data explained below and and combines all of the train and test data into a single data frame that alligns the measurement outcome with each study subject and the activity measured.From there it creates a second data frame that reports the average measurement for each activity of each subject. 

The code assumes that you have downloaded the original UCI files and the folder 'getdata_projectfiles_UCI Har Dataset' is in your working directory

Data ID for the combined train and test data: UCIcombined
Data ID for the combined and averaged by activity and subject train and test data: UCI_stdMean_ave

Full description of the data is available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Link to download the data files: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
