# install.packages("readr", "ggplot2", "ggrepel")
library(readr)
library(ggplot2)
library(ggrepel)

# read the data 
elements_by_episode <- read_csv( 
  "https://raw.githubusercontent.com/fivethirtyeight/data/master/bob-ross/elements-by-episode.csv"
)


# remove the title and episode number
matrix<-elements_by_episode[,3:ncol(elements_by_episode)]


# subset to retrieve only columns with at least five observations
matrix <- matrix[,colSums(matrix)>=5]

# center and scale each column by its standard deviation
scaled_matrix <- scale(matrix)

set.seed(100)
# perform K-means clustering
output <- kmeans(scaled_matrix, centers=10)



# each episode is assigned to 1 cluster. Do you see any themes here? 
elements_by_episode$TITLE[output$cluster == 1]




points<-prcomp(dist(scaled_matrix))$x
df<-data.frame(
  "x" = points[,1],
  "y" = points[,2],
  "label" = elements_by_episode$TITLE,
  "cluster" = output$cluster
  
)





episodes<-ggplot(df, aes(x=x, y=y, label=label, color=factor(cluster))) + 
  geom_point() + 
  ggrepel::geom_label_repel() +
  scale_color_viridis_d(option='turbo') +
  theme_bw() 


ggsave("cluster_plot.png", plot=episodes, width = 20, height=15)
