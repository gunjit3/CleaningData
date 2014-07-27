#load the plyr package for ddply and reshape 2 for melt and dcast
library(plyr)
library(reshape2)

# this function will take the folder name (test/train) and will do the task of reading data, filtering columns, applying
# activity labels and subject ids and applying feature names. this function is called two times once for train and once
# for test folder

getData <- function (type)
{
    # read the X_train or X_test data from train or test folder based in input
    data <- read.table(paste(type,"/X_", type, ".txt", sep = ""))

    # read the features data
    features <- read.table("features.txt", as.is = T)

    #name the columns appropriately based on feature names
    names(data) <- features$V2
    
    # filter the columns which does not contain mean and std in their name. Also filter the column with BodyBody in their
    # name, I think these columns are noise. Setdiff function is used to remove the bodybody mean 
    # and std columns from all mean and std columns
    data <- data[,setdiff(grep("mean|std", features$V2, ignore.case=T),
                          grep("BodyBody.+mean|BodyBody.+std", features$V2, ignore.case=T)
                          )
                 ]

    # read the activity_lables data and read the y_train or y_test data based on the input. Join the two data on 
    # Acivity number and add as a new column names Activity to the data
    data$Activity <- join(read.table(paste(type,"/y_", type, ".txt", sep = "")),
                          read.table("activity_labels.txt"))[,"V2"]

    # add the subject information to the data.
    subjectData <- read.table(paste(type,"/subject_", type, ".txt", sep = ""))
    data$subject <- subjectData$V1

    # remove the temp variable used     
    rm(list=c("subjectData"))

    # reorder the data frame to contain the subject and activity as first two column. Till now subject is the last column
    # and Activity is second last column.
    data <- data[,c(length(data), length(data) -1, 1:(length(data)-2))]

    # return data
    data
}

# Apply the getData method on both test and train folders to obtain test and training datasets using the lapply function.
list <- lapply(c("train", "test"), getData)

# lapply return a list, so merge both data rowwise using rbind function and remove the list.
finalData <- rbind(list[[1]], list[[2]])
rm(list=c("list"))

# change the subject column to be a factor
finalData$subject <- factor(finalData$subject)

# apply ddply function to get the average of each variable for a subject and activity
tidyData <- ddply(finalData, .(subject, Activity), numcolwise(mean))
rm(list=c("finalData"))

# clean up the column names to remove parentheses, comma, and hyphen and capitalize first letter of mean and std
names(tidyData) <- gsub("\\(|\\)|,|-","",names(tidyData))
names(tidyData) <- gsub("mean","Mean",names(tidyData))
names(tidyData) <- gsub("std","Std",names(tidyData))

# melt the data on subject and activity as id and dacst it to have activity as columns and each of the 
# variable as a row
tidyData <- dcast(melt(tidyData, id=c("subject","Activity")), subject + variable ~ Activity, max)

# convert the column names to lowe case
names(tidyData) <- tolower(names(tidyData))

# write the data to a file. Once csv and one txt
write.table(tidyData, file="tidyData.txt", row.names=F, quote=F)
write.csv(tidyData, file="tidyData.csv", row.names=F, quote=F)
