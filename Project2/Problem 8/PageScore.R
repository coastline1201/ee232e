# This script is to make the hash table of Actorname -> PagerankScore. Also generates the top five pageranks of each movie
library("hash")
library("igraph")
library("parallel")
library("iterators")
library("doParallel")
library("foreach")
setwd("~/Desktop/Movie")
rm(movie)
rm(movies)
rm(lines)
Moviename = Edgefile[,1]
Actorname = Edgefile[,2]
mlen = length(Moviename)
PageScore = matrix("numeric",mlen,5)
for (i in 1:mlen)
{
  if(i%%1000==0)
  {
    print(i)
  }
  Actors = Actorname[[i]] 
  len = length(Actors)
  Score = vector("numeric",len)
  for (j in 1:len)
  {
    if (Actors[j] > 0)
    {
     Actname = hActorID[[paste(Actors[j])]]
    }
    if (Actors[j] < 0)
    {
      Actname = hActressID[[paste(Actors[j])]]
    }
    if (has.key(Actname,hActScore))
    {
      Score[j] = hActScore[[Actname]]
    }
  }
  Scorereal = tail(sort(Score),5)
  PageScore[i,1:5] = Scorereal
}