# THis script prepares the data for problem 8. It makes two hash tables : 1. Movienames -> rating 2. Movienames -> genre. 
library("hash")
library("igraph")
load("~/Dropbox/232project/NewHashEdge.RData")
load("~/Dropbox/232project/RateHash.RData")
load("~/Dropbox/232project/GenreHash.RData")
MovienameEdge = edgefile[,1]
ActornameEdge = edgefile[,2]
MovienameRated = keys(HRating)
Genre = keys(hGenre)
Moviename1 = intersect(MovienameEdge,MovienameRated)
mlen = length(Moviename1)
Moviename = intersect(Moviename1,Genre)
mlen = length(Moviename)
HashMovie = hash()
for (i in 1:mlen)
{
  if(i%%1000==0)
  {
    print(i)
  }
  HashMovie[Moviename[i]] = NewHashEdge[[Moviename[i]]]
}
movies <- keys(HashMovie)
mlen <- length(movies)
# make a matrix containing movie name in column1 and actors in column2
edgefile <- vector("list", 2*mlen)
for (i in 1:mlen)
{
  edgefile[[(2*i-1)]] <- movies[i]
  edgefile[[2*i]] <- HashMovie[[movies[i]]]
}
dim(edgefile) <- c(2,mlen)
edgefile = t(edgefile)
Edgefile = edgefile

mlen = length(Moviename)
HashRate = hash()
for (i in 1:mlen)
{
  if(i%%1000==0)
  {
    print(i)
  }
  HashRate[Moviename[i]] = HRating[[Moviename[i]]]
}

HashGenre = hash()
for (i in 1:mlen)
{
  if(i%%1000==0)
  {
    print(i)
  }
  HashGenre[Moviename[i]] = hGenre[[Moviename[i]]]
}

MovieFile = matrix("numeric",mlen,4)
MovieFile[,1] = Moviename
Actorname = Edgefile[,2]
