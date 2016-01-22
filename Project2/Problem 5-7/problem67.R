newMovie<-c("Batman v Superman: Dawn of Justice (2016)","Mission: Impossible - Rogue Nation (2015)","Minions (Voice) (2015)")
#read and hash ratings
#ratings<-readLines(con <- file("movie_rating.txt", encoding = "ISO8859-1"))
#close(con)
#hRating<-hash()
#for(i in 1:length(ratings))
#{
#  if(i%%1000==0)
#  {
#    print(i)
#  }
#  oneLine<-strsplit(ratings[i],"\t\t")
#  oneLine<-oneLine[[1]]
#  hRating[oneLine[1]]=oneLine[2]
#}
#find 5 nearst neighbour & predict

print("create new graph")
g2<-graph.data.frame(NewMatrix,directed=F)
print("find new community")
fc<-fastgreedy.community(g2,weights=E(g2)$V3)
print("find nearest neighbor")
for(k in 1:3)
{
  newNode<-which(V(g2)$name==newMovie[k])
  incidents<-incident(g2,newNode)
  neighbors<-neighbors(g2,newNode)
  if(length(neighbors)>5)
  {
    weights<-E(g2)[incidents]$V3
    weightSort<-sort(weights,index.return=T,decreasing=T)
    top5index<-weightSort$ix[1:5]
    top5<-neighbors[top5index]
  }
  else
  {
    top5<-neighbors
  }
  print(newMovie[k])
  print(fc$membership[newNode])
  print(Moviename[top5])
  print(fc$membership[top5])
  
  ratingVec<-c()
  for(n in 1:length(top5))
  {
    name<-Moviename[top5[n]]
    rating<-HashRate[[name]]
    if(!is.null(rating))
      ratingVec<-c(ratingVec,rating)
  }
  print("predict rating:")
  print(mean(as.numeric(ratingVec)))
}


