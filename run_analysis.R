#path to the folder with data insert your path in qoutes. 
# Instead data must be in your working directory 
root.path <- "";


#reading the features & activities
feat.list <- read.table(paste0(root.path,"features.txt"));
features <- as.character(feat.list[,2]);

activity.list <- read.table(paste0(root.path,"activity_labels.txt"));
activity<-as.character(activity.list[,2])


######################################################################################




#reading the test data set
Data.train.X <- read.table(paste0(root.path,"train/X_train.txt"));
names(Data.train.X) <- features;

Data.train.y <- read.table(paste0(root.path,"train/y_train.txt"));

#replacing codes of activity with descriptive activity names 
Data.train.activity <- rep(NA, dim(Data.train.y)[1])

for (i in 1:dim(activities.list)[1])
{
  Data.train.activity[Data.train.y == i] <- activity[i];
}

names(Data.train.activity) <- "activity";



Data.train.subjects <- read.table(paste0(root.path,"train/subject_train.txt"));
names(Data.train.subjects) <- "subject_id";

#The marker of training/test subset
test.train.tag <- as.factor(rep("train", dim(Data.train.y)[1]));
names(test.train.tag) <- "train_test";


#Merging the train data set
Data.train.total <- cbind(test.train.tag,Data.train.subjects, Data.train.activity, Data.train.X);
names(Data.train.total)[3]="activity"


############################################################################################




#reading the test data set
Data.test.X <- read.table(paste0(root.path,"test/X_test.txt"));
names(Data.test.X) <- features;

Data.test.y <- read.table(paste0(root.path,"test/y_test.txt"));

#replacing codes of activity to descriptive activity names 
Data.test.activity <- rep(NA, dim(Data.test.y)[1])

for (i in 1:dim(activities.list)[1])
     {
      Data.test.activity[Data.test.y == i] <- activity[i];
     }

names(Data.test.activity) <- "activity";


Data.test.subjects <- read.table(paste0(root.path,"test/subject_test.txt"));
names(Data.test.subjects) <- "subject_id";

#The marker of testing/test subset
test.train.tag <- as.factor(rep("test", dim(Data.test.y)[1]));
names(test.train.tag) <- "train_test";

 
#Merging the test data set
Data.test.total <- cbind(test.train.tag,Data.test.subjects, Data.test.activity, Data.test.X);

names(Data.test.total)[3]="activity";

##########################################################################################

#Merging the train and the test data sets

Data.total <- rbind(Data.train.total,Data.test.total)


# extracting the mean and standard deviation for each measurement

#search of the variables with names containing "mean()" or "std()"
means_id <- grep("mean()", features, fixed=T);
std_id <- grep("std()", features, fixed=T);

feat_ms <- sort(c(means_id,std_id));



Data.MeansAndStd <- cbind(Data.total[,1:3], Data.total[,feat_ms+3])
write.table(Data.MeansAndStd, "samsung_data_means_std.txt", sep="\t", quote=F, row.names=F)


######################################################################################

# creating separate data set with  the average of each variable for each activity and each subject 

library(plyr);
Data.averages<-ddply(Data.total[,4:dim(Data.total)[2]], .(Data.total$subject_id, Data.total$activity), colwise(mean))

write.table(Data.averages, "samsung_data_all_averages.txt", sep="\t", quote=F, row.names=F)

