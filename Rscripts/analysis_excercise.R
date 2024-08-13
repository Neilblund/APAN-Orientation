# Step 0. import the data (you should already have the code for this) ----

# Read the data  
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
