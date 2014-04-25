This file contains the transformations used to create the tidy dataset and a 
description of the variables.
These were the steps undertaken to create the tidy dataset
1) The raw data (training and test sets) was loaded
2) A subset of the data with only those features using mean and std was taken
3) The activity names were changed from numerical to character
4) Columns containing the activity and subject id for each measurement
   were added to the subset
5) Training and test sets were merged
6) The averages were calculated for each feature and each activity and each
   subject
7) The resulting data frames were merged into one data set

The tidy data set contains 32 variables:
"Activity": The activity that was performed in that row of the dataset
"Feature": The feature that was recorded in that row of the dataset
"1" to "30": Subject id. Each element in these columns contains the average 
of the measurements for the activity and feature in the same row as the
element for that particular subject id
