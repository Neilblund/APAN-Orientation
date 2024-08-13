# install these packages, if you don't have them already: 
# install.packages("readr", "ggplot2", "ggrepel")
library(readr)
library(ggplot2)
library(ggrepel)


# based on code and data from: 
# https://github.com/fivethirtyeight/data/blob/master/bob-ross/


# Read and format the data ----

# read the data 
elements_by_episode <- read_csv( 
  "https://raw.githubusercontent.com/fivethirtyeight/data/master/bob-ross/elements-by-episode.csv"
)

# remove the title and episode number (we want a matrix with numeric data!)
matrix<-elements_by_episode[,3:ncol(elements_by_episode)]

# subset to retrieve only columns with at least five observations
matrix <- matrix[,colSums(matrix)>=5]

# center and scale each column by its standard deviation
scaled_matrix <- scale(matrix)

# Clustering ----

# K-means has an element of randomness, so we set the random number seed 
# to a specified number so we can always get the same result
set.seed(100)

# perform K-means clustering with 10 clusters
output <- kmeans(scaled_matrix, centers=10)

# each episode is assigned to 1 cluster. Do you see any themes here? 
elements_by_episode$TITLE[output$cluster == 1]



# reducing the matrix down to just two dimensions for visualization
points<-cmdscale(dist(scaled_matrix), k=2)

# and create a data frame with only the relevant data for a plot
df<-data.frame(
  "x" = points[,1],
  "y" = points[,2],
  "label" = elements_by_episode$TITLE,
  "cluster" = factor(output$cluster)
  
)

#Generating the plots ----


# now make a ggplot object color coded by cluster
episodes<-ggplot(df, aes(x=x, y=y, label=label, color=cluster)) + 
  geom_point() + 
  # ggrepel lets us label *some* of the points without making it unreadable
  ggrepel::geom_label_repel() +
  # use a different color palette
  scale_color_viridis_d(option='turbo') +
  # and apply a black and white theme
  theme_bw() 

# Just write "episodes" to display the plot in the viewer: 
episodes #(but you get a lot of overlap)

# we can also just export the result as a very large image: 
ggsave("cluster_plot.png", plot=episodes, width = 20, height=15)
