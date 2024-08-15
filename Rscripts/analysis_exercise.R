# Step 0. import the data (you should already have the code for this) ----

# Read the data  
library(readr)
elements_by_episode <- read_csv( 
  "https://raw.githubusercontent.com/fivethirtyeight/data/master/bob-ross/elements-by-episode.csv"
)
# Step 1. remove the columns with episode numbers or titles ----
matrix <- elements_by_episode[,3:ncol(elements_by_episode)]

# Step 2. get the sum of the numeric columns ----
# Using the colSums() function
element_sums <- colSums(matrix)

# Step 3. sort the sums from highest to lowest ---- 
element_sums_sorted <- sort(element_sums, decreasing=T)

# Step 4. view the top 10 elements from this sorted result ----
element_sums_sorted[1:10]

# Step 5. create a bar plot from the object created in step 4 ----
barplot(element_sums_sorted[1:10], 
        # and also add a color: 
        col= '#e21833')


# Advanced users----

# calculate the top elements by season
# use substr() to get just a portion of the episode column

season<-substr(elements_by_episode$EPISODE, 1, 3)
season
## Then use rowsum() with group to calculate the total by group:
rowsum(matrix, group=season)



## find exact duplicates (episodes with the exact same elements)

## use the duplicated function, which returns TRUE for duplicated rows of a matrix: 
duplicated(matrix)


## find correlations between elements

# just use the cor function: 
cor(matrix)

# or make a fancy correlation plot: 
# install.packages("corrplot")
library(corrplot)
# you may want to remove rows with only a handful of observations: 
matrix_subset  <- matrix[,colSums(matrix)>5]

# make a matrix of correlations
correlations<-cor(matrix_subset)

# plot the correlations: 
corrplot(correlations,
         # makes it slightly easier to spot correlated groups: 
         order='FPC')



