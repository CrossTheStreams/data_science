Andrew Hautau 
Intro To Data Science
Class 3 Assignment

# Fetch csv file.
df <- read.csv("http://archive.ics.uci.edu/ml/machine-learning-databases/mammographic-masses/mammographic_masses.data")

# Coerce values of data frame into numeric values.
df <- data.frame(lapply(df, function(x) as.numeric(as.character(x))))
