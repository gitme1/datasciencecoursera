Cleaning script analysis on Samsung data
========================================================

This is an R Markdown document. 

This ReadME is to list out the steps used in getting the raw Samsung data and cleaning it.

Following are the sequence of steps describing how run_analysis.R works.

1) All paths to the downloaded Samsung raw data files are stored in variables

2) Each of the following raw Samsung text data files is read into different data frames.
     - X_test
     - X_train
     - y_test
     - y_train
     - subject_test
     - subject_train
     - features 
     - activity_lables

3) Dataframe A = Column bind on dataframes y_test and subject_test. Columns are renamed to Activity and Subject

4) Dataframe B = Column bind on dataframes y_train and subject_train. Column are renamed Activity and Subject

5) Dataframe C = Merge of dataframes A and B (dim-10299*2). Also in this step Descriptive labels for Activity are associated. 

6) Dataframe D = Merge of dataframes X_train and X_test (dim-10299*561)

7) Columns in dataframe D are named from data in features.txt. Besides the column names are cleaned up a bit by removing "()", "-" etc characters.

8) Dataframe E = From dataframe D, all columns which do not have "mean()" or "std()" are eliminated (dim-10299*66)

9) Dataframe F = Column bind on dataframes C and E (dim-10299*68)

10)Using split function (by Activity and Subject) followed by a lapply function for calculation of mean.
    Mean of observations per activity per subject are calculated. (dim-180*68). 

11)Final data generated from step(10) is exported to myTidyData.txt file  









