library("hash")
library("igraph")
setwd("~/Dropbox/232e hw/proj2")
print("create graph")
g1<-graph.data.frame(MatrixFile,directed=F)
print("find community")
fc<-fastgreedy.community(g1,weights=E(g1)$V3)
#read and hash genres
#genres<-readLines(con <- file("movie_genre.txt", encoding = "ISO8859-1"))
#close(con)
#hGenre<-hash()
#for(i in 1:length(genres))
#{
#  oneLine<-strsplit(genres[i],"\t\t")
#  oneLine<-oneLine[[1]]
#  hGenre[oneLine[1]]=oneLine[2]
#}


print("tag community with genre")
comTag<-vector(length=length(fc))
for(j in 1:length(fc))
{
  print(j)
  myComNode<-(1:vcount(g1))[fc$membership==j]
  genreTable<-vector(length=length(myComNode))
  for(n in 1:length(myComNode))
  {
    genreTable[n]=HashGenre[[Moviename[myComNode[n]]]]
  }
  genreTable<-as.data.frame(table(genreTable))
  genreTable$Freq<-genreTable$Freq/sizes(fc)[j]
  maxGenreIndex<-which.max(genreTable$Freq)
  if(genreTable[maxGenreIndex,]$Freq>0.2)
  {
    genreTable<-as.matrix(genreTable)
    comTag[j]=genreTable[maxGenreIndex,1]
  }
  genreTable<-genreTable[order(genreTable[,2],decreasing=T),]
  
  print(genreTable[1:min(3,nrow(genreTable)),])
}
print(sizes(fc))
print(comTag)