##-----------------------------------------------------------------
## 1. Merges the training and the test sets to create one data set.
## ----------------------------------------------------------------

## Cargamos los dataset en R

## Training Data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep="")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, sep="")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE, sep="")

## Test Data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep="")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, sep="")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE, sep="")

## Unificamos Training Set and Test Data
subject_all <- rbind(subject_train, subject_test)
X_all <- rbind(X_train, X_test) 
y_all <- rbind(y_train, y_test)

## Eliminamos los objetos sobrantes
rm(subject_train, subject_test, X_train, X_test, y_train, y_test)

## put names

## names to subject_all
names(subject_all) <- "subject_id"

## names to X_all
## Extraemos the features labels
features_labels <- read.table("UCI HAR Dataset/features.txt", header = FALSE, sep = "", col.names = c("feature_id", "feature_label"))
names(X_all) <- features_labels$feature_label

## names to y_all
names(y_all) <- "activity_id"



##-------------------------------------------------------------------------------------------
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
##-------------------------------------------------------------------------------------------

## Extramemos solo los names con "_mean()" or "_std()"
idx_features_labels_mean_std <- grep(("-mean()|-std()"), features_labels$feature_label)

## Extraemos solo las medidas mean y std
X_all_mean_std <- X_all[,idx_features_labels_mean_std]

##---------------------------------------------------------------------------
## 3. Uses descriptive activity names to name the activities in the data set.
##---------------------------------------------------------------------------
## Extraemos the features names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "", col.names = c("activity_id", "activity_label"))

##----------------------------------------------------------------------
## 4. Appropriately labels the data set with descriptive activity names.
##----------------------------------------------------------------------
y_all <- merge(y_all, activity_labels, by.x = "activity_id", by.y = "activity_id")


##---------------------------------------------------------------------------------------------------------------------
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##---------------------------------------------------------------------------------------------------------------------

sub_act_vars <- cbind(subject_all, y_all[2], X_all_mean_std)

## order
## ordenamos sub_act_vars por subject_id, activity_label
sub_act_vars <- sub_act_vars[order(sub_act_vars$subject_id, sub_act_vars$activity_label),]
## eliminarmos row.names
##sub_act_vars <- sub_act_vars[2:dim(sub_act_vars)[2]]

sub_act_vars_mean <- aggregate(. ~ subject_id + activity_label, FUN = mean, data = sub_act_vars)
