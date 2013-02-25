#Introduction to R part 4

# Clear Memory
rm(list=ls())

# Cleaning Data

# assign a url to variable "url"
url <-"http://archive.ics.uci.edu/ml/machine-learning-databases/auto-mpg/auto-mpg.data-original"
# Backup in case I loose internet
localFN <- "D:/BusinessIntelligence/DataScientist/auto-mpg.data-original.csv"

# WARNING!! The following is not appropriate!
# Download a rectangular dataset without a header to create a dataframe
df <- read.csv(url, header=FALSE)
# Get some info on this data set
is(df) # OK
nrow(df) # OK
head(df) # Weird
ncol(df) # Oh no!   Bad!

# REDO!!!!
# Download a rectangular dataset without a header to create a dataframe
df <- read.table(url, header = FALSE, sep = "", dec = ".")
# Assign a vector of real names to the data frame;  The following names were from:
# http://archive.ics.uci.edu/ml/machine-learning-databases/auto-mpg/auto-mpg.names
names(df) <- c("mpg","cylinders","displacement","horsepower","weight","acceleration","model year","origin","car name")

# Get some info on this data set
is(df)
head(df)
sapply(df, is)
nrow(df)
mean(df[,1])

# save df just in case we destroy df
df.saved <- df

# WARNING!! The following is not appropriate!
# The following function can convert a factor to a numeric vector.
# NAs will be introduced where there was no number.
fact2Num <- function(x)
{
  # If the input x is a dataframe then apply the function to
  # every vector of the data frame
  if (is.data.frame(x))
  {
    x <- as.data.frame(sapply(x, fact2Num))
  }
  # Only apply this function to a factor
  else if (is.factor(x))
  {
    # this line converts levels in x to numbers
    as.numeric(levels(x)[x])
  }
  # this line converts characters in x to numbers 
  else if (is.character(x))
  {
    as.numeric(x)
  }
  else
  {
    x
  }
}
# The following will destroy the car name column:  Convert data from factor to number
df <- fact2Num(df)
# Peek at the first 6 rows and notice that all car names are NA
head(df)
# The following will destroy the whole data frame:  Remove cases that contain NAs due to coercion
df <- df[complete.cases(df),]
# How many rows are in the dataframe?
nrow(df)

#  REDO without trying to convert everything to a numeric vector
df <- df.saved
# What is type of the "car names" column (in case you forgot)
is(df$"car name")
# Convert the factor to a character column
df$"car name" <- as.character(df$"car name")
# What is type of the "car names" column
is(df$"car name")
# How many rows are in the dataframe? (in case you forgot)
nrow(df)
# Remove cases that contain NAs; These NA are not from cercion!  They were part of the original dataset
df <- df[complete.cases(df),]
# How many rows are in the dataframe?
nrow(df)
# Peek at the first 6 rows
head(df)

is(df$"origin")
summary(df$"origin")
# df$"origin" should not be numeric it should be categorical
# 1 is for USA
# 2 is for Europe
# 3 is for Japan
df$"origin"[df$"origin" == 1] <- "USA"
is(df$"origin")
summary(df)
df$"origin"[df$"origin" == 2] <- "Europe"
df$"origin"[df$"origin" == 3] <- "Japan"
head(df)

fileName <- "mpg-cleaned.csv"
write.csv(df, fileName, row.names=F)

Origin.USA <- as.numeric(df$"origin" == "USA")
Origin.Europe <- as.numeric(df$"origin" == "Europe")
Origin.Japan <- as.numeric(df$"origin" == "Japan")
df <- cbind(df, Origin.USA)
df <- cbind(df, Origin.Europe)
df <- cbind(df, Origin.Japan)
summary(df)
head(df)
PA.Columns <- c(1, 3, 2, 4:7, 10:12)
head(df[, PA.Columns])
pa <- df[, PA.Columns]
head(pa)
fileName <- "D:/Octave/3.2.4_gcc-4.4.0/share/octave/3.2.4/m/KMeans/mpg-octave.csv"
write.csv(pa, fileName, row.names=F)












