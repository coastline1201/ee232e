# This scripted is used to make a hash table of Actorname -> ActorID
# The second part is converting the three new movie’s actor name list to actorID
hIDActor = hash()
len = length(hActorID)
for (i in 1:len)
{
  if(i%%1000==0)
  {
    print(i)
  }
  hIDActor[hActorID[[paste(i)]]] = i
}
hIDActress = hash()
len = length(hActressID)
for (i in 1:len)
{
  if(i%%1000==0)
  {
    print(i)
  }
  hIDActress[hActressID[[paste(-i)]]] = -i
}

len1 = length(Node1)
Node1Act = vector("numeric",len1)
for (i in 1:len1)
{
  if (has.key(Node1[i],hIDActor))
  {
    Node1Act[i] = hIDActor[[Node1[i]]]
  }
  if (has.key(Node1[i],hIDActress))
  {
    Node1Act[i] = hIDActress[[Node1[i]]]
  }
}
Node1Act = Node1Act[Node1Act!=0]

len1 = length(Node2)
Node2Act = vector("numeric",len1)
for (i in 1:len1)
{
  if (has.key(Node2[i],hIDActor))
  {
    Node2Act[i] = hIDActor[[Node2[i]]]
  }
  if (has.key(Node2[i],hIDActress))
  {
    Node2Act[i] = hIDActress[[Node2[i]]]
  }
}
Node2Act = Node2Act[Node2Act!=0]

len1 = length(Node3)
Node3Act = vector("numeric",len1)
for (i in 1:len1)
{
  if (has.key(Node3[i],hIDActor))
  {
    Node3Act[i] = hIDActor[[Node3[i]]]
  }
  if (has.key(Node3[i],hIDActress))
  {
    Node3Act[i] = hIDActress[[Node3[i]]]
  }
}
Node3Act = Node3Act[Node3Act!=0]