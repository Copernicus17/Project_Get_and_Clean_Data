*******************************************************************************
Project: Getting and Cleaning Data Course Project - README.md
Author: Larry
Date 9/28/2020
*******************************************************************************

This README file explains how the run_analysis.R script works.
	
	
Background: 
-----------
This analysis collects, cleans, and prepares the data for modeling. The goal is
to prepare tidy data that can be used in later analysis. 

The data was collected from Samsung Galaxy S II smartphone accelerometers.  
Data was split into training and test datasets.  The data source was the Human 
Activity Recognition Using Smartphones Data set from the
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
website. 

The website and the README file that came with the data indicated 10,299 
instances (or observations), 510 attributes (or features / variables), and that
30 subjects (or volunteers) were tracked. In addition, '70% of the volunteers
was selected for generating the training data and 30% the test data.'


Overview of the run_analysis.R script:
--------------------------------------

The run_analysis.R script does the following:

1.	Merges the training and the test sets to create one data set.

2.	Extracts only the measurements on the mean and standard deviation for 
    each measurement. 
	
3.	Uses descriptive activity names to name the activities in the data set

4.	Appropriately labels the data set with descriptive variable names.
 
5.	From the data set in step 4, creates a second, independent tidy data set
    with the average of each variable for each activity and each subject.


How the run_analysis.R script works:
------------------------------------

The script was run with R version 4.0.2 (2020-06-22), and the dplyr (version:
dplyr_1.0.2) and readr (version: readr_1.3.1) packages. The dplyr package is 
used for data manipulation and transformation, and the readr package is 
used for reading the data files in.


I. The data files were downloaded from the internet and unzipped to a working 
directory. I viewed the files to see what the data looked like and represented.
I selected the subject_train.txt, subject_test.txt, x_train.txt, x_test.txt, 
y_train.txt, y_test.txt, features.txt, and activity_labels.txt data files.

A very rough high-level outline of how the files were combined and manipulated:

  - combine subject_train and subject_test datasets to create a subject dataset
  - combine y_train and y_test datasets to create an activities dataset
  - combine x_train and x_test datasets to create an x dataset
  - add variable names from the features dataset to the x dataset
  - identify the mean and std features and extract only those features from x dataset
  - add labels from activity_labels dataset to the activities dataset
  - combine the subject, activities, and x datasets (output is a tidy dataset)
  - create averages by subject and activity, and write the tidy dataset to a file.
  
A more detailed outline follows:

The files were white-spaced separated, so I used the read_table2() function (from 
the readr package) to read them in and parse them. Files were read in as tibbles 
and the column formats were automtically displayed in the log. 

Following are descriptions and observations for each file that I downloaded nd parsed:

(a) For the subject, x, and y files, I verified that there were 7,352 observations
(71.4%) in the training files and 2,947 observations (28.6%) in the test files; 
for a total of 10,299 observations.

(b) The subject_train and the subject_test files identified the subjects (or 
volunteers) associated with each observation. Using the unique() function, 
I verified that there were 21 subjects (70%) in the subject_train.txt and 9 subjects
(30%) subject_test.txt.  

(c) The y_train.txt and the y_test.txt files contained the activity ids for each 
observation. Each person performed six activities. [Using the unique() function II
verified that all activity ids fall in the 1 to 6 range.]

(d) The activity_labels.txt file lists the labels associated with the six 
activity_ids. The six activity labels are 1 = WALKING, 2 = WALKING_UPSTAIRS, 
3 = WALKING_DOWNSTAIRS, 4 = SITTING, 5 = STANDING, and 6 = LAYING. [The y_test.txt
and y_train.txt files contain the activity_ids that were associated with each 
observation.]

(e) The features.txt file lists the names of the 561 features that are collected 
for each observaton. [Each observation is associated with a specific subject (or
volunteer), activity, and (time which is not identified). The measurement values
for each feature are contained in the x_training.txt and x_test.txt files.]

(f) The x_train and the x_test files contain 'A 561-feature vector with time 
and frequency domain variables. 'There were 7,352 observations in x_train.txt
and 2,947 observations (28.6%) in the x_test.txt; for a total of 10,299 
observations. [The features.txt file contains the variable names for the x files.]


II. I used the bind_rows() function (from the dplyr package) to combine the 
training and the test datasets together: 

	- the subject training and test datasets were combined into a subject dataset.
	
	- x training and test datasets were combined into an x dataset.
	
	- y training and test datasets were combined into a y dataset.

I also added a source column to indicate whether an observation came 
from the training or the test dataset.

I verified that the subject, x, and y datasets contained 10,299 observations; 
consistent with the figures from the website and the original README file. 


III. The feature names (or variable names) were then added to the columns in 
the x dataset. [The features dataset contained a row correspponding to the name
of each feature. So I transposed the 561 rows in the feature dataset into a 
column vector. I then assigned the transposed feature names to the 561 variable
names of the columns in the x dataset.]


IV. I created a numerical index that contained the locations of feature names 
with either mean() or std(). I then used this index to extract only the 
measurements on the mean and standard deviation for each measurement. This 
reduced the x dataset from 561 columns to 66 columns.


V. The activity_names were then added to the y dataset to create an activities 
dataset; which lists the activity_id and the activity label that was observed 
for each of the 10,299 observations.


VI. I then used bind_cols() to combine the x dataset (which contains the observed 
results) with the subjects dataset (which contains the ids of the subjects that 
were tracked) and the activities2 dataset (which contains the activities that the 
subject performed).

The resulting dataset is tidy:
1. each variable is in its own column
2. each observation is in its own row
3. each table is for a specific topic

The variable names in the table are also human readible and descriptiive.


VII. I then created a second, independent tidy data set with the average of each 
variable for each activity and each subject. I used functionality from the dplyr 
package to summarize the data by activity and subject. [Note that the unique() 
function was used to determine that there are thirty-five (35) unique 
combinations of activity and subject_id. My tidy dataset was 35 x 68; which was 
expected.] 

I then wrote the results out to file.


Miscellaneous:
--------------

Per http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions
- The units used for the accelerations (total and body) are 'g's (gravity of earth -> 9.80665 m/seg2).
- The gyroscope units are rad/seg. 


License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.




















