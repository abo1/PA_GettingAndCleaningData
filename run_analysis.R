## Objetive: 
## Create a tidy data set with the average of severals variables for each activity and each subject.

##-----------------------------------------------------------------
## 1. Merges the training and the test sets to create one data set.
## ----------------------------------------------------------------

## Load the training and test sets in R

## Training set
subject_train <- read.table("../UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep="")
X_train <- read.table("../UCI HAR Dataset/train/X_train.txt", header = FALSE, sep="")
y_train <- read.table("../UCI HAR Dataset/train/y_train.txt", header = FALSE, sep="")

## Test set
subject_test <- read.table("../UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep="")
X_test <- read.table("../UCI HAR Dataset/test/X_test.txt", header = FALSE, sep="")
y_test <- read.table("../UCI HAR Dataset/test/y_test.txt", header = FALSE, sep="")

## Merges Training Set and Test Data
subject_all <- rbind(subject_train, subject_test)
X_all <- rbind(X_train, X_test) 
y_all <- rbind(y_train, y_test)

## Drop unnecessary objects
rm(subject_train, subject_test, X_train, X_test, y_train, y_test)

## put names

## names to subject_all
names(subject_all) <- "subject_id"

## names to X_all
## from the features labels
features_labels <- read.table("../UCI HAR Dataset/features.txt", header = FALSE, sep = "", col.names = c("feature_id", "feature_label"))
names(X_all) <- features_labels$feature_label

## names to y_all
names(y_all) <- "activity_id"



##-------------------------------------------------------------------------------------------
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##-------------------------------------------------------------------------------------------

## Extracs feature_labels that contain "_mean()" or "_std()"
idx_features_labels_mean_std <- grep(("-mean\\(\\)|-std\\(\\)"), features_labels$feature_label)

## Extraemos solo las medidas mean y std
X_all_mean_std <- X_all[,idx_features_labels_mean_std]

## Drop unnecessary X_all
rm(X_all)


##---------------------------------------------------------------------------
## 3. Uses descriptive activity names to name the activities in the data set.
##---------------------------------------------------------------------------
## Extracs from the features names
activity_labels <- read.table("../UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", col.names = c("activity_id", "activity_label"))

##----------------------------------------------------------------------
## 4. Appropriately labels the data set with descriptive activity names.
##----------------------------------------------------------------------
y_all <- merge(y_all, activity_labels, by.x = "activity_id", by.y = "activity_id")


##---------------------------------------------------------------------------------------------------------------------
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##---------------------------------------------------------------------------------------------------------------------

sub_act_vars <- cbind(subject_all, y_all[2], X_all_mean_std)

## Orders sub_act_vars by subject_id, activity_label
sub_act_vars <- sub_act_vars[order(sub_act_vars$subject_id, sub_act_vars$activity_label),]

## Aggregates variables by "subject_id", "activity_label"
sub_act_vars_means <- aggregate(. ~ subject_id + activity_label, FUN = mean, data = sub_act_vars)

## Orders agg_sub_act_vars_means by subject_id", "activity_label"
sub_act_vars_means <- sub_act_vars_means[order(sub_act_vars_means$subject_id, sub_act_vars_means$activity_label),]

## Remove row.names
row.names(sub_act_vars_means) <- c()

## Put columns names
names(sub_act_vars_means) <- c(names(sub_act_vars_means[1:2]), paste(rep("AVG", 66), names(sub_act_vars_means[3:68])))

## Drop unnecessary objects
rm(X_all_mean_std, activity_labels, features_labels, subject_all, y_all,sub_act_vars, idx_features_labels_mean_std)




##----------------
## 6. Output File.
##----------------

write.table(sub_act_vars_means, file = "sub_act_vars_means.txt", sep = " ", row.names = FALSE, col.names = TRUE)