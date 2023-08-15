library(dplyr)

#setting the folder path to upload all the required text files 

    folder_path <- "C:\\Users\\me-ch\\Downloads\\Graduate Courses\\Miscellaneous\\Data Science Specialization\\Getting and Cleaning Data\\Project"


#specifying the directory

    setwd("C:\\Users\\me-ch\\Downloads\\Graduate Courses\\Miscellaneous\\Data Science Specialization\\Getting and Cleaning Data\\Project")


#Reading all the text files that was moved to a new folder "Project" and assigning the dataset

    features <- read.table("features.txt", col.names = c("n","functions"))
    activities <- read.table("activity_labels.txt", col.names = c("code", "activity"))
    
    X_train <- read.table("X_train.txt", col.names = features$functions)
    y_train <- read.table("y_train.txt", col.names = "code")
    subject_train <- read.table("subject_train.txt", col.names = "subject")

    X_test <- read.table("X_test.txt", col.names = features$functions)
    y_test <- read.table("y_test.txt", col.names = "code")
    subject_test <- read.table("subject_test.txt", col.names = "subject")

    
    

#Merging the training and the test sets to create one data set

    X <- rbind(X_train, X_test)
    Y <- rbind(y_train, y_test)
    Subject <- rbind(subject_train, subject_test)
    Dataset <- cbind(Subject, Y, X)
    
    #setting the output file path to save into .csv file
    
    output_file <- "C:\\Users\\me-ch\\Downloads\\Graduate Courses\\Miscellaneous\\Data Science Specialization\\Getting and Cleaning Data\\Project\\run_analysis.csv"

    
#Extracts only the measurements on the mean and standard deviation for each measurement.

    Tidy <- Dataset %>% select(subject, code, contains("mean"), contains("std"))
    
#Writing the dataset into one csv file
    
    write.csv(Tidy, "C:\\Users\\me-ch\\Downloads\\Graduate Courses\\Miscellaneous\\Data Science Specialization\\Getting and Cleaning Data\\Project\\run_analysis.csv")

#Uses descriptive activity names to name the activities in the data set.
               
    Tidy$code <- activities[Tidy$code, 2]

#Labeling descriptive variable names in the dataset

                      names(Tidy)[2] = "activity"
                      names(Tidy)<-gsub("Acc", "Accelerometer", names(Tidy))
                      names(Tidy)<-gsub("Gyro", "Gyroscope", names(Tidy))
                      names(Tidy)<-gsub("BodyBody", "Body", names(Tidy))
                      names(Tidy)<-gsub("Mag", "Magnitude", names(Tidy))
                      names(Tidy)<-gsub("^t", "Time", names(Tidy))
                      names(Tidy)<-gsub("^f", "Frequency", names(Tidy))
                      names(Tidy)<-gsub("tBody", "TimeBody", names(Tidy))
                      names(Tidy)<-gsub("-mean()", "Mean", names(Tidy), ignore.case = TRUE)
                      names(Tidy)<-gsub("-std()", "STD", names(Tidy), ignore.case = TRUE)
                      names(Tidy)<-gsub("-freq()", "Frequency", names(Tidy), ignore.case = TRUE)
                      names(Tidy)<-gsub("angle", "Angle", names(Tidy))
                      names(Tidy)<-gsub("gravity", "Gravity", names(Tidy))

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

            Final <- Tidy %>%
            group_by(subject, activity) %>%
            summarise_all(mean)
            
            write.table(Final, "Final.txt", row.name=FALSE)


#verifying the contents of the "Final" text file in a csv 

  write.csv(Final, "C:\\Users\\me-ch\\Downloads\\Graduate Courses\\Miscellaneous\\Data Science Specialization\\Getting and Cleaning Data\\Project\\Final.csv")
