#1. how would you find the titles of all episodes where Ross painted trees? ----

elements_by_episode$TITLE[elements_by_episode$TREES == 1]

#2. Get a new data frame with all the guest hosted shows removed: ----

elements_without_guests <- elements_by_episode[elements_by_episode$GUEST == 0 , ]


# 3. How would you create a new data frame without the title and episode number?  ----
episode_numeric<-elements_by_episode[,3:ncol(elements_by_episode)]


#4.  How would you get the index of all of the elements he painted in episode 1?----

# use which to get the index of all elements where a statement is TRUE: 
which(episode_numeric[1, ]>0)

# you could use this new vector to subset the columns: 
episode_numeric[1, which(episode_numeric[1, ]>0)]


# Advanced users: ----
  
## find all the episodes where Ross only painted a single tree. ----
# Use & to test multiple conditions and which to return just the index instead 
# of TRUE/FALSE
which(elements_by_episode$TREE == 1 & elements_by_episode$TREES == 0)

# OR! use the subset function to get a subsetted data frame using a 
# logical statement: (note that this function works without the $ operator): 
ross_only <- subset(elements_by_episode, TREE == 1 & TREES == 0)


## make a list with only the non-zero elements from each episode. ----

# use the "apply" function with MARGIN = 1 to apply a function 
# to all the rows of a matrix
apply(elements_by_episode[,3:ncol(elements_by_episode)], 1, FUN=function(x) which(x==1))




