# Course project

As the article said, the increasing avaibility of information, makes data processing and analysis a challenge in our days. This work is done to apply the principles of tidy data to create a vrief summary of the physical activity of 30 subjects, taking in count 6 differents activities measured by Samsung divices. To do so the are 5 steps described below:

## 1. Get activities
* After reading the file and put it in a data frame the names were changed.
* The activity label was turned into a factor.

## 2. Get feature names
* After reading the file and put it in a data frame the names were changed.
* The positions of the desired features were extracted and the names too.
* The names were corrected, all symbols were elimited.

## 3. Test sets
* Subject dataset, features  dataset selected by the vector of paositions given by the last step, and activitity dataset, were joind to get the Test Set.
* The names were changed. 

## 4. Train sets
* Tha same treatmeant given to the test set files.

## 5. Merge train and test sets
* Check for the subjects in both sets.
* As there are subjects in test sets that are not in train set I use rbind.
* Turn the subject id in a factor.

## 6. Summary
* The mean was calculated for all numeric values group by id and activity.


The steps to get the tidy dataset is in the file  `run_analysis.R`. The tidy dataset is saved in the file `tidy_dataset.txt`. The code book asociated` to the project is in the file `CODE_BOOK.md. 

