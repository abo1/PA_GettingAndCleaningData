PA_GettingAndCleaningData

#Peer Assessments / Getting and Cleaning Data

##Script: 
run_Analysis.R

##Introduction:
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Objetive: 
Create a tidy data set with the average of severals variables for each activity and each subject.

##Input files:
“../UCI HAR Dataset/”

##Output files:
"sub_act_vars_means.txt"

For each record it is provided:
* subject_id: An identifier of the subject who carried out the experiment.
* activity_label:
**WALKING
**WALKING_UPSTAIRS
**WALKING_DOWNSTAIRS
**SITTING
**STANDING
**LAYING
* AVG variables: average of severals variables

##Process:
1.Merges the training and the test sets to create one data set:

*subject_all: merges data from "../UCI HAR Dataset/train/subject_train.txt” and "../UCI HAR Dataset/test/subject_test.txt".
Column name = “subject_id”.
 
*X_all: merge data from "../UCI HAR Dataset/train/X_train.txt” and "../UCI HAR Dataset/test/X_test.txt".
Column names from "../UCI HAR Dataset/features.txt".

*y_all: recopila los datos de "../UCI HAR Dataset/train/y_train.txt” and "../UCI HAR Dataset/test/y_test.txt".
Column name = “activity_id”.

2.Extracts only the measurements on the mean and standard deviation for each measurement:

*Create X_all_mean_std: extracs feature_labels that contain "_mean()" or "_std()".

3.Uses descriptive activity names to name the activities in the data set:

*Create activity_labels object from "../UCI HAR Dataset/activity_labels.txt".
Column names = “activity_id”, “activity_label”.

4.Appropriately labels the data set with descriptive activity names:

*Meges y_all and activity_labels by “activity_id”.
 
5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject:

*Create sub_act_vars: combines subject_all, y_all$activity_label and X_all_mean_std.

*Orders sub_act_vars by “subject_id”, “activity_label”

*Aggregates variables by “subject_id”, “activity_label” with mean function.

*Orders sub_act_vars_means by “subject_id”, “activity_label”

*Drop innecesary objects.

6.Write output file "sub_act_vars_means.txt"
