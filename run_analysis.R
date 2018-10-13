library(dplyr)

# 1. Get activities

activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# change names:

colnames(activities) <- c("code","activity")

# Turn the activity label in a factor.

activities <- activities %>% mutate(activity = factor(activity,activity))

#  Everything seems ok.

# 2. Get feature names:

features <- read.table("UCI HAR Dataset/features.txt")

# change names:

colnames(features) <- c("code","feature")

# Extract the positions where the desired features are:

positions <- grep("-mean\\(\\)|-std\\(\\)",features$feature)

# Get the names:

names <- features$feature[positions]

# tide them:

names <- names %>% 
  gsub("-m","M",.) %>%    # Turn to capital de m in mean
  gsub("-s","S",.) %>%    # Turn to capital de s in std
  gsub("-X$","X",.) %>%   # Eliminates the - before X, Y, Z
  gsub("-Y$","Y",.) %>% 
  gsub("-Z$","Z",.) %>% 
  gsub("[()]","",.)       # Eliminates parenthesis 


# 3. Test sets:

# join the subject, the values of features selected by the vector positions,
# and the activitity code vector:

testDataset <- 
cbind(read.table("UCI HAR Dataset/test/subject_test.txt"),
      read.table("UCI HAR Dataset/test/X_test.txt")[,positions],
      read.table("UCI HAR Dataset/test/y_test.txt")
      )

# change the name
colnames(testDataset) <- c("subject",names,"code")

# merge the code equivalence to get the activity label:

testDataset <- testDataset %>% 
  inner_join(activities,by="code") %>% 
  select(-code)


# 4. Train sets:

# Same as I did with the test sets:
trainDataset <- 
  cbind(read.table("UCI HAR Dataset/train/subject_train.txt"),
        read.table("UCI HAR Dataset/train/X_train.txt")[,positions],
        read.table("UCI HAR Dataset/train/y_train.txt")
  )

# change the name
colnames(trainDataset) <- c("subject",names,"code")

# merge the code equivalence to get the activity label:

trainDataset <- trainDataset %>% 
  inner_join(activities,by="code") %>% 
  select(-code)


# 5. Merge train and test sets:

# Check for the subjects in both sets:
table(trainDataset$subject)

table(testDataset$subject)

# As there are subjects in test sets that are not in train set I use rbind:

DataSet <- rbind(trainDataset,testDataset)

# Turn the subject id in a factor

DataSet <- DataSet %>% 
  mutate(subject = factor(subject,sort(unique(DataSet$subject))))

# The data set is tidy.

# 6. Summary:

DataMean <- DataSet %>% group_by(subject,activity) %>% 
  summarise_if(is.numeric,mean,na.rm=T)


write.table(DataSet,"tidy_dataset.txt")





