#Merges the training and the test sets to create one data set.
#Extracts only the measurements on the mean and standard deviation for each measurement. 
#Uses descriptive activity names to name the activities in the data set
#Appropriately labels the data set with descriptive variable names. 
#From the data set in step 4, creates a second, independent tidy data set with the average 
#  of each variable for each activity and each subject.

#reading separate data sets
test<-read.table("C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\Module 3\\UCI HAR Dataset\\test\\X_test.txt", sep="", header=F)
train<-read.table("C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\Module 3\\UCI HAR Dataset\\train\\X_train.txt", sep="", header=F)
merge<-rbind(test, train) #merging the 2 data sets together

#getting variable features
names<-read.table("C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\Module 3\\UCI HAR Dataset\\features.txt", sep="", header=F)
newname<-sub("\\()", "", names$V2) #removing all instances of ()
newname2<-sub("^t","Time", newname)
newnames<-sub("^f","Frequency", newname2)
names(merge)<-newnames #adding variable names to 'merge' dataframe

meansd<-grep("mean|std",newnames) #selecting all the instances with mean or std in the name
DF<-merge[,meansd] #selecting all the variable with mean or std

#adding activity to DF
activity.test<-read.table("C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\Module 3\\UCI HAR Dataset\\test\\Y_test.txt", sep="", header=F)
activity.train<-read.table("C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\Module 3\\UCI HAR Dataset\\train\\Y_train.txt", sep="", header=F)
activity.total<-rbind(activity.test,activity.train) #combining the 2 activity lists
DF$activity=activity.total[[1]]

#####means and SD summary for each variable
#adding subjects
suj.test<-read.table("C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\Module 3\\UCI HAR Dataset\\test\\subject_test.txt", sep="", header=F)
suj.train<-read.table("C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\Module 3\\UCI HAR Dataset\\train\\subject_train.txt", sep="", header=F)
suj.total<-rbind(suj.test, suj.train) #merging 2 subject lists together
DF$subject<-suj.total[[1]]
DF$subject=factor(DF$subject)

write.table(DF, file="C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\test.txt", sep="\t")

library(reshape2)
mdf<-melt(DF, id=c(81)) #specify factors
dfcast<-dcast(mdf, subject~variable, mean)

write.table(dfcast, file="C:\\Users\\Evil Plushie\\Dropbox\\Coursera\\CourseProject.txt", sep="\t", row.names=F)





