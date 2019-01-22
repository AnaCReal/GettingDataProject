#This is the code for tidying the data for the "Getting and Cleaning Data" Assignment.

#Uploading some packages
library(data.table)
library(reshape2)
library(dplyr)
library(rowr)

#Step 1. Getting the Data

my_path <- getwd()
dir_path <- file.path(my_path, "UCI HAR Dataset")

#The training data 
train <- read.table(file.path(dir_path, "train", "X_train.txt"))
train <- data.table(train)
sub_train <- fread(file.path(dir_path, "train", "subject_train.txt"))
label_train <- fread(file.path(dir_path, "train", "y_train.txt"))

#The test data
test <- read.table(file.path(dir_path, "test", "X_test.txt"))
test <- data.table(test)
sub_test <- fread(file.path(dir_path, "test", "subject_test.txt"))
label_test <- fread(file.path(dir_path, "test", "y_test.txt"))

#Merging (binding) the data train on top of test with rbind()
total <- rbind(train, test)
names(sub_test) <- names(sub_train)
sub_total <- rbind(sub_train, sub_test)
setnames(sub_total, "subject")
labels <- rbind(label_train, label_test)
setnames(labels,"act")

#Extracting just the mean and std measurements
#From the features.txt the measurements with mean and sd will be stracted, for example for tBodyAcc the first 6 measurements are 3 for mean and 3 for sd, the rest are not.

all_features <- fread(file.path(dir_path, "features.txt"))

#Identifying the first column is the assigned number and the second is the feature, the axis and the measurement.
colnames(all_features) <- c("fnum", "feature")

#Using grep to extract features with mean ans std in the name
features <- all_features[grepl("mean\\(\\)|std\\(\\)",feature)]
feat_m_std <- features[,paste("V", fnum, sep ="")]
#Select columns from total

data <- select(total, feat_m_std)

#Now the first column will be the subject, the second the activity, then the data set
data <- cbind(sub_total, labels, data)

#Ordering the data by subject and then by activity (label)
data <- arrange(data, subject, act)

#Labeling the activities, the info is form the activity_labels.txt
 
act_label <- data.frame("act" = 1:6, "Activity" = c("Walking", "Walk_upstairs", "Walk_downstairs", "Sitting", "Standing", "Laying"))

data <- merge(data, act_label, by="act") 

#Ordering the columns

data <- select(data, subject, Activity, V1:V543)
data <- arrange(data, subject, Activity)
#Now the variable names from the feature.txt. To get more descriptive ones. 

colnames(data) <- c("Subject", "Activity", features$feature)

#Getting the mean for each subject for each activity

    a <- colMeans(data[(data$Subject == 1 & data$Activity == "Laying"),3:68])
    
x <- c("Laying", "Sitting", "Standing", "Walk_downstairs", "Walking", "Walk_upstairs")
y <- 1:30

data_tidy2 <- data.frame("Subject" = 1, "Activity" = c("Laying"), "Mean" = a)
for (i in y){
    for(j in 1:length(x)){
    b <- colMeans(data[(data$Subject == i & data$Activity == x[j]),3:68])
    temp <- data.frame("Subject" = i, "Activity" = x[j], "Mean" = b)
    data_tidy2 <- rbind(data_tidy2, temp)
    }
}

#Since the data frame got initialized with the first mean of each column (which are 66) they got repeated in the loop process, so I remove that repeated rows.
my_tidy <- data_tidy2[-(1:66),]

#Creating the final tidy data frame, starting with the subject, the activity, the name of the measurement and the mean calculated.

measurements <- rep(features$feature, times=180)
final_tidy <- data.frame("Subject" = my_tidy[,1], "Activity" = my_tidy[,2], "Measurement" = measurements, "Mean" = my_tidy[,3])

#Exporting the final data frame
write.table(final_tidy, "./mydata.txt", sep = "\t", row.names = FALSE)

