library("igraph")
library("hash")
setwd("~/Dropbox/232e hw/proj2")

print("reading actor")
lines<-readLines("actor_movies.txt")

print("hashing actor")
ActID<-1
movieID<-0
IntActNum<-list()
hMovieIntAct<-hash()
len=length(lines)
for(i in 1:len)
{
  oneLine<-strsplit(lines[i],"[\t]+")
  oneLine<-oneLine[[1]]
  myLen<-length(oneLine)
  if(myLen>=15)
  {
    IntActNum[[ActID]]=c(oneLine[1],myLen-1)
    for(j in 2:myLen)
    {
        oneLine[j]=gsub("^\\(", "",oneLine[j])
        oneLine[j]=gsub("\\([^[:digit:]]+\\)", "",oneLine[j])
        oneLine[j]=gsub("^\\s+|\\s+$", "",oneLine[j])
        myIDAct=hMovieIntAct[[oneLine[j]]]
        if(is.null(myIDAct))
        {
          hMovieIntAct[oneLine[j]]=c(movieID,ActID)
          movieID<-movieID+1
        }
        else
        {
          hMovieIntAct[oneLine[j]]=c(myIDAct,ActID)
        }
      
    }
    ActID<-ActID+1
  }
}

print("reading actress")
lines<-readLines("actress_movies.txt")

print("hashing actress")
len=length(lines)
for(i in 1:len)
{
  oneLine<-strsplit(lines[i],"[\t]+")
  oneLine<-oneLine[[1]]
  myLen<-length(oneLine)
  if(myLen>=15)
  {
    IntActNum[[ActID]]=c(oneLine[1],myLen-1)
    for(j in 2:myLen)
    {
        oneLine[j]=gsub("^\\(", "",oneLine[j])
        oneLine[j]=gsub("\\([^[:digit:]]+\\)", "",oneLine[j])
        oneLine[j]=gsub("^\\s+|\\s+$", "",oneLine[j])
        myIDAct=hMovieIntAct[[oneLine[j]]]
        if(is.null(myIDAct))
        {
          hMovieIntAct[oneLine[j]]=c(movieID,ActID)
          movieID<-movieID+1
        }
        else
        {
          hMovieIntAct[oneLine[j]]=c(myIDAct,ActID)
        }
      
    }
    ActID<-ActID+1
  }
}

print("hashing edgelist")
IntAct<-values(hMovieIntAct)
hEdgeWt<-hash()
for(i in 1:length(IntAct))
{
  myLength=length(IntAct[[i]])
  if(myLength>2)
  {
    for(j in 2:(myLength-1))
    {
      for(k in (j+1):myLength)
      {
        myEdge=paste(IntAct[[i]][j],IntAct[[i]][k],sep=" ")
        myWt<-hEdgeWt[[myEdge]]
        if(is.null(myWt))
        {
          hEdgeWt[myEdge]=1
        }
        else
        {
          hEdgeWt[myEdge]=myWt+1
        }
      }
    }
  }
}
print("processing final edgelist")
edgeList<-matrix(nrow=2*length(hEdgeWt),ncol=3)
#colnames(edgeList)<-c("node1","node2","weight")
i<-1
for(key in keys(hEdgeWt))
{
  Wt<-hEdgeWt[[key]]
  edge<-strsplit(key," ")
  node1<-strtoi(edge[[1]][1])
  node2<-strtoi(edge[[1]][2])
  edgeList[i,1]=node1
  edgeList[i,2]=node2
  edgeList[i,3]=round(Wt/strtoi(IntActNum[[node1]][2]),3)
  i<-i+1
  edgeList[i,1]=node2
  edgeList[i,2]=node1
  edgeList[i,3]=round(Wt/strtoi(IntActNum[[node2]][2]),3)
  i<-i+1
}
#print("filtering edgelist")
#th<-mean(min(mean(edgeList[,3]),median(edgeList[,3])),min(edgeList[,3]))
#toRemove<-which(edgeList[,3]<th)
#edgeList<-edgeList[-toRemove,]
print("writing edgelist to file")
write.table(edgeList,file="edgelist")
print("generate graph")
g<-graph.edgelist(edgeList[,1:2],directed=T)
E(g)$weight<-edgeList[,3]
print("run pagerank")
scores<-page.rank(g)$vector
print("top 10 scores")
scoresSort<-sort(scores,index.return=T,decreasing=T)
top10ID<-scoresSort$ix[1:10]
print(IntActNum[top10ID])
names<-c("Hepburn, Audrey","Bullock, Sandra","Adams, Amy","Theron, Charlize","Binoche, Juliette","Jolie, Angelina")
for(n in 1:6)
{
  print(names[n])
  m<-grep(names[n],IntActNum)
  print(scores[m])
}
print("top score no.2 & no.1 weight")
m<-which((edgeList[,1]==scoresSort$ix[2])&(edgeList[,2]==scoresSort$ix[1]))
print(edgeList[m,])
print("top score no.1 & no.3 weight")
m<-which((edgeList[,1]==scoresSort$ix[1])&(edgeList[,2]==scoresSort$ix[3]))
print(edgeList[m,])
print("top score no.3 & no.1 weight")
m<-which((edgeList[,1]==scoresSort$ix[3])&(edgeList[,2]==scoresSort$ix[1]))
print(edgeList[m,])
print("top score no.2 & no.3 weight")
m<-which((edgeList[,1]==scoresSort$ix[2])&(edgeList[,2]==scoresSort$ix[3]))
print(edgeList[m,])
print("top score no.3 & no.2 weight")
m<-which((edgeList[,1]==scoresSort$ix[3])&(edgeList[,2]==scoresSort$ix[2]))
print(edgeList[m,])
