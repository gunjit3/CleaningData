library(plyr)
library(reshape2)

getData <- function (type)
{
    data <- read.table(paste(type,"/X_", type, ".txt", sep = ""))
    features <- read.table("features.txt", as.is = T)
    names(data) <- features$V2
    
    data <- data[,setdiff(grep("mean|std", features$V2, ignore.case=T),
                          grep("BodyBody.+mean|BodyBody.+std", features$V2, ignore.case=T)
                          )
                 ]

    data$Activity <- join(read.table(paste(type,"/y_", type, ".txt", sep = "")),
                          read.table("activity_labels.txt"))[,"V2"]
    
    subjectData <- read.table(paste(type,"/subject_", type, ".txt", sep = ""))
    data$subject <- subjectData$V1
    
    rm(list=c("subjectData"))
    data <- data[,c(length(data), length(data) -1, 1:(length(data)-2))]
    data
}

list <- lapply(c("train", "test"), getData)
finalData <- rbind(list[[1]], list[[2]])
rm(list=c("list"))

finalData$subject <- factor(finalData$subject)
tidyData <- ddply(finalData, .(subject, Activity), numcolwise(mean))
rm(list=c("finalData"))

names(tidyData) <- gsub("\\(|\\)|,|-","",names(tidyData))
names(tidyData) <- gsub("mean","Mean",names(tidyData))
names(tidyData) <- gsub("std","Std",names(tidyData))

tidyData <- dcast(melt(tidyData, id=c("subject","Activity")), subject + variable ~ Activity, max)
names(tidyData) <- sub("variable", "Measurement", names(tidyData))
write.csv(tidyData, file="tidyData.csv", row.names=F)
