#This script is intended to extract the data from the 
#different files containing it and put it, tided in a large data frames
#The code is divided into two parts. The first part prepares a dataset
#called bodyMotionExperimentData3 and the second part  prepares a dataset
#called bodyMotionExperimentData5


## First part ##


#This paragraphs selects all the information contained in the data files of
# this exercice. it selects also only the variables that correspond to a mean
#or and std operation. The returned dataframe is called bodyMotionExperimentData3
#it contains the columns "test/train","subject","activity","features", "FeatureOperation"
#The first three columns are the parameters of each measurement. The fourth and fifth columns
#contain lists. Each of the fourth column elements is a list of all the expected variable
#for this measurement. Each of the fifth column element is a list containing the names of the
#variables of the fourth column corresponding element.



#setwd('R/CleaningData/Week4/')

##Train datasets

#DataFrame Creation
bodyMotionExperimentData<-data.frame("test/train","subject","activity","features", "FeatureOperation",stringsAsFactors = FALSE)
X<-data.frame("X1"=matrix(unlist(read.csv("data/UCI HAR Dataset/train/subject_train.txt",header = F)), ncol=1))
bodyMotionExperimentData[1:nrow(X),]<-NA

#Column subject
bodyMotionExperimentData$X.subject.<-X$X1

#Column test/train
bodyMotionExperimentData$X.test.train.<-"Train"

#Column Activity
X<-data.frame("X1"=matrix(unlist(read.csv("data/UCI HAR Dataset/train/y_train.txt",header = F)), ncol=1))
bodyMotionExperimentData$X.activity.<-X$X1
bodyMotionExperimentData$X.activity.<-as.character(bodyMotionExperimentData$X.activity.)
bodyMotionExperimentData$X.activity.<-gsub("1","WALKING",bodyMotionExperimentData$X.activity.)
bodyMotionExperimentData$X.activity.<-gsub("2","WALKING_UPSTAIRS",bodyMotionExperimentData$X.activity.)
bodyMotionExperimentData$X.activity.<-gsub("3","WALKING_DOWNSTAIRS",bodyMotionExperimentData$X.activity.)
bodyMotionExperimentData$X.activity.<-gsub("4","SITTING",bodyMotionExperimentData$X.activity.)
bodyMotionExperimentData$X.activity.<-gsub("5","STANDING",bodyMotionExperimentData$X.activity.)
bodyMotionExperimentData$X.activity.<-gsub("6","LAYING",bodyMotionExperimentData$X.activity.)


#Features info and values
library(reshape2)
FeatureNames <- read.csv("data/UCI HAR Dataset/features.txt",header = F, sep="", na.strings ="", stringsAsFactors= F)
ProcessedFeatures<-colsplit(FeatureNames$V2,"-",c("Variable","Operation","Coordinate"))
ProcessedFeatures$Operation<-gsub(pattern = "\\(","",ProcessedFeatures$Operation)
ProcessedFeatures$Operation<-gsub(pattern = "\\)","",ProcessedFeatures$Operation)
FeatureValues <- read.csv("data/UCI HAR Dataset/train/X_train.txt",header = F, sep="", na.strings ="", stringsAsFactors= F)
j=1
SelectedFeatures <- vector(mode = "list", length = 1)
for (i in 1:length(ProcessedFeatures[,"Operation"])){
  if (ProcessedFeatures[i,"Operation"]=="mean" || ProcessedFeatures[i,"Operation"]=="std"){
    SelectedFeatures[[1]][j]<-i
    j=j+1
  }
}
for (i in 1:length(bodyMotionExperimentData$X.FeatureOperation.)){
  bodyMotionExperimentData$X.FeatureOperation.[i]<-list(FeatureNames$V2[SelectedFeatures[[1]]])
  bodyMotionExperimentData$X.features.[i]<-list(FeatureValues[i,SelectedFeatures[[1]]])
}



##Test datasets

#DataFrame Creation
bodyMotionExperimentData2<-data.frame("test/train","subject","activity","features", "FeatureOperation",stringsAsFactors = FALSE)
X<-data.frame("X1"=matrix(unlist(read.csv("data/UCI HAR Dataset/test/subject_test.txt",header = F)), ncol=1))
bodyMotionExperimentData2[1:nrow(X),]<-NA


#Column subject
bodyMotionExperimentData2$X.subject.<-X$X1

#Column test/train
bodyMotionExperimentData2$X.test.train.<-"Test"

#Column Activity
X<-data.frame("X1"=matrix(unlist(read.csv("data/UCI HAR Dataset/test/y_test.txt",header = F)), ncol=1))
bodyMotionExperimentData2$X.activity.<-X$X1
bodyMotionExperimentData2$X.activity.<-as.character(bodyMotionExperimentData2$X.activity.)
bodyMotionExperimentData2$X.activity.<-gsub("1","WALKING",bodyMotionExperimentData2$X.activity.)
bodyMotionExperimentData2$X.activity.<-gsub("2","WALKING_UPSTAIRS",bodyMotionExperimentData2$X.activity.)
bodyMotionExperimentData2$X.activity.<-gsub("3","WALKING_DOWNSTAIRS",bodyMotionExperimentData2$X.activity.)
bodyMotionExperimentData2$X.activity.<-gsub("4","SITTING",bodyMotionExperimentData2$X.activity.)
bodyMotionExperimentData2$X.activity.<-gsub("5","STANDING",bodyMotionExperimentData2$X.activity.)
bodyMotionExperimentData2$X.activity.<-gsub("6","LAYING",bodyMotionExperimentData2$X.activity.)



#Features info
library(reshape2)
FeatureNames <- read.csv("data/UCI HAR Dataset/features.txt",header = F, sep="", na.strings ="", stringsAsFactors= F)
ProcessedFeatures<-colsplit(FeatureNames$V2,"-",c("Variable","Operation","Coordinate"))
ProcessedFeatures$Operation<-gsub(pattern = "\\(","",ProcessedFeatures$Operation)
ProcessedFeatures$Operation<-gsub(pattern = "\\)","",ProcessedFeatures$Operation)
FeatureValues <- read.csv("data/UCI HAR Dataset/test/X_test.txt",header = F, sep="", na.strings ="", stringsAsFactors= F)
j=1
SelectedFeatures <- vector(mode = "list", length = 1)
for (i in 1:length(ProcessedFeatures[,"Operation"])){
  if (ProcessedFeatures[i,"Operation"]=="mean" || ProcessedFeatures[i,"Operation"]=="std"){
    SelectedFeatures[[1]][j]<-i
    j=j+1
  }
}

for (i in 1:length(bodyMotionExperimentData2$X.FeatureOperation.)){
  bodyMotionExperimentData2$X.FeatureOperation.[i]<-list(FeatureNames$V2[SelectedFeatures[[1]]])
  bodyMotionExperimentData2$X.features.[i]<-list(FeatureValues[i,SelectedFeatures[[1]]])
}


bodyMotionExperimentData3<-rbind(bodyMotionExperimentData,bodyMotionExperimentData2)



## Second part : calculate means of the selected above

#The expected dataset for this part is called bodyMotionExperimentData5
#It contains four columns "Subject","Activity","VariablesMeans","VariableNames"
#The first column is the subject, the second the activity. The third and fourth 
#columns contain lists. Each element of the third column contains the list of the 
#means of the variables selected in the previous paragraph, for one subject and 
#one activity.


SetSubject<-unique(bodyMotionExperimentData3$X.subject.)
SetActivity<-unique(bodyMotionExperimentData3$X.activity.)
FinalDataSet<-data.frame("Subject","Activity","VariablesMeans","VariableNames")


complexMean <- function(structList) {
  result <- list()
  for (i in 1:length(structList[[1]])){
    Mean<-0
    for (k in 1:length(structList)){
    Mean<-Mean+structList[[k]][i]
    }
    Mean<-Mean/length(structList)
    result<-c(result,Mean)
  }
  return(result)
}

Features<-bodyMotionExperimentData3$X.features.
bodyMotionExperimentData5<-data.frame("subject","activity","features", "FeatureOperation",stringsAsFactors = FALSE)
bodyMotionExperimentData5[1:180,]<-NA
bodyMotionExperimentData4<-vector(mode="list",length=1)
number<-1
for (i in SetActivity){
  for (j in SetSubject){
    bodyMotionExperimentData5[number,"X.subject."]<-j
    bodyMotionExperimentData5[number,"X.activity."]<-i
    var=1
    SelectedValues <- vector(mode = "list", length = 1)
    for (k in 1:nrow(bodyMotionExperimentData3)){
      if (bodyMotionExperimentData3$X.subject.[k]==j && bodyMotionExperimentData3$X.activity.[k]==i && !is.na(Features[k])){
        SelectedValues[[1]][var]<-k
        var<-var+1
      }
    }
    bodyMotionExperimentData4[number]<-NULL
    if (var>1){
      Y<-matrix(do.call(rbind, complexMean(Features[SelectedValues[[1]]])) ,dimnames = NULL, ncol = 1)[,1]
      bodyMotionExperimentData4[number]<-list(c(unlist(Y)))
    }
    number<-number+1
    print(number)
  }
}
bodyMotionExperimentData4[181]<-NULL

for (i in 1:length(bodyMotionExperimentData5$X.FeatureOperation.)){
  bodyMotionExperimentData5$X.FeatureOperation.[i]<-list(FeatureNames$V2[SelectedFeatures[[1]]])
}

bodyMotionExperimentData5$X.features.<-bodyMotionExperimentData4
