## Coursera's Getting and Cleaning Data Course Project CodeBook
This file describes the variables, the data, and any transformations or work that I performed to clean up the data

**Source:**http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
**Dataset:**https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

####run_analysis.R

######Step 1: Merge the training and the test sets to create one data set
* Reads the files "./test/X_test.txt" and "./train/X_train.txt" and assigns then to the variables "X_test" and "X_train" respectively.
* Combines the X_test and X_train to a single data frame "dat".

* Reads the files "./test/Y_test.txt" and "./train/Y_train.txt" and assigns then to the variables "Y_test" and "Y_train" respectively.
* Combines the Y_test and Y_train to a single data frame "label".

* Reads the files "./test/subject_test.txt" and "./train/subject_train.txt" and assigns then to the variables "subject_test" and "subject_train" respectively.
* Combines the Y_test and subject_test to a single data frame "subject_train".

######Step 2:Extract only the measurements on the mean and standard deviation for each measurement.
* Reads the file "features.txt" and assigns it to the variable "features".
* Subsets the features by getting its second column data frame and only getting the rows that contain the word mean and std, and assigning it to the "meanstd" variable
* Subsets the "dat" dataframe by the rows that the "meanstd" variable has.
* Fixes the column names of the "dat" data frame by removing the excess parenthesis, dashes and capitalizing the letter "m" in "mean" and the letter "s" in "std"

######Step3: Use descriptive activity names to name the activities in the data set
* Reads the file "activity_labels.txt" and assigns it to the variable "activitylabels".
* Subsets the variable "activitylabels" by only getting the second column. 
* Changes the values of "activitylabels" to lower case.
* Replaces the "_" to " " in the "activitylabels" vector.
* Converts the numbers of the label variable to the strings of "activitylabels" in a respective manner.

######Step4 : Appropriately labels the data set with descriptive variable names.
* Change the column name of "subject" and "label" to the appropriate "activity" and "subject"
* Combines the datasets "subject", "activitylabels" and "dat".

