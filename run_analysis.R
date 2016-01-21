#Step 1
#Merges the training and the test sets to create one data set.
X_test<-read.table("./test/X_test.txt")
X_train<-read.table("./train/X_train.txt")
dat<-rbind(X_train,X_test)
Y_test<-read.table("./test/Y_test.txt")
Y_train<-read.table("./train/Y_train.txt")
label<-rbind(Y_train,Y_test)
subject_test<-read.table("./test/subject_test.txt")
subject_train<-read.table("./train/subject_train.txt")
subject<-rbind(subject_train,subject_test)

#Step2
#Extracts only the measurements on the mean and standard deviation for each measurement.
features<-read.table("features.txt")
meanstd<-grep("-mean[^F]|std",features[,2])
dat<-dat[,meanstd]
names(dat)<-gsub("\\(\\)","",features[meanstd,2])
names(dat)<-gsub("-"," ",names(dat))
names(dat)<-gsub("mean","Mean",names(dat))
names(dat)<-gsub("std","Std",names(dat))

#Step3
#Uses descriptive activity names to name the activities in the data set
activitylabels<-read.table("activity_labels.txt")
activitylabels<-activitylabels[,2]
activitylabels<-tolower(activitylabels)
activitylabels<-gsub("_"," ",activitylabels)
activitylabels<-activitylabels[label[,1]]#converts label from numbers to text

#Step4
#Appropriately labels the data set with descriptive variable names.
names(label)<-"activity"
names(subject)<-"subject"
tidydata<-cbind(subject,activitylabels ,dat)
write.table(tidydata,"TidyData.txt")

#Step5
#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
tidy<-tidydata
tidy[,1]<-sprintf("%02d", tidy[,1])
tidy<-transform(tidy,SubAct=paste0(subject,activitylabels))
tidy<-tidy[,c(-1,-2)]
AveDat<-ddply(tidy,.(SubAct),numcolwise(mean))
AveDat$subject<-substr(AveDat$SubAct,1,2)
activity<-c()
AveDat[,1]<-as.character(AveDat[,1])
for(x in 1:180){
     activity<-c(activity,substr(AveDat[x,1],3,nchar(AveDat[x,1])))
}
AveDat$activity<-activity
AveDat<-AveDat[,-1]
AveDat<-AveDat[,c(67,68,1:66)]
write.table(AveDat,"AverageData.txt")