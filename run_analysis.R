## Set working directory to UCI HAR Dataset folder

features <- read.table("features.txt", stringsAsFactors = FALSE)

train <- read.table("train/X_train.txt")
trainsubjects <- read.table("train/subject_train.txt", col.names = c("subject"))
trainlabels <- read.table("train/y_train.txt", col.names = c("activity_label"))
trainlabelled <- cbind(trainlabels, trainsubjects, train)

test <- read.table("test/X_test.txt")
testsubjects <- read.table("test/subject_test.txt", col.names = c("subject"))
testlabels <- read.table("test/y_test.txt", col.names = c("activity_label"))
testlabelled <- cbind(testlabels, testsubjects, test)

traintestunion <- rbind(trainlabelled, testlabelled) 

names(traintestunion) <- c("activitylabel","subject",features$V2)

unionmeanstd <- traintestunion[,grepl("mean[^Freq]|std|activity|subject",names(traintestunion))]

activities <- read.table("activity_labels.txt", col.names = c("activitylabel", "activitydesc"), stringsAsFactors = FALSE)

unionmeanstdacs <- merge(activities, unionmeanstd, by = "activitylabel")

library(dplyr)

subjectactivitysummary <- unionmeanstdacs %>% group_by(subject, activitylabel, activitydesc) %>% summarise_all(funs(mean))

ifelse(!dir.exists("output"), dir.create("output"), FALSE)

write.table(unionmeanstdacs, "output/getting_and_cleaning_data-course_project-tidydataset1.txt", row.name = FALSE)
write.table(subjectactivitysummary, "output/getting_and_cleaning_data-course_project-tidydataset2.txt", row.name = FALSE)
