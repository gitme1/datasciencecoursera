#Store the paths
testpath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\test\\X_test.txt"
trainpath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\train\\X_train.txt"
ytestpath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\test\\y_test.txt"
ytrainpath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\train\\y_train.txt"
subtestpath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\test\\subject_test.txt"
subtrainpath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\train\\subject_train.txt"
featurespath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\features.txt"
activitylabelspath="E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\UCI HAR Dataset\\activity_labels.txt"


#Read files X_test,X_train.y_test,y_train,Subject_test,Subject_train,features and 
#activity_lables text files into dataframes.
testdata = read.table(testpath)
traindata = read.table(trainpath)
ytestdata= read.table(ytestpath)
ytraindata= read.table(ytrainpath)
subtestdata= read.table(subtestpath)
subtraindata= read.table(subtrainpath)
featuresdata= read.table(featurespath)
activitydata= read.table(activitylabelspath)

#Column bind Dataframes y_test and subject_test and add column names Activity and Subject to it. ->A
names(ytestdata)[names(ytestdata)=="V1"] <- "Activity"
names(subtestdata)[names(subtestdata)=="V1"] <- "Subject"
A = cbind(ytestdata,subtestdata)

#Column bind Dataframes y_train and subject_train and add column names Activity and Subject to it. ->B
names(ytraindata)[names(ytraindata)=="col1"] <- "Activity"
names(subtraindata)[names(subtraindata)=="V1"] <- "Subject"
B = cbind(ytraindata,subtraindata)

#Merge A and B (dim-10299*2) ->C
# Replace activity numbers with Activity names from activity_labels.txt-> Final Table
C= rbind(A,B)
names(activitydata)[names(activitydata)=="V2"] <- "Activity"
C$Activity<-activitydata[match(C$Activity, as.integer(activitydata$Activity)),2]

#Merge X_train and X_test data -> D (dim-10299*561)
D = rbind(traindata,testdata)

#Change column names of D from features.txt
D=setNames(D, featuresdata$V2)

#Eliminate columns from D which do not have "mean()" or "std()" in the column names. ->E (dim-10299*66)
E = D[grep("(mean|std)",names(D))]
X = names(E[grep("meanFreq",names(E))])
E <- E[, !colnames(E) %in% c(X)]

#Column bind C and E (dim-10299*68)
F = cbind(C,E)
names(F) <- gsub("[()-]", "", names(F))

#Take mean of observations per activity per subject. (dim-180*68). 
t=split(F,list(F$Activity,F$Subject))
p=names(F[,3:68])
Finaltable=lapply(t,function(x) colMeans(x[,c(p)]))

#use write.table to get a text file from the above Data Frame
write.table(Finaltable, "E:\\Ravi\\Coursera\\DataScientist\\Getting & Cleaning Data\\Finaldata.txt", sep="\t") 

12. Prepare code book

13. and Read me document

14. Upload "run_analysis.R", "code book" and "read me" files to Github and Share the link for Question 2 of Assessment





