# This script calculates the mean genre rate for each genre through making the hash table genre-> movienames
library("hash")
library("igraph")
load("~/Dropbox/232project/Movie.RData")
MovieFile = matrix("numeric",mlen,2)
MovieFile[,1] = Moviename

Genrerate = hash()
for (i in 1:mlen)
{ if(i%%1000==0)
{
  print(i)
}
  if (has.key(HashGenre[[Moviename[i]]],Genrerate)==FALSE) 
{
  Genrerate[HashGenre[[Moviename[i]]]] = as.numeric(HashRate[[Moviename[i]]])
}
  if (has.key(HashGenre[[Moviename[i]]],Genrerate)) 
  {
  Genrerate[[HashGenre[[Moviename[i]]]]] = c(Genrerate[[HashGenre[[Moviename[i]]]]],as.numeric(HashRate[[Moviename[i]]]))
  }
}
Genrelist = keys(Genrerate)
for (i in 1:length(Genrelist))
{
  Genrerate[Genrelist[i]] = mean(Genrerate[[Genrelist[i]]])
}
for (i in 1:mlen) {
  if(i%%1000==0)
  {
    print(i)
  }
  MovieFile[i,2] = HashRate[[Moviename[i]]]
  #MovieFile[i,4] = HashGenre[Moviename[i]]
}