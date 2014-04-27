data_cleaning
=============

The training scripts for course "Getting and cleaning data" on Coursera

The script deals with data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data sets for the script:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The script does the following:

- Reads train and data sets.
- Replaces descriptive activity names with name the activities in the data sets
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Merges the training and the test sets to create one data set.
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The output consists of two files:

samsung_data_means_std.txt - data set with row data, only the measurements on the mean and standard deviation for each measurement, both train and test data.

samsung_data_all_averages.txt - data set with the average of each variable for each activity and each subject
