This README has two parts.

1- Presentation of the data
2- Presentation of the analysis code to tidy and select some of the data into large R dataset.



#################################
Part 1 : Presentation of the data
#################################


#The following folder contains the data related to the experiment
"==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
=================================================================="

By:
"Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova."

The data resulting from the experiment is described by the author:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details."




#####################################
Part 2 : Presentation of the analysis 
	 code to tidy and select some 
	 of the data into large R 
	 dataset.
#####################################


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

The data frame bodyMotionExperimentData3 contains data such as:

"test/train"	|	"subject"	|	"activity"	|	"var1Name"	|	"var2Name"

[1] test		   1			  "WALKING"		        var1    		  var2

Where for instance var1 could be 0.9992116 and var1Name is the corresponding name e.g. "tGravityAcc-mean()-Z"

Only the mean and std operation variables where selected.




## Second part : calculate means of the above selected variables keeping subject and activity ## 

#The expected dataset for this part is called bodyMotionExperimentData5
#It contains the first two columns "Subject","Activity",
#The first column is the subject, the second the activity. The next 
#columns contain the variables mean. The name of the column indicate the variable 
#operation

The resulting data frame bodyMotionExperimentData5 contains data such as:

"subject"	|	"activity"	|	"Var1Name"	|	"Var2Name"

[1] 1			 "WALKING"		  var1Mean  		var2Mean

Where for instance var1Mean could be 0.9992116 and var1MeanName is the corresponding name e.g. "43 tGravityAcc-mean()-Z"
var1Mean was calculated by averaging all the var1 of the bodyMotionExperimentData5$Feature array corresponding to the same
subject and the same activity.

Only the mean and std operation variables where selected.
