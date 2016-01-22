# this script is for makeing the hash table of Moviename -> Actor's list. It will delete movies which have less than 10 actors.
library("hash")
library("igraph")
library("parallel")
setwd("~/Dropbox/232project")
# list.files()
hMovie <- hash()
print("hashing actors")
lines <- readLines(con <- file("actor_movies.txt", encoding = "ISO8859-1"))
close(con)
for ( i in 1:length(lines))
{
  oneline<-strsplit(lines[i],"\t\t")
  oneline<-oneline[[1]]
  len <- length(oneline)
  if (len > 1){
    for (j in 2:len)
    {
      if(oneline[j] != "")
      {
        movie = hMovie[[oneline[j]]]
        hMovie[oneline[j]] <- c(movie, oneline[1])
      }
    }
  }
}
print("hashing actress")
lines <- readLines(con <- file("actress_movies.txt", encoding = "ISO8859-1"))
close(con)
for ( i in 1:length(lines))
{
  oneline<-strsplit(lines[i],"\t\t")
  oneline<-oneline[[1]]
  len <- length(oneline)
  if (len > 1){
    for (j in 2:len)
    {
      
      if(oneline[j] != "")
      {
        movie = hMovie[[oneline[j]]]
        hMovie[oneline[j]] <- c(movie, oneline[1])
      }
    }
  }
}
print("delete movies")
movie <- keys(hMovie)
len <- length(movie)
for ( k in 1:len)
{
  actors <- hMovie[[movie[k]]]
  if(length(actors) < 10 )
  {
    del(movie[k], hMovie)
  }
}
# values(hMovie)
print("read edgelist file")
# hEdgelist <- hash()
#v <- values(hMovie)
movies <- keys(hMovie)
mlen <- length(movies)
# make a matrix containing movie name in column1 and actors in column2
edgefile <- vector("list", 2*mlen)
for (i in 1:mlen)
{
  edgefile[[(2*i-1)]] <- movies[i]
  edgefile[[2*i]] <- hMovie[[movies[i]]]
}
dim(edgefile) <- c(2,mlen)
edgefile = t(edgefile)
save.image("~/Dropbox/232project/edgefile15.RData")
rm(list = ls())
