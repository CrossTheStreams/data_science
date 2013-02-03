# Andrew Hautau
# Class 2 Homework
# Intro To Data Science

# The data set I chose for the assignment is census data for the video game World of World, as posted on warcraftrealms.com.

# Fetch g-zipped csv from Warcraft Realms site.
con <- gzcon(url(paste("http://www.warcraftrealms.com/exports/download.php?fname=currentdata.csv.gz", sep="")))
txt <- readLines(con)
df <- read.csv(textConnection(txt))
df

headers <- df[1,]
headers
# Since the csv file already had headers, this picks up the first row, which isn't what we want.

# That's better.
headers <- names(df)
headers

# First six rows of World of Warcraft census data from  
head(df)

# Timestamp for the data.
unix.time.stamp <- scan(url("http://www.warcraftrealms.com/exports/status.txt"))
time.stamp <- as.POSIXct(unix.time.stamp,"","1971-01-01")
time.stamp

# Select observations of data where:
  # df$Faction == "Aliiance" & 
  # df$Race == "Pandaren" & 
  # df$Class == Mage
alliance.pandaren.mages <- df[df$Faction=="Alliance" & df$Race=="Pandaren" & df$Class=="Mage",]  
alliance.pandaren.mages

# Counts for all alliance pandaren mages across all levels.
alliance.pandaren.mage.counts <- alliance.pandaren.mages[,5] 
alliance.pandaren.mage.counts

# Use read function to assign csv file data to df variable as a data frame.
# Sum of all players in the census that meet this criteria.
sum(alliance.pandaren.mage.counts)

# A mean of 24.75 players are Alliance Pandaren Mages for any given level. 
mean(alliance.pandaren.mage.counts)
# Meanwhile, the median is 12.
median(alliance.pandaren.mage.counts)
# The standard deviation is ~ 71.23
sd(alliance.pandaren.mage.counts)

# Many player levels for Alliance Pandaren Mages have between 0-100 players, but level 80 has far more.
hist(alliance.pandaren.mage.counts)

# More informative than the histogram above.
plot(alliance.pandaren.mage.counts, col="#0000bf") 

# A lot to look at!
# The columns for Faction, Race, Class all contain categorical data.
# The Level column is continuous data.
# The Count column is ordinal data.
plot(df, col="#36afbe")

