#This script is intended to extract the data from the 
#different files containing it and put it, tided in a large data frame
#The code is divided into two parts. The first part prepares a dataset
#called bodyMotionExperimentData3 and the second part  prepares a dataset
#called FinalDataset that contain the elements required for the exercice.


## First part ##


#This paragraphs selects all the information contained in the data files of
# this exercice. it selects also only the variables that correspond to a mean
#or and std operation. The returned dataframe is called bodyMotionExperimentData3
#it contains the first three columns "test/train","subject","activity""
#The first three columns are the parameters of each measurement. Each of the following columns
#contains one of the variables calculated from the measurments. The column name is the operation
#executed to calculate the variable.
#

run_analysis<-function(){
  
  #setwd('R/CleaningData/Week4/')
  
  ##Train datasets
  
  #DataFrame Creation
  bodyMotionExperimentData<-data.frame("test/train","subject","activity",stringsAsFactors = FALSE)
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
  for (i in 1:length(ProcessedFeatures[,"Operation"])){
    if (ProcessedFeatures[i,"Operation"]=="mean" || ProcessedFeatures[i,"Operation"]=="std"){
      bodyMotionExperimentData[,FeatureNames$V2[i]]<-FeatureValues[,i]
      j=j+1
    }
  }
  
  
  
  ##Test datasets
  
  #creation of the dataset
  bodyMotionExperimentData2<-data.frame("test/train","subject","activity",stringsAsFactors = FALSE)
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
  for (i in 1:length(ProcessedFeatures[,"Operation"])){
    if (ProcessedFeatures[i,"Operation"]=="mean" || ProcessedFeatures[i,"Operation"]=="std"){
      bodyMotionExperimentData2[,FeatureNames$V2[i]]<-FeatureValues[,i]
      j=j+1
    }
  }

  
  bodyMotionExperimentData3<-rbind(bodyMotionExperimentData,bodyMotionExperimentData2)
  
  
  
  ## Second part : calculate means of the above selected variables keeping subject and activity ##
  
  #The expected dataset for this part is called bodyMotionExperimentData5
  #It contains the first two columns "Subject","Activity",
  #The first column is the subject, the second the activity. The next 
  #columns contain the variables mean. The name of the column indicate the variable 
  #operation
  
  
  SetSubject<-unique(bodyMotionExperimentData3$X.subject.)
  SetActivity<-unique(bodyMotionExperimentData3$X.activity.)
  FinalDataset<-bodyMotionExperimentData3[0,2:ncol(bodyMotionExperimentData3)]
  
  
  number<-1
  for (i in SetActivity){
    for (j in SetSubject){
      FinalDataset[number,"X.subject."]<-j
      FinalDataset[number,"X.activity."]<-i
      var=1
      Mean<-bodyMotionExperimentData3[0,4:ncol(bodyMotionExperimentData3)]
      Mean[1,]<-0
      for (k in 1:nrow(bodyMotionExperimentData3)){
        if (bodyMotionExperimentData3$X.subject.[k]==j && bodyMotionExperimentData3$X.activity.[k]==i){
          Mean<-Mean+bodyMotionExperimentData3[k,4:ncol(bodyMotionExperimentData3)]
          var<-var+1
        }
      }
      Mean<-Mean/var
      print(number)
      FinalDataset[number,3:ncol(FinalDataset)]<-Mean
      number<-number+1
    }
  }  
  
  return(FinalDataset)
}
