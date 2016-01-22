# This script is used to adjust the format of the movenames in the rating.list and actor_movie.list by erasing extra spaces.
library(stringi)
library(hash)
load("~/Dropbox/232project/MovieHash10.RData")
load("~/Dropbox/232project/RateHash.RData")
MovienameEdge = edgefile[,1]
ActornameEdge = edgefile[,2]
mlen = length(MovienameEdge)
NewHashEdge = hash()
for (i in 1:mlen)
{
  if(i%%1000==0)
  {
    print(i)
  }
  Movienametemp = MovienameEdge[[i]]
  if (stri_sub(Movienametemp,-2,-1) =="  ")
  {Movienametemp = stri_sub(Movienametemp,1,-3)}
  NewHashEdge[Movienametemp] = ActornameEdge[[i]]
}
movies <- keys(NewHashEdge)
mlen <- length(movies)
# make a matrix containing movie name in column1 and actors in column2
edgefile <- vector("list", 2*mlen)
for (i in 1:mlen)
{
  edgefile[[(2*i-1)]] <- movies[i]
  edgefile[[2*i]] <- NewHashEdge[[movies[i]]]
}
dim(edgefile) <- c(2,mlen)
edgefile = t(edgefile)
MovienameRated = keys(hRating)
Moviename = intersect(M1,MovienameRated)
