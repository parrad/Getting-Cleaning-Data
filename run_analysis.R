url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- paste0(getwd(),"getdata-projectfiles-UCI HAR Dataset")
download.file(url, destfile, quiet=TRUE)
unzip(destfile)
unlink(destfile)
train.dir <- dir('UCI HAR Dataset/train')[-1]
test.dir <- dir('UCI HAR Dataset/test')[-1]
train.list <- lapply(as.list(train.dir), function(x) read.table(paste0(getwd(),'/UCI HAR Dataset/train/',x)))
test.list <- lapply(as.list(test.dir), function(y) read.table(paste0(getwd(),'/UCI HAR Dataset/test/',y)))
subjects.df <- rbind(train.list[[1]], test.list[[1]])
features.df <- rbind(train.list[[2]], test.list[[2]])
activities.df <- rbind(train.list[[3]], test.list[[3]])
feature.labels <- read.table(paste0(getwd(),'/UCI HAR Dataset/features.txt'), col.names=c('feature.id', 'feature.desc'), stringsAsFactors=FALSE)
activity.labels <- read.table(paste0(getwd(),'/UCI HAR Dataset/activity_labels.txt'), col.names=c('activity.id', 'activity.desc'), stringsAsFactors=FALSE)
feature.labels[,2] <- unlist(lapply(feature.labels[,2], function(x)
{
  if (grepl('mean', x) | grepl('std', x))
  {
    tolower(gsub('-', '.', paste(unlist(strsplit(x, "\\(\\)")), collapse="")))
  }
  else
  {
    x
  }
}))
names(features.df) <- feature.labels[,2]
names(subjects.df) <- 'subject.id'
names(activities.df) <- 'activity.id'
activities.df <- merge(activities.df, activity.labels, by.x = "activity.id", by.y = "activity.id")
df <- cbind(features.df, subjects.df, activities.df)
reqd.features <- grep('.mean', names(df), value=TRUE)
reqd.features <- c(reqd.features, grep('.std', names(df), value=TRUE))
reqd.features <- c(reqd.features, "subject.id", "activity.desc")
reqd.df <- df[reqd.features]
reqd.df$subject.id <- as.factor(reqd.df$subject.id)
reqd.df$activity.desc <- as.factor(reqd.df$activity.desc)
tidy.df <- aggregate(. ~ activity.desc + subject.id, data = reqd.df, mean)
write.table(tidy.df, "tidy.txt", col.names=TRUE, row.names=FALSE, sep="\t")
