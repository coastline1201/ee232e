# This script is for calculating the jaccard index for problem 4. We used foreach %dopar% for parralel analysis to
# increase the speed. the function WeightIndex is for calculating the jaccard index
rm(list = ls())
library("hash")
library("igraph")
library("parallel")
library("iterators")
library("doParallel")
library("foreach")
registerDoParallel(cores = 8)
setwd("~/Desktop/Final/edge")
load("~/Desktop/Final/Movie.RData")
Moviename = Edgefile[,1]
Actorname = Edgefile[,2]
mlen = length(Moviename)
ex = foreach (j = 1:mlen) %dopar% 
  {
    WeightIndex(j,Actorname)
  }