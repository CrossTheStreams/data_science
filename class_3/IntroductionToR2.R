# Introduction to R part 2

# Example data frame with a factor

# Remove objects from memory
rm(list=ls())
# Create a numerical vector with an "NA"
v1 <- c(1,2,NA,4,5)
# Prove that this is a numeric vector in spite of the NA
is(v1)
# Create a charachter vector where 2 was used instead of "two"
v2 <- c('one', 2, 'three', 'four', 'five')
# prove that this vector is character
is(v2)
# If this is a charchter vector, then what is the value of the number 2?
v2[2]
# Create a numeric vector with a non-numeric value
v3 <- c(11,12,13,"?",15)
# What is the type of this vector?
is(v3)

# Turn the numerical vector into a data frame
df <- as.data.frame(v1)
# What is a data frame?  Answer:  a list of equal length vectors
is(df)
# Bind (Add) the other two columns
df <- cbind(df, v2)
df <- cbind(df, v3)
# what does df look like now?
df
# Can we make histograms of these columns?
hist(df[,1])
hist(df[,2]) # Not numeric
hist(df[,3]) # not numeric
# Can we get information?
sapply(df, mean)
sapply(df, mean, na.rm=T)

# Identify location of abberant values
select <- df$v3 != "?"
select
df <- df[select,]
df

# v2, The second column of df, the 2nd column of df_select and now the 2nd column of df
is(df$v3)
# try out a simple calculation:
df$v3 * 111
# The following does not work!  It turns the factor levels into numbers
as.numeric(df$v3)
# The following turns the factor into a charachter vector
v3Char <- levels(df$v3)[df$v3]
is(v3Char)
v3Char
# A charachter vector can be turned into a numeric vector
v3Numbers <- as.numeric(v3Char)
v3Numbers
df[ , 3] <- v3Numbers
df
df$v3 * 111

# The first column has an NA in it.
df
# Complete cases will get rid of this NA
df <- df[complete.cases(df),]

####################################################
# Homework 2

# Remove objects from memory
rm(list=ls())

df <- read.csv("http://archive.ics.uci.edu/ml/machine-learning-databases/00225/Indian%20Liver%20Patient%20Dataset%20(ILPD).csv")
nrow(df)
headers <- c("age", "gender", "tb", "db", "alkphos", "sgpt",
           "sgot", "tp", "alb", "agratio", "selector")
# Assign the headers to the data frame
names(df) <- headers
names(df)
headers
# Did the headers add a row?
nrow(df)
# Nope
# Note: the problems in the next three results are due to NA's in df$agratio
sapply(df, mean)
sapply(df, median)
sapply(df, sd)

# remove NA using na.rm (not really removed)
sapply(df, mean, na.rm=T)
sapply(df, median, na.rm=T)
sapply(df, sd, na.rm=T)

# If you want to avoid the non-numerical column "gender"
sapply(df[,c(1, 3:11)], mean, na.rm=T)
sapply(df[,c(1, 3:11)], median, na.rm=T)
sapply(df[,c(1, 3:11)], sd, na.rm=T)

# remove NAs permanently
# Remember how many rows there are in the data frame
nrow(df)
# find complete cases and assign them to a df
df <- df[complete.cases(df),]
# How many rows are there now?
nrow(df)
# We can now determine the data metrics without removing NAs
sapply(df[,c(1, 3:11)], mean)
sapply(df[,c(1, 3:11)], median)
sapply(df[,c(1, 3:11)], sd)

# Make the data useable for machine learning

# Turn categorical data into numbers (boolean)
df$gender <- as.numeric(df$gender == "Female")
head(df)

# Write data out to disk
# Silly requirement by R.  Otherwise col.names are written out to file
names(df) <- c();

# Write out numeric file;
# col.names = FALSE doesn't work in write.csv (bug?)
write.csv(df, "ilpd.csv", row.names=F)
####################################################
