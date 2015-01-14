###
# 1. R BASICS 
###
#
# Any line starting with # is a "comment" line and is ignored by
# R. Any other line is treated as a command. Run commands by 
# copying and pasting them into the R Console.
#
# If (when) you get confused, a good place to start is with R's
# built-in help functionality. R offers detailed help files for
# each function and each package. To access help type ?[function
# or package name] in the console. For example, for help on the
# "sum" function or "tm" package type:
?sum
??tm
#
# Insatlling packages
install.packages("<Desired Package>") 
# E.g. install.packages("igraph")
#Note: Package names are case sensitive!!
#
# Loading installed packages to the library
library(<Required Package>) 
# E.g. library(igraph)
#
# Sometimes, different packages overlap in functionality and 
# cause unexpected behavior when both are loaded simultaneously.
# If you ever want to remove an existing library, use the 
# "detach" command:
detach(package:<Required Package>)
# E.g. detach(package:igraph)
# 
# IMPORTANT NOTE: Unlike in most languages, R objects are numbered
# from 1 instead of 0, so if you want the first element in a
# vector, you would reference it by vector_name[1]. HOWEVER,
# igraph objects are numbered starting from 0. This can lead to 
# lots of confusion, since it's not always obvious at first which 
# objects are native to R and which belong to igraph. 
#
###
# 2. LOADING DATA
###
# 
# The '<-' or '=' operator sets a variable equal to something. In this case,
# we will set a number of basic R data structures, called "data 
# frames," to hold the contents of the files we will open. 
#
# read.table() is the most common R command for loading data from
# files in which values are in tabular format. The function loads
# the table into a data frame object, which is the basic data type
# for most operations in R. By default, R assumes that the table
# has no header and is delimited by any white space; these
# settings are fine for our purposes here.
#
# One handy aspect of R is that you can read in data from a URL 
# directly by referencing the URL in the read.table() function,
# as follows: 
advice_data_frame <- read.table('http://sna.stanford.edu/sna_R_labs/data/Krack-High-Tec-edgelist-Advice.txt')
friendship_data_frame <- read.table('http://sna.stanford.edu/sna_R_labs/data/Krack-High-Tec-edgelist-Friendship.txt')
reports_to_data_frame <- read.table('http://sna.stanford.edu/sna_R_labs/data/Krack-High-Tec-edgelist-ReportsTo.txt')
#
# If the files you want to work with are on your local machine, 
# the easiest way to access them is to first set your working 
# directory via the setwd() command, and then reference the 
# files by name:
setwd('<path/to/your_directory>') for Mac or Linux Users
setwd('<path//to//your_directory>')  or setwd('<path\to\your_directory>') for Windows Users
# E.g setwd('~/Desktop/SNA/Lab1/Assets/Datasets) [Mac or Linux]
# E.g setwd('C://Users//Desktop//SNA//Lab1//Assets//Datasets) or
# E.g setwd('C:\Users\Desktop\SNA\Lab1\Assets\Datasets) [Windows]
#
# To find the R's current working directory 
getwd()
#
# Once the directory path is set, you can start loading the stored data fom local for analysis
your_data_frame <- read.table('your_file_name')
# E.g data.advice = read.table('Krack-High-Tec-edgelist-Advice.txt')
#
# Note that when you set a variable equal to something, if all 
# goes well R will not provide any feedback. To see the data we
# just loaded, it's necessary to call the variables directly.
advice_data_frame
# 
# Since this is a bit long, we can see just the top six rows via
# head()...
head(friendship_data_frame)
#
# ... or the bottom six rows via tail().
tail(reports_to_data_frame)
#
# To get the variable/column names of the dataset
names(<dataset>)
#
# To view your data in a spreadsheet-like window, use the command 'fix()'. 
fix(reports_to_data_frame)
#
# The attribute data for this lab is in a comma-separated-value
# (CSV) file. read.csv() loads a CSV file into a data frame
# object. In this case, we do have a header row, so we set
# header=T, which tells R that the first row of data contains
# column names. The delimiters might change from file to file based on 
# the delimiter set when it was created or modified, so we set 
#sep="< , or ; or |or : >
attributes <- read.csv('http://sna.stanford.edu/sna_R_labs/data/Krack-High-Tec-Attributes.csv', header=T, sep="," )
#
attributes
#
# To drop datasets from memory
rm(<dataset>)
#
# To list all the datasets loaded into the memory
ls()
#
###
# 2.1. Basics ++
###
#
# Other commands may be used to load data from files in different 
# formats. read.delim() is a general function for loading any
# delimited text file. The default is tab-delimited, but this can 
# be overridden by setting the "sep" parameter. For example:
#
#     f <- read.delim("tab_delimited_file.txt")
#     f <- read.delim("colon_delimited_file.txt", sep=':')
#
# The 'foreign' package will allow you to read a few other 
# custom data types, such as SPSS files via read.spss() and 
# STATA files via read.dta().
#
# When data files are part of an R package you can read them as 
# follows:
#
# data(kracknets, package = "NetData")
# 
# In the future, we will load data this way. However, it is useful 
# to get a sense of how things often must be done in R.
#
###
# 3. DATA Manipulation Basics
###
#
# For convenience, we can assign column names to our newly 
# imported data frames. c() is a common generic R function that 
# combines its arguments into a single vector.
colnames(advice_data_frame) <- c('ego', 'alter', 'advice_tie')
head(advice_data_frame)
#
colnames(friendship_data_frame) <- c('ego', 'alter', 'friendship_tie')
head(friendship_data_frame)
# 
colnames(reports_to_data_frame) <- c('ego', 'alter', 'reports_to_tie')
head(reports_to_data_frame)
#
# Take a look at each data frame using the 'fix()" function. Note that you'll 
# need to close each fix window before R will evaluate the next line of code.
fix(advice_data_frame)
fix(friendship_data_frame)
fix(reports_to_data_frame)
#
# Before we merge these data, we need to make sure 'ego' and 'alter' are the
# same across data sets. We can compare each row using the == syntax. 
# The command below should return TRUE for every row if all ego rows
# are the same for advice and friendship:
advice_data_frame$ego == friendship_data_frame$ego
# 
# That's a lot of output to sort through. Instead, we can just have R return 
# which row entries are not equal using the syntax below:
which(advice_data_frame$ego != friendship_data_frame$ego)
# 
# Repeat for other variables
which(advice_data_frame$alter != friendship_data_frame$alter)
which(reports_to_data_frame$alter != friendship_data_frame$alter)
which(reports_to_data_frame$ego != friendship_data_frame$ego)
# 
# Now that we've verified they are all the same, we can combine them into 
# a single data frame. 
krack_full_data_frame <- cbind(advice_data_frame, 
friendship_data_frame$friendship_tie, 
reports_to_data_frame$reports_to_tie)
head(krack_full_data_frame)
#
# Notice that the last two variable names are now 
# "reports_to_data_frame$reports_to_tie"
# and "friendship_data_frame$friendship_tie". 
# That's a little long. We can do this while combining(1)
# or rename(2) them after combining as follows:
#(1)	
krack_full_data_frame <- cbind(advice_data_frame, 
friendship_tie = friendship_data_frame$friendship_tie, 
reports_to_tie = reports_to_data_frame$reports_to_tie)
head(krack_full_data_frame)
#(2)
names(krack_full_data_frame)[4:5] <- c("friendship_tie", 
"reports_to_tie")  
head(krack_full_data_frame)
# 
# Alternative methods (Optional)
# Another way to build the data frame is to use R's 
# data.frame syntax from the start:
krack_full_data_frame <- data.frame(ego = advice_data_frame[,1],
alter = advice_data_frame[,2],
advice_tie = advice_data_frame[,3],
friendship_tie = friendship_data_frame[,3], 
reports_to_tie = reports_to_data_frame[,3])
#
head(krack_full_data_frame)
#
# Now let's move on to some data processing.
# 
# Reduce to non-zero edges so that the edge list only contains
# actual ties of some type.
krack_full_nonzero_edges <- subset(krack_full_data_frame, 
(advice_tie > 0 | friendship_tie > 0 | reports_to_tie > 0))
head(krack_full_nonzero_edges)
#
# Now to get the frequency of  'ego' in the dataset 
krack_ego_freq = data.frame(table(ego = krack_full_nonzero_edges$ego))
head(krack_ego_freq)
#
# As seen the frequency has been calcualted but it is not ordered,
# we will order it in descending using the following line:
krack_ego_freq_order = krack_ego_freq[with(krack_ego_freq, order( -Freq)),]
#
#
# Remove NA's from data
# to remove rows with NA's
na.omit(<data.frame>)
# OR
data[complete.cases(data),]
# For checking NA's in specific columns
data[complete.cases(data[,2:3]),]
#
# Advance Merges
library(gtools)

# one to one by "country & year"
mydata <- merge(mydata1, mydata2, by=c("country","year"))

# Merging only common rows
mydata <- merge(mydata1, mydata3, by=c("country","year"))

# Merging all
mydata <- merge(mydata1, mydata3, by=c("country","year"), all=TRUE)

# Many to one
mydata <- merge(mydata1, mydata4, by=c("country"))

# To merge common ids with different column/variable names
mydata <- merge(mydata1, mydata5, by.x=c("country","year"), by.y=c("nations","time"))

# Append with missing values
mydata <- smartbind(mydata7, mydata8)


###
# 3. Basic statistics using R
###
#
# We will start with calcualting the mean, median, 
# standard deviation, variance and quantiles  for 
# 'krack_ego_freq_order'
# To calculate mean
mean(krack_ego_freq_order$Freq)
# To calculate median
median(krack_ego_freq_order$Freq)
# To calculate standard deviation
sd(krack_ego_freq_order$Freq)
# To calculate variance
var(krack_ego_freq_order$Freq)
# To get quantiles 
## [Optional]: Levels 1st Quatntile = 0.25, 2nd Quantile = 0.50 
## and 3rd Quantile = 0.75
quantile(krack_ego_freq_order$Freq)
#
# Minimum and Maximum frequency in 'krack_ego_freq_order$Freq'
min(krack_ego_freq_order$Freq)
max(krack_ego_freq_order$Freq)
#
# Correlation analysis, for this we are going to use
# 'krack_full_nonzero_edges' . We can do this in different ways
# , the ways are as follows
# (1) Default way 
cor(krack_full_nonzero_edges$advice_tie, krack_full_nonzero_edges$friendship_tie)
# (2) Specify the correlation method ('pearson' or 'spearman' or 'kendall')
cor(krack_full_nonzero_edges$advice_tie, krack_full_nonzero_edges$friendship_tie,
method = "spearman")
# (3) Calculate correlation for all variables in the dataset
cor(krack_full_nonzero_edges, method = "spearman")
# [Optional]: More arguments can be passed, incase of missing values 
#  and covariance is being calculated, 'use' can be passed with the following
# "everything", "all.obs", "complete.obs", "na.or.complete", "pairwise.complete.obs"
###
# 4. Basic data visualization using R
###
# 
# A. Bar Chart
# Basic bar chart using 'ego' and 'frequency' from 'krack_ego_freq_order'
# First we need to prepare the data before push it into 
# the  visualization, we will drop the column 'ego' from the dataframe
krack_barchart = within(krack_ego_freq_order, rm(ego)) 
# Get the top 5 frequencies for visualizing
krack_barchart = head(krack_barchart, 5)
# Then we need to transpose the data 
krack_barchart = t(krack_barchart)
# Push the data for visualization 
barplot(krack_barchart, xlab="Ego", ylab="Frequency of Ego", col = "lightblue"
, main = "Top 5 EGO's (Bar Chart)")
#
# B. Stacked  Bar Chart
# Stacked Barchart using 'krack_full_nonzero_edges'
# Preparing dataset
krack_Stacked = krack_full_nonzero_edges
#
krack_Stacked = within(krack_Stacked, rm('alter' ))
# Summing up 'advice_tie', 'friendship tie', 'reports_to_tie' grouping by 'ego'
krack_Stacked = aggregate(krack_Stacked[2:4], 
by=list(ego = krack_Stacked$ego), FUN=sum)
# Preparing dataset
krack_Stacked = within(krack_Stacked, rm('ego'))
# Sampling 5 records for visualizing
krack_Stacked = head(krack_Stacked, 5)
#
krack_Stacked = t(krack_Stacked)
# Add column names
colnames(krack_Stacked) = c('1','2','3','4','5')
# Push the data for visualization
barplot(krack_Stacked, legend = rownames(krack_Stacked), 
col = c('lightblue', 'cornsilk', 'red'), ylim=c(0,30), xlab="Ego", 
ylab="Total number of Tie's", main = "Ties of EGO's (Stacked Bar Chart)")
#
# C. Histogram
# Basic histogram using 'ego' and 'advice_tie' in 'krack_full_nonzero_edges'
# Preparing dataset
krack_histogram = within(krack_full_nonzero_edges, 
rm('alter','friendship_tie','reports_to_tie' ))
# Summing up 'advice_tie' grouping by 'ego'
krack_histogram = aggregate(krack_histogram$advice_tie, 
by=list(ego=krack_histogram$ego), FUN=sum)
# Transposing the dataframe
krack_histogram = t(krack_histogram)
# Push the data for visualization
hist(krack_histogram, col ="lightblue", xlab="Frequency of Advice Tie", 
ylab="Number of Ego", main = "EGO's with Advice Ties (Histogram)")
#
# D. Pie Chart
# Pie chart using 'krack_full_data_frame'
# Preparing dataset
krack_piechart = krack_full_data_frame
#
krack_piechart = within(krack_piechart, rm('alter','ego'))
# Summing up 'krack_piechart'
krack_piechart = colSums(krack_piechart)
# Push the data for visualization
pie(krack_piechart, clockwise=TRUE, col = c("lightblue", " cornsilk", "red"), 
main = "Ratio of ties (Piechart)")
# E. Scatter Plot
# Scatter Plot using 'krack_full_data_frame'
krack_scatterplot = krack_full_data_frame
# Preparing dataset
krack_scatterplot = within(krack_scatterplot, rm('alter','reports_to_tie'))
#
krack_scatterplot = aggregate(krack_scatterplot[2:3], 
by=list(ego=krack_scatterplot$ego), FUN=sum)
# 
krack_scatterplot = within(krack_scatterplot, rm('ego'))
# Push the data for visualization
plot(advice_tie~ friendship_tie, data = krack_scatterplot,
 col="red", xlab="Friendship Tie",  
 ylab="Advice Tie", main = "Friendship tie against advice ties (Scatter Plot)")
#
# Saving charts to loacal machine
pdf("PieChart.pdf")
pie(krack_piechart, clockwise=TRUE, col = c("lightblue", " cornsilk", "red"), 
main = "Ratio of ties (Piechart)")
dev.off()
# Note: This will save the chart to the current working directory
# Check the working directory  or set the directory before exporting


