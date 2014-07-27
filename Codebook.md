##About this repository

The repository contains following files 
1. A codebook
2. Source code script named run_analysis.R for performing the cleaning task
3. A README which describes how to obtain original data and run the code it.

### About Original data set
The original dataset called Human Activity Recognition Using Smartphones Data Set, on which the cleaning was done, was obtained from UCI machine learning repository. More information on how to get the original dataset can be found in the [README](https://github.com/gunjit3/CleaningData/blob/master/README.md) file. 
Please go through the original dataset to ensure that you know the original list of variables that were used while collecting data.

### Variables in the Tidy Data file
After running the code , the tidy data that is obtained has following variables/columns.

1. **subject** : This column identifies the subject who performed the task. This takes on values 1 to 30 since there were 30 subjects.
2. **variable** : This columns identifies the features for which the measurements were taken in the original data. The feature list here is a filtered feature list with only mean and standard deviation featured from the original feature list.
3. **laying** : This column shows the average value of measurement for the given subject and variable while performing the laying activity.
4. **sitting** : This column shows the average value of measurement for the given subject and variable while performing the sitting activity.
5. **standing** : This column shows the average value of measurement for the given subject and variable while performing the standing activity.
6. **walking** : This column shows the average value of measurement for the given subject and variable while performing the walking activity.
7. **walking_downstairs** : This column shows the average value of measurement for the given subject and variable while performing the walking downstairs activity.
8. **walking_upstairs** : This column shows the average value of measurement for the given subject and variable while performing the walking upstairs activity.


###Transformation performed on the original dataset and code walkthrough

1. The script reads in the raw training data for all features from X_train.txt file in train folder. 
2. The names of the features are read from features.txt file and are assigned as column names
3. Column name is then filtered on whether it contains mean or std in the name using grep. This is done to take only the measurements for mean and standard deviation. 
4. Column name is again filtered to remove the measurements with BodyBody in the name, this is because in my opinion these are not proper mean and std measurements.
5. One we have a list of column names to include from step 4 and 5 the data is filtered to only contain those columns.
6. Activity data is read from y_train.txt file in the train folder.
7. Activity labels are read from activity_labels.txt file.
8. Activity labels data is joined with Acitivity data based on the activity number and it is merged column wise with filtered data obtained in step 5 to add a new Activity column
9. Subject data is read from subject_train.txt file in train folder and is merged column wise with data in step 8 to add a new subject column.
10. The data frame is reordered to have subject and Activity columns as the first two columns
11. Step 1-10 are repeated from test data ( the file names and folders are changed appropriately where necessary)
12. The training and test data is then merged row wise.
13. The subject column is converted into a factor variable so that we can use it to aggregate
14. The data is averaged for each feature for each subject and Activity
15. The columns names of data obtained in step 14 are cleaned up to remove parenthesis, comma, and hyphen from them. Also the first letter of mean and std is capitalized in the feature names.
16. The data from step 15 is reshaped using the melt and dcast function in reshape2 library. The data is reshaped in a way that each activity becomes a column and all the features are put into a single column named variable for each subject.
17. The data obtained from step 16 is narrower and looks clean. It is then written to a file tidyData.txt

##### Notes
I have added a sample tidyData file both in txt and csv format in this repository as well. The source code file is well commented for the convenience.
For any other information please feel free to leave me a message.
