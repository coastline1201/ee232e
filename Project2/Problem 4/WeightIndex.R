# this function is the core function of problem 4. It calculates the intersect and union of the input actorname list. It calculates the jaccard index and save as txt files.
WeightIndex <- function(j,Actorname)
{ 
  # Calculate duplicated index when mapping
  removelist = 1:j
  # Make jaccub index mapping
  edgerep = rep(Actorname[j],mlen)
  edgerep = edgerep[-removelist]
  edgemap = Actorname[-removelist]
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
  write.table(edge,file = paste("edgeindex_",j,".txt"),row.names = FALSE,col.names = FALSE, sep = "\t\t")
  write.table(realindextemp,file = paste("trueindex_",j,".txt"),row.names = FALSE,col.names = FALSE, sep = "\t\t")
}