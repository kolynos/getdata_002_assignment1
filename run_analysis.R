#calculates the averages for one feature and returns a data frame
calculate_mean_dataframe<-function(column)
{
  df<-as.data.frame(tapply(data_set[[column]],list(data_set$Activity,data_set$Subject),mean))
  df$Activity<-activity_names
  df$Feature<-column
  row.names(df)<-NULL
  df
}

#get the features used in this assignment
column_names<-readLines('UCI HAR Dataset/features.txt')
column_names<-as.character(sapply(column_names,function(s) strsplit(s, " ")[[1]][2]))
valid_columns<-column_names[grep("mean",column_names)]
valid_columns<-c(valid_columns,column_names[grep("std",column_names)])

#get activity names
activity_names<-readLines('UCI HAR Dataset/activity_labels.txt')
activity_names<-as.character(lapply(activity_names,function(x)substring(x,3)))

# load data
x_train<-read.table('./UCI HAR Dataset/train/X_train.txt')
colnames(x_train)<-column_names
y_train<-read.table('./UCI HAR Dataset/train/y_train.txt')
subjects_train<-read.table('./UCI HAR Dataset/train/subject_train.txt')
colnames(subjects_train)<-'Subject'
x_test<-read.table('./UCI HAR Dataset/test/X_test.txt')
colnames(x_test)<-column_names
y_test<-read.table('./UCI HAR Dataset/test/y_test.txt')
subjects_test<-read.table('./UCI HAR Dataset/test/subject_test.txt')
colnames(subjects_test)<-'Subject'

#subset training data, change activity names and add subect and activity columns
x_train_sub<-x_train[valid_columns]
y_train_factor<-as.factor(y_train[,])
levels(y_train_factor)<-activity_names
x_train_sub<-cbind(x_train_sub,subjects_train,Activity=y_train_factor)

#subset test data, change activity names and add subect and activity columns
x_test_sub<-x_test[valid_columns]
y_test_factor<-as.factor(y_test[,])
levels(y_test_factor)<-activity_names
x_test_sub<-cbind(x_test_sub,subjects_test,Activity=y_test_factor)

#merge datasets
data_set<-rbind(x_train_sub,x_test_sub)

#calculate averages for each feature
means_list<-lapply(valid_columns,function(c)calculate_mean_dataframe(c))
#merge list into one tidy dataframe
tidy_data<-do.call('rbind',means_list)
#write tidy tadaframe
write.csv(tidy_data,'tidy_data.csv',row.names=FALSE)
