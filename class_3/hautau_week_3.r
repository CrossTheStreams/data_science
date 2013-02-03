# Andrew Hautau 
# Intro To Data Science
# Class 3 Assignment

# Fetch csv file.
df <- read.csv("http://archive.ics.uci.edu/ml/machine-learning-databases/mammographic-masses/mammographic_masses.data")

# Give Column Names
names(df) <- c("BI-RADS assessment","Age","Shape","Margin","Density","Severity")
names(df)

# Coerce all values of data frame into numeric values.
df <- data.frame(lapply(df, function(x) as.numeric(as.character(x))))

# How many NAs are present? 
stuff <- is.na(df)
# 162, apparently.
sum(stuff)
# How about by column?
colSums(stuff)

# Let's see a summary of the data.
summary(df)

# Fetch the index of an outlier.
outlier.index <-function(x)
{
  a <- mean(x, na.rm=T);
  a <- mean(x, na.rm=T);
  s <- sd(x, na.rm=T);
  e <- max(max(x, na.rm=T), abs(min(x, na.rm=T)), na.rm=T);
  if (e > (a + 3*s)) {
    x.abs <- abs(x)
    return(which.max(x.abs))
  }
  else {
    return(NA)
  }
}

outlier.indexes <- c()

for(i in 1:ncol(df)) {
 outlier.indexes <- cbind(outlier.indexes,outlier.index(df[,i]))
}

# 55 is clearly an outlier in the BI-RADS assessment column.
df[outlier.indexes,1]

hist(df[,1])

# Delete these rows.
for(i in outlier.indexes) {
  if (!is.na(i)) {
    df <- df[-(i),]
  }   
}  


# Changed Severity to Diseased.
colnames(df)[6] <- "Diseased"
colnames(df)[6]

# Write to csv file.
write.csv(df,"mammographic_mass.csv")


