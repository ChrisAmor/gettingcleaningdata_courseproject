Clone the repository and set as working directory.
Run the script run_analysis.r.
This script performs a union of the train and test data sets appending activity and subject IDs and adding descriptive variable 
names from the features.txt file.

The script outputs 2 files to the output directory: 
- getting_and_cleaning_data-course_project-tidydataset1.txt includes all observations from the train and test dataset for the mean and 
standard deviation features from the dataset with appropriate variable labelling. 
- getting_and_cleaning_data-course_project-tidydataset2.txt summarises the mean value of the features from datset 1 for each unique 
combination of subject and activity
