#Introduction to R part 2 day 2

# Clear Memory
rm(list=ls())

# Cleaning Data

# assign a url to variable "url"
url <- "http://archive.ics.uci.edu/ml/machine-learning-databases/mammographic-masses/mammographic_masses.data"
# Download a rectangular dataset without a header to create a dataframe
df <- read.csv(url, header=FALSE)

# view the first few rows of the data; note the default column names of v1, v2, ...
head(df)

# Assign a vector of real names to the data frame;  The following names were from:
# http://archive.ics.uci.edu/ml/machine-learning-databases/mammographic-masses/mammographic_masses.names
# See Attribute Information
names(df) <- c("BI-RADS", "Age", "Shape", "Margin", "Density", "Severity")

# save df for later
df_saved <- df

# present an overview of these data

# view the first few rows of the data
head(df)
# How many rows and columns are in the dataframe?
nrow(df)
# In the following summary information you can determine if a vector is a factor
summary(df)
# Determine the nature of each vector
sapply(df, is)

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

# Let's try this function on the 1st column
df$"BI-RADS" <- fact2Num(df$"BI-RADS")
# In the following summary information you can determine if a vector is a factor
summary(df)
# Determine the nature of each vector
sapply(df, is)

# How many rows are in the dataframe?
nrow(df)
# Let's try the function on all columns in the data frame
df <- fact2Num(df)
# How many rows are in the dataframe after this function?
nrow(df)
# Determine the nature of df
is(df)
# In the following summary information you can determine
# if any of the dataframe vectors is a factor
summary(df)
# Determine the nature of each vector more explicitly
sapply(df, is)

# How many rows are in the dataframe?
nrow(df)
df <- df[complete.cases(df),]
# How many rows are in the dataframe after this operation?
nrow(df)

# Function determines if there are data beyond 3 standard deviations
outlier<-function(x)
{
  a <- mean(x);
  s <- sd(x);
  e <- max(max(x), abs(min(x)));
  e > (a + 3*s)
} # outlier

outlier(df$"BI-RADS")
max(df$"BI-RADS")

x<-df$"BI-RADS"

# The following function substitutes outliers with NAs
# NAs will be introduced where there was an outlier
nullOutliers <- function(x)
{
  zs <- abs(3*qnorm(1/length(x)))
  average <- mean(x, na.rm=T)
  std.dev <- sd(x, na.rm=T)
  maxAllowed <- average + zs*std.dev
  minAllowed <- average - zs*std.dev
  maxDelta <- max(x, na.rm=T) - maxAllowed
  minDelta <- minAllowed - min(x, na.rm=T)
  indexOutside = -1
  if (maxDelta > minDelta)
  {
    if (maxDelta > 0)
    {
      indexOutside <- which.max(x)
    }
  }
  else
  {
    if (minDelta > 0)
    {
      indexOutside <- which.min(x)
    } 
  }
  if (indexOutside > 0)
  {
    x[indexOutside] <- NA
    nullOutliers(x)
  }
  else
  {
    x
  }
} # nullOutliers
 
x<-df$"BI-RADS"
length(x)
x <- x[complete.cases(x)]
length(x)
max(x)
index <- which.max(x)
x[index] <- NA
length(x)
sum(complete.cases(x))
x <- x[complete.cases(x)]
length(x)
max(x)
which.max(x)

df <- df_saved
nrow(df)
df <- fact2Num(df)
nrow(df)
df <- df[complete.cases(df),]
nrow(df)
df$"BI-RADS" <- nullOutliers(df$"BI-RADS")
nrow(df)
df <- df[complete.cases(df),]
nrow(df)








