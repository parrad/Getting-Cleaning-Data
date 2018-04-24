Getting-Cleaning-Data
=====================

Coursera's Getting &amp; Cleaning Data

## Steps followed in generating the tidy dataset

* Download the zip file in the current working directory
* Unzip the file in the "UCI HAR Dataset" subfolder in the current working directory
* Read the subject_train, X_train and y_train files in train  subfolder within "UCI HAR Dataset" folder into separate data frames
* Read the subject_test, X_test and y_test files in test subfolder within "UCI HAR Dataset" folder into separate data frames
* Union these 6 data frames into 3 data frames named subjects.df, features.df and activtites.df
* Read the features.txt and activity_labels.txt into separate data frames named feature.labels and activity.labels
*  Remove the special characters (open bracket, close bracket and hyphen) in the feature.labels data frame which represents mean or standard deviation (contains 'mean' or 'std' in it)
* Name the features.df with the clensed values of feature.labels data frame
* Name the subjects.df and activities.df properly
* Merge activities.df and activity.labels by the key column
* Combine features.df, subjects.df and activities.df data frames into a new data frame
* Select only the attributes which are measure of mean or standard deviation (contains 'mean' or 'std' in it)
* Convert the subject id and activity description as factors
* Create the tidy data frame by calculating the mean of all the columns grouped by subject id and activity description
* Write the data of this data frame into tidy.txt file
