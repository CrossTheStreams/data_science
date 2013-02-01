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

# Let's fetch the max and mins for each column, and then histogram those vectors!
maxs <- c()
mins <- c()

for(i in seq_along(df)) {
  maxs <- cbind(maxs, max(df[,i], na.rm=T))
  mins <- cbind(mins, min(df[,i], na.rm=T))
}

# 96 years sure looks like an outlier...
maxes
hist(df$Age)

# But is it an outlier, as commonly defined as three standard deviations away from the mean?
age.mean <- mean(df$Age, na.rm=T)
age.sd <- sd(df$Age,na.rm=T)

# 40.52461
variance <- (maxs[2] - age.mean) 
# Not Quite, under that specific definition.
variance >= (age.sd * 3)
# But close enough I think to qualify as an outlier.
age.sd * 3


# Find the index of 96 in column 1.
which(df$Age == 96)
# Let's get rid of the observation.
df[726,] = NULL
df[726,2]

# Changed Severity to Diseased.
colnames(df)[6] <- "Diseased"
colnames(df)[6]

# Write to csv file.
write.csv(df,"mammographic_mass.csv")


