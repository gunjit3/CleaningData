Tidied up Version of Human Activity Recognition Using Smartphones Dataset 
=========================================================================
Original Dataset can be found at : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


The repository includes the following files:
-------------------------------------------

- 'README.MD'

- Codebook.MD: Shows information on variable, data and transformations.

- "run_analysis.R": The script which runs on raw data and produces tidy dataset.

Running the code
----------------
This repository contain run_analysis.R file which cleans up the raw data for Human Activity Recognition Using Smartphones Dataset.
There is only one file in the repository which needs to be run. To run the file please follow the below process.

1. Obtain the original data using https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip URL.
2. Unzip the data in any folder. You should get a folder named "UCI HAR Dataset" ( if you did not rename it) which will contain test and train folders and along with README and other files.
3. Download the run_analysis.R file and copy it into the same folder which contains test and train folders and README.txt file.
4. Open R console and set your working directory to the location of the file.
5. From command line just call source("run_analysis.R")
6. The file will run and will create a new file names tidyData.txt in your current folder. (Make sure you have read permissions on the folder)

Notes
---------
run_analysis.R will read in the training and test data sets for all subjects, activities and features. The script will then filter all the mean and standard deviation
features and average them up for each subject for each activity.

For detailed information on the column please refer to the codebook : https://github.com/gunjit3/CleaningData/blob/master/Codebook.md
