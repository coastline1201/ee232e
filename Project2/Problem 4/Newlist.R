# new version of list.R. the difference is deleting the actors whom acted less than 15 movies
rm(list = ls())
library("hash")
library("igraph")
setwd("~/Desktop/232project")
hMovie <- hash()
hActorID <- hash()
actorID <- 1
print("hashing actors")
lines <- readLines(con <- file("actor_movies.txt", encoding = "ISO8859-1"))
close(con)
for ( i in 1:length(lines)) 
{ if(i%%1000==0)
{
  print(i)
}
oneline<-strsplit(lines[i],"\t\t")
oneline<-oneline[[1]]
len <- length(oneline)

if (len > 16){
  hActorID[actorID] <- oneline[1]
  for (j in 2:len)
  {
    if(oneline[j] != "")
    {
      actors = hMovie[[oneline[j]]]
      hMovie[oneline[j]] <- c(actors, actorID)
    }
  }
  actorID <- actorID + 1
}
}
print("hashing actress")
rm(lines)
lines <- readLines(con <- file("actress_movies.txt", encoding = "ISO8859-1"))
close(con)
hActressID <- hash()
actressID <- -1
for ( i in 1:length(lines))
{ if(i%%1000==0)
{
  print(i)
}
oneline<-strsplit(lines[i],"\t\t")
oneline<-oneline[[1]]
len <- length(oneline)
if (len > 16)
{
  hActressID[actressID] <- oneline[1]
  for (j in 2:len)
  {
    if(oneline[j] != "")
    {
      actresses = hMovie[[oneline[j]]]
      hMovie[oneline[j]] <- c(actresses, actressID)
    }
  }
  actressID <- actressID - 1
}
}

print("delete movies")
movie <- keys(hMovie)
len <- length(movie)
for ( k in 1:len)
{
  if(k%%100==0)
  {
    print(k)
  }
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
rm(movie)
rm(movies)
rm(lines)
save.image("~/Dropbox/232project/Newedgefile.RData")
rm(list = ls())
