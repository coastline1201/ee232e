# This script prepares the dataset used to do the regression model and traing. The matrix has 51 columns. 1st column is the MovieID. Second column is the rating. Third is the mean Genre rating. 4:9 is the top 5 page ranks of each movie. 10:51 are the boolean values.
library("hash")
library("igraph")
library(stringi)
load("~/Dropbox/232project/Movie.RData")
load("~/Desktop/Final/PageRankScore.RData")
load("~/Desktop/Final/GenreMeanRate.RData")
setwd()
Moviename = Edgefile[,1]
Actorname = Edgefile[,2]
mlen = length(Moviename)
RegressionMatrix = matrix("numeric",mlen,51)
len = length(TopDirector)

for (i in 1:mlen)
{
  if(i%%1000==0)
{
  print(i)
}
  RegressionMatrix[i,1] = i
  RegressionMatrix[i,2] = as.numeric(HashRate[[Moviename[[i]]]])
  RegressionMatrix[i,3] = as.numeric(Genrerate[[HashGenre[[Moviename[[i]]]]]])
  RegressionMatrix[i,4:8] = as.numeric(PageScore[i,1:5])*100000
  
}
removerow = vector("numeric",mlen)
j = 1
for (i in 1:mlen)
{
  if(i%%1000==0)
  {
    print(i)
  }
  if ("0" %in% RegressionMatrix[i,4:8])
  {
    removerow[j] = i
    j = j +1
  }
}
removerow = removerow[1:j-1]
RegressionMatrix = RegressionMatrix[-removerow,]

Director = keys(TopDirector)
mlen = length(RegressionMatrix)/51
for (i in 1:mlen)
{
  if(i%%100==0)
  {
    print(i)
  }
  Movie = Moviename[[as.numeric(RegressionMatrix[i,1])]]
  Movie = paste(Movie," ")
  for (j in 1:len)
  {
    if (Movie %in% TopDirector[[Director[j]]])
    { print(i)
      print(j)
      RegressionMatrix[i,(8+j)] = 1
    } 
  }
}
M = RegressionMatrix[,9:50]
removecol = vector("numeric",len)
j = 1
for (i in 1:len)
{
  if ("1" %in% M[,i])
  {} else {removecol[j] = i
  j = j +1}
}
removecol = removecol[1:(j-1)] 
removecol = removecol + 8
RegressionMatrix = RegressionMatrix[,-removecol]
for (i in 1:mlen)
{
  if ("1" %in% RegressionMatrix[i,9:34])
  {RegressionMatrix[i,35] = 0} else {RegressionMatrix[i,35] = 1}
}
write.table(RegressionMatrix,file = "RegressionMatrix.txt",row.names = FALSE,col.names = FALSE, sep = "\t\t")