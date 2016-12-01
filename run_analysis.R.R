#1. Downloading and unzipping dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to /data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

##***********************************************************************************
#2. Merging the training and the test sets to create one data set:
  #2.1 Reading files

# Reading trainings tables:
DataXtrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
DataYtrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables:
DataXtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
DataYtest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
activityLabels
#2.2 Assigning column names:
  
colnames(DataXtrain) <- features[,2] 
colnames(DataYtrain) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(DataXtest) <- features[,2] 
colnames(DataYtest) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')
colnames(activityLabels)

##2.3 Merging all data in one set:
  
mrg_train <- cbind(DataYtrain, subject_train, DataXtrain) 
#head(mrg_train)
mrg_test <- cbind(DataYtest, subject_test, DataXtest) 
setAllInOne <- rbind(mrg_train, mrg_test) 
View(setAllInOne)
dim(setAllInOne)        ##[1] 10299   563
##*****************************************************************************

##3. Extracting only the measurements on the mean and standard deviation for each measurement

##3.1 Reading column names:
  
  colNames <- colnames(setAllInOne)
  head(colNames)      ##[1] "activityId"        "subjectId"         "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" 

#3.2 Create vector for defining ID, mean and standard deviation:
  
  mean_and_std <- (grepl("activityId" , colNames) | 
                     grepl("subjectId" , colNames) | 
                     grepl("mean.." , colNames) | 
                     grepl("std.." , colNames) 
  )
  head(mean_and_std)  ##[1] TRUE TRUE TRUE TRUE TRUE TRUE
  
#3.3 Making mean and std subset from setAllInOne:
  
  setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
  names(setForMeanAndStd)
  setForMeanAndStd0 <- setForMeanAndStd
  names(setForMeanAndStd0)
  dim(setForMeanAndStd)     ##[1] 10299    81
  
#4. Using descriptive activity names to name the activities in the data set:
  # read the labels (activityType)
  #Reading ctivity labels:
    activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
  activityLabels
 
  # replace labels in data with label names
  setForMeanAndStd$activityId
  activityLabels[setForMeanAndStd$activityId, 2]
  
  setForMeanAndStd$activityId <- activityLabels[setForMeanAndStd$activityId, 2]
  
  setForMeanAndStd$activityId 
  names(setForMeanAndStd)
  setForMeanAndStd1 <- setForMeanAndStd0
  names(setForMeanAndStd1)
##----------------------------------------------------------------

 names(setForMeanAndStd1)<-gsub("FrequencyBody", "", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("Acc", "Accelerometer", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("Gyro", "Gyroscope", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("setForMeanAndStdBodyBody", "Body", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("Mag", "Magnitude", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("^t", "Time", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("^f", "Frequency", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("tBody", "TimeBody", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("-mean()", "Mean", names(setForMeanAndStd1), ignore.case = TRUE)
 names(setForMeanAndStd1)<-gsub("-std()", "STD", names(setForMeanAndStd1), ignore.case = TRUE)
 names(setForMeanAndStd1)<-gsub("-freq()", "Frequency", names(setForMeanAndStd1), ignore.case = TRUE)
 names(setForMeanAndStd1)<-gsub("angle", "Angle", names(setForMeanAndStd1))
 names(setForMeanAndStd1)<-gsub("gravity", "Gravity", names(setForMeanAndStd1))
 names(setForMeanAndStd1) ##setForMeanAndStd1  

 names(setForMeanAndStd)<- names(setForMeanAndStd1)
names(setForMeanAndStd1)


##############################################
#5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
  #5.1 Making second tidy data set

secTidySet <- aggregate(. ~subjectId + activityId, setForMeanAndStd, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

View(secTidySet)
#5.2 Writing second tidy data set in txt file

write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
