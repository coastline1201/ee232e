# This script is for combining all the save txt file for jaccard index calculation
L = 0
matrixfile = matrix("numeric",10000000,3)
mlen = 45020
setwd("~/Desktop/Final/edge")
for (i in 1:mlen)
{
  if(i%%100==0)
  {
    print(i)
  }
  edge = as.numeric(readLines(paste("edgeindex_",i,".txt")))
  index = as.numeric(readLines(paste("trueindex_",i,".txt")))
  len = length(edge)
  if (len != 0)
  {
  matrixfile[(L+1):(L+len),1:3] = cbind(i,index,edge,deparse.level = 0)
  L = L + length(edge)
  }
}






