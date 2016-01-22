# This script is for hashing the table of Actorname -> Movies acted
library("hash")
library("igraph")
setwd("~/Desktop/232project")
ActtoMovie = hash()
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

if (len > 5){
  ActtoMovie[oneline[1]] = oneline[2:len]
}
# if(oneline[j] != "")
}