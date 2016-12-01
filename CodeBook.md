 Getting and Cleaning Data Project
 
Ehg24
 
 Description
 Additional information about the variables, data and transformations used in the course project for the Coursera  Getting and Cleaning Data course.
 
 Source Data
 A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/HumanActivityRecognitionUsingSmartphones
 
 The source data for this project can be found here.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities:
* WALKING
* WALKING_UPSTAIRS
*  WALKING_DOWNSTAIRS
* SITTING
* STANDING
* LAYING, wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 
* 70% of the volunteers selected for generating the training data and
* 30% the test data. 
 
 The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
 
  Attribute Information
 For each record in the dataset it is provided: 
* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
*  An identifier of the subject who carried out the experiment.
 
  Section 1. Merge the training and the test sets to create one data set.
 After setting the source directory for the files, read into tables the data located in
 - features.txt
 - activity_labels.txt
 - subject_train.txt
 - x_train.txt
 - y_train.txt
 - subject_test.txt
 - x_test.txt
 - y_test.txt
 
 Assign column names and merge to create one data set.
 
 #1. Downloading and unzipping dataset
# Unzip dataSet to /data directory
#2. Merging the training and the test sets to create one data set:
#2.1 Reading files
# Reading trainings tables:
       # Reading testing tables:
       # Reading feature vector:
       # Reading activity labels:
#2.2 Assigning column names:
#2.3 
#3. Extracting only the measurements on the mean and standard deviation for each measurement
#3.1 Reading column names
#3.2 Create vector for defining ID, mean and standard deviation:
#3.3 Extracting only the measurements on the mean and standard deviation for each measurement from setAllInOne :  setForMeanAndStd 
#4. Using descriptive activity names to name the activities in the data set:
  #Reading activity labels:
 # replace labels in data with label names
#5. Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
  #5.1 Making second tidy data set
View(secTidySet)
#5.2 Writing second tidy data set in txt file
#5.3 str(secTidySet)
str(secTidySet)
'data.frame':	180 obs. of  81 variables:
 $ subjectId   : int  1 1 1 1 1 1 2 2 2 2 ...
 $ activityId  : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ..........
