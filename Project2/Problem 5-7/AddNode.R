# This script is for calculating the jaccard index of the three new movies. 
rm(list = ls())
library("hash")
library("igraph")
library("parallel")
library("iterators")
library("doParallel")
library("foreach")
registerDoParallel(cores = 8)
setwd("~/Desktop/Final/")
load("~/Desktop/Final/Movie.RData")
Moviename = Edgefile[,1]
Actorname = Edgefile[,2]
mlen = length(Moviename)

  # Make jaccub index mapping
  edgerep = rep(list(Node3Act),mlen)
  edgemap = Actorname
  # map intersect and remove independent
  #intersectedge = mcmapply(intersect,edgerep,edgemap,mc.preschedule = TRUE,mc.cores = 5)
  intersectedge = mapply(intersect,edgerep,edgemap,SIMPLIFY = FALSE)
  dependentlisttemp = 1:length(intersectedge)
  dependentlist = dependentlisttemp[intersectedge != "numeric(0)"]
  edgerep = edgerep[dependentlist]
  edgemap = edgemap[dependentlist]
  intersectedgelength = mapply(unlist,lapply(intersectedge[dependentlist],length))
  realindextemp = j+dependentlist
  # map union
  unionedge = mapply(union,edgerep,edgemap,SIMPLIFY = FALSE)
  unionedgelength = mapply(unlist,lapply(unionedge,length))
  # map jaccub index
  movieindex = mapply("/",intersectedgelength,unionedgelength,SIMPLIFY = FALSE)
  # Make final network matrix
  edge = mapply(unlist,movieindex)
  # Save results
  write.table(edge,file = paste("edgeindex_",3,".txt"),row.names = FALSE,col.names = FALSE, sep = "\t\t")
  write.table(realindextemp,file = paste("trueindex_",3,".txt"),row.names = FALSE,col.names = FALSE, sep = "\t\t")