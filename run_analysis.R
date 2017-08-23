## Set working directory to 

features <- read.table("features.txt", stringsAsFactors = FALSE)

## Load train data and append subject and activity
train <- read.table("train/X_train.txt")
trainsubjects <- read.table("train/subject_train.txt", col.names = c("subject"))
trainlabels <- read.table("train/y_train.txt", col.names = c("activity_label"))
trainlabelled <- cbind(trainlabels, trainsubjects, train)

## Load test data and append subject and activity
test <- read.table("test/X_test.txt")
testsubjects <- read.table("test/subject_test.txt", col.names = c("subject"))
testlabels <- read.table("test/y_test.txt", col.names = c("activity_label"))
testlabelled <- cbind(testlabels, testsubjects, test)

## Union train and test data
traintestunion <- rbind(trainlabelled, testlabelled) 

## Set variable names from features.txt
names(traintestunion) <- c("activitylabel","subject",features$V2)

## Keep only variables for mean and standard deviation
unionmeanstd <- traintestunion[,grepl("mean[^Freq]|std|activity|subject",names(traintestunion))]

## Add activity labels 
activities <- read.table("activity_labels.txt", col.names = c("activitylabel", "activitydesc"), stringsAsFactors = FALSE)
unionmeanstdacs <- merge(activities, unionmeanstd, by = "activitylabel")

## Summarise mean for each feature by subject and activity
library(dplyr)
subjectactivitysummary <- unionmeanstdacs %>% group_by(subject, activitylabel, activitydesc) %>% summarise_all(funs(mean))

## Write subject and activity summary to txt file
ifelse(!dir.exists("output"), dir.create("output"), FALSE)
write.table(subjectactivitysummary, "output/getting_and_cleaning_data-course_project-subject_activity_summary.txt", row.name = FALSE)
