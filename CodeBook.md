############################################################################
## Project: Getting and Cleaning Data Course
## Analyst: Larry
## Date: September 28, 2020
## Goal: Collect, work with, and clean data collected from Samsung Galaxy S
## smartphone accelerometers. Activity was collected for 30 subjects.
############################################################################


############
STUDY DESIGN
############

The raw data for the project was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

I utilized the features.txt, activity_labels.txt, train/X_train.txt, train/y_train.txt,
test/X_test.txt, test/y_test.txt, train/subject_train.txt, and test/subject_test.txt 
files for this exercise.

[The original README.txt file (attached below) describes each of these files. A full 
description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .]

The code extracted 66 columns from the x files; specifically those columns with variable
names that included mean() for the mean value or std() for the standard deviation.
Note: I wasn't sure whether to include or exclude variables with meanFreq(); since 
meanFreq() is a weighted average of the frequency components to obtain a mean frequency. 
I debated, but ultimately chose to exclude variables with meanFreq(); since I wasn't 
specifically instructed to include them. 

I averaged the 66 extracted columns from the x files for
each activity and subject. 


#########
CODE BOOK
#########

Transformations: 
----------------
- The training and the test files were combined.
- The labels in the activity_label files were used to add descriptions to the y files.
- The feature nmes from the features.txt file wwas used as labels in the x dataset.
- The subject, x, and y files were combined into one dataset.
- As instructed, I averaged the 66 extracted columns from the x files for
each activity and subject. 

Variables: 
----------
Following is a variable listing. The variable names are from the features.txt file.
I modified the variable names to prefix avg (so we know they are averages), and 
removed the dashes (-) and parentheses () characters.

- The activity variable was derived from the y text files the activity_labels text files.
- The subject_id variable came from the subject test files.
- The other 66 variables are averages of mean and standard deviation columns (by activity and
  subject) from the x files.
- The units were specified in the website.

ID	||	VARIABLE_NAME	             ||	TYPE	   ||	UNITS	  ||	NOTES
----||-----------------------------||----------||---------||----------------------------------
1	  ||	activity	                 ||	character||		      || see activity_labels.txt
2	  ||	subject_id	               ||	integer	 ||		      || subjects are indexed from 1 to 30
3	  ||	avgtBodyAccmeanX	         ||	double	 ||	g's	    || 	
4	  ||	avgtBodyAccmeanY	         ||	double	 ||	g's	    ||	
5	  ||	avgtBodyAccmeanZ	         ||	double	 ||	g's	    ||	
6	  ||	avgtBodyAccstdX	           ||	double	 ||	g's	    ||	
7	  ||	avgtBodyAccstdY	           ||	double	 ||	g's	    ||	
8	  ||	avgtBodyAccstdZ	           ||	double	 ||	g's	    ||	
9	  ||	avgtGravityAccmeanX	       ||	double	 ||	g's	    ||	
10	||	avgtGravityAccmeanY	       ||	double	 ||	g's	    ||	
11	||	avgtGravityAccmeanZ	       ||	double	 ||	g's	    ||	
12	||	avgtGravityAccstdX	       ||	double	 ||	g's	    ||	
13	||	avgtGravityAccstdY	       ||	double	 ||	g's	    ||	
14	||	avgtGravityAccstdZ	       ||	double	 ||	g's	    ||	
15	||	avgtBodyAccJerkmeanX	     ||	double	 ||	g's	    ||	
16	||	avgtBodyAccJerkmeanY	     ||	double	 ||	g's	    ||	
17	||	avgtBodyAccJerkmeanZ	     ||	double 	 ||	g's	    ||	
18	||	avgtBodyAccJerkstdX	       ||	double	 ||	g's	    ||	
19	||	avgtBodyAccJerkstdY	       ||	double	 ||	g's	    ||	
20	||	avgtBodyAccJerkstdZ        ||	double	 ||	g's	    ||	
21	||	avgtBodyGyromeanX	         ||	double	 ||	rad/seg	|| 	
22	||	avgtBodyGyromeanY	         ||	double	 ||	rad/seg	||	
23	||	avgtBodyGyromeanZ	         ||	double	 ||	rad/seg	||	
24	||	avgtBodyGyrostdX	         ||	double	 ||	rad/seg	||	
25	||	avgtBodyGyrostdY	         ||	double	 ||	rad/seg	||	
26	||	avgtBodyGyrostdZ	         ||	double	 ||	rad/seg	||	
27	||	avgtBodyGyroJerkmeanX	     ||	double	 ||	rad/seg	||	
28	||	avgtBodyGyroJerkmeanY	     ||	double	 ||	rad/seg	||	
29	||	avgtBodyGyroJerkmeanZ	     ||	double	 ||	rad/seg	||	
30	||	avgtBodyGyroJerkstdX	     ||	double	 ||	rad/seg	||	
31	||	avgtBodyGyroJerkstdY	     ||	double	 ||	rad/seg	||	
32	||	avgtBodyGyroJerkstdZ	     || double	 ||	rad/seg	||	
33	||	avgtBodyAccMagmean	       ||	double	 ||	g's	    ||	
34	||	avgtBodyAccMagstd	         ||	double	 ||	g's	    ||	
35	||	avgtGravityAccMagmean	     ||	double	 ||	g's	    ||	
36	||	avgtGravityAccMagstd	     ||	double	 ||	g's	    ||	
37	||	avgtBodyAccJerkMagmean	   ||	double	 ||	g's	    ||	
38	||	avgtBodyAccJerkMagstd	     ||	double	 ||	g's	    ||	
39	||	avgtBodyGyroMagmean	       ||	double	 ||	rad/seg	||	
40	||	avgtBodyGyroMagstd	       ||	double	 ||	rad/seg	||	
41	||	avgtBodyGyroJerkMagmean	   ||	double	 ||	rad/seg	||	
42	||	avgtBodyGyroJerkMagstd	   ||	double	 ||	rad/seg	||	
43	||	avgfBodyAccmeanX	         ||	double	 ||	g's	    ||	
44	||	avgfBodyAccmeanY	         ||	double	 ||	g's	    ||	
45	||	avgfBodyAccmeanZ	         ||	double	 ||	g's	    ||	
46	||	avgfBodyAccstdX	           ||	double	 ||	g's	    ||	
47	||	avgfBodyAccstdY	           ||	double	 ||	g's	    ||	
48	||	avgfBodyAccstdZ	           ||	double	 ||	g's	    ||	
49	||	avgfBodyAccJerkmeanX	     ||	double	 ||	g's	    ||	
50	||	avgfBodyAccJerkmeanY	     ||	double	 ||	g's	    ||	
51	||	avgfBodyAccJerkmeanZ	     ||	double	 ||	g's	    ||	
52	||	avgfBodyAccJerkstdX	       ||	double	 ||	g's	    ||	
53	||	avgfBodyAccJerkstdY	       ||	double	 ||	g's	    ||	
54	||	avgfBodyAccJerkstdZ	       ||	double	 ||	g's	    ||	
55	||	avgfBodyGyromeanX	         ||	double	 ||	rad/seg	||	
56	||	avgfBodyGyromeanY	         ||	double	 ||	rad/seg	||	
57	||	avgfBodyGyromeanZ	         ||	double	 ||	rad/seg	||	
58	||	avgfBodyGyrostdX	         ||	double	 ||	rad/seg	||	
59	||	avgfBodyGyrostdY	         ||	double	 ||	rad/seg	||	
60	||	avgfBodyGyrostdZ	         ||	double	 ||	rad/seg	||	
61	||	avgfBodyAccMagmean	       ||	double	 ||	g's	    ||	
62	||	avgfBodyAccMagstd	         ||	double	 ||	g's	    ||	
63	||	avgfBodyBodyAccJerkMagmean ||	double	 ||	g's	    ||	
64	||	avgfBodyBodyAccJerkMagstd  ||	double	 ||	g's	    ||	
65	||	avgfBodyBodyGyroMagmean	   ||	double	 ||	rad/seg	||	
66	||	avgfBodyBodyGyroMagstd	   ||	double	 ||	rad/seg	||	
67	||	avgfBodyBodyGyroJerkMagmean||	double	 ||	rad/seg	||	
68	||	avgfBodyBodyGyroJerkMagstd ||	double	 ||	rad/seg	||	



Following is the README file that came with the raw data:

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
