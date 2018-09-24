# Clustering with NbClust
# FINDING THE RELEVANT NUMBER OF CLUSTERS using NbClust

# documentation
# https://cran.r-project.org/web/packages/NbClust/NbClust.pdf
# the issue
# https://www.jstatsoft.org/article/view/v061i06/v61i06.pdf

install.packages("NbClust")

library(NbClust)
library(data.table)

gc()
setwd("D:/BI")

data(iris)
class(iris)
iris <- as.data.table(iris)
str(iris)
iris_4 <- iris[, 1:4]


set.seed(42)

# methods

# ward.D2 - defines as the best partition - 3 clusters (hierarchical)
# ward.D - defines as the best partition - 3 clusters (hierarchical)
# complete - defines as the best partition - 3 clusters (hierarchical)
# average - defines as the best partition - 3 clusters (hierarchical)
# kmeans - defines as the best partition - 2 clusters  
# centroid - defines as the best partition - 2 clusters (hierarchical)
# median -  defines as the best partition - 2 clusters (hierarchical)
# single - defines as the best partition - 2 clusters (hierarchical)

# index='all' - this takes all indices

#min.nc=2 - minimum number of clusters
#max.nc=10 - maximum number of clusters

res_iris<-NbClust::NbClust(iris_4, distance = "euclidean", min.nc=2, max.nc=10,
             method = "ward.D", index = "all")

# Look, that have received and that is actually

iris_with_res <- cbind(iris_4, iris[, 5])
iris_with_res <- cbind(iris_with_res, res_iris$Best.partition)
iris_with_res[Species=='virginica']

# Index values for all cluster solutions

res_iris$All.index

# Critical values for some indices for all cluster solutions

res_iris$All.CriticalValues

# The best number of clusters offered by each index

res_iris$Best.nc

# Splitting into optimal clusters

res_iris$Best.partition

# Apply the chosen algorithm with the optimal number of clusters

irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)

library(haven)

data <- read_sav("D:/second_clustering.sav")
data <- as.data.table(data)

names(data)
data_sel <- data[, 5:41]
names(data_sel)

res_sber <- NbClust::NbClust(data_sel, distance = "euclidean", min.nc=2, max.nc=10,
                             method = "kmeans", index = "all")
