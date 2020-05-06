# Loading packages and library
install.packages("dplyr")
install.packages("igraph")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("d3Network")
install.packages("networkD3")
install.packages("sentimentr")
install.packages("tm")
install.packages("reshape")
install.packages("reshape2")

library(d3Network)
library(networkD3)
library(dplyr)
library(igraph)
library(ggplot2)
library(tm)
library(sentimentr)
library(reshape) 
library(reshape2)


#Loading the data from local directory
setwd("~/Documents/R Workspace/Nishant/MIS SNA SENTIMENT IMDB")
scripts <- read.csv("Harry Potter 1 Script.csv")


#Filtering out Unnamed characters from the conversations.
scripts<-scripts %>% filter(!Speaker  %in%  c("All","Boy","Girl","Man","Boy 2","Woman","Scene") | !Recipient  %in%  c("All","Boy","Girl","Man","Boy 2","Woman","Scene"))


#Group by Speaker and Recipient
scripts<-scripts %>% group_by(Scene)
conversations <- scripts %>% group_by(Speaker, Recipient) %>% summarise(counts = n())


#Speaker and converation count
by_speaker_scene <- scripts %>%
  count(Scene, Speaker)

by_speaker_scene


#Recipient and converation count
by_recipient_scene <- scripts %>%
  count(Scene, Recipient)

by_recipient_scene


#Speaker Vs Scene Matrix
speaker_scene_matrix<-acast(by_speaker_scene,Speaker~Scene, fun.aggregate = length)
norm <- speaker_scene_matrix / rowSums(speaker_scene_matrix)
h <- hclust(dist(norm, method = "manhattan"))
plot(h)

ordering <- h$labels[h$order]
ordering


#Speaker Vs Scene Time Series
eachscene <- by_speaker_scene %>%
  filter(n() > 0) %>% 
  ungroup() %>%
  mutate(Scene = as.numeric(factor(Scene)),
         Speaker = factor(Speaker, levels = ordering))

ggplot(eachscene, aes(Scene, Speaker)) +
  geom_point() +
  geom_path(aes(group = Scene))+
  ggtitle("Speaker vs Scene Time Series")+
  theme(plot.title = element_text(hjust = 0.4,face = "bold"))


#HeatMap
cooccur<-speaker_scene_matrix %*% t(speaker_scene_matrix)
heatmap(cooccur)
heatmap(speaker_scene_matrix)


#Social Network - igraph
g <-graph_from_adjacency_matrix(cooccur, weighted = TRUE, mode = "undirected", diag = FALSE)
plot(g, edge.width = E(g)$weight)


#Centrality Measures 
sort(degree(g)/41)
sort(closeness((g)))
sort(betweenness(g))
E(g)$weight


#Simplified Social Network using forceNetwork to plot 3D Network
sg <- simplify(g)
df <- get.edgelist(g, names=TRUE)
df <- as.data.frame(df)
colnames(df) <- c('source', 'target')
df$value <- E(g)$weight
df$weight<-E(g)$weight
# Choose any 1 community to cluster the network as per different algorithms
fc<-edge.betweenness.community(g) # We are using betweeness for SNA
#fc <- fastgreedy.community(g)
#fc<-walktrap.community(g)
#fc<-infomap.community(g)
#fc<-label.propagation.community(g)
#fc<-spinglass.community(g)
#fc<-leading.eigenvector.community(g)

com <- membership(fc)
a<-betweenness(g)
node.info <- data.frame(name=names(com), group=as.vector(com),a)
links <- data.frame(source=match(df$source, node.info$name)-1,target=match(df$target, node.info$name)-1,value=df$value)
Nodesizee=node.info$betweenness.g.

forceNetwork(Links = links, Nodes = node.info,Source = "source", 
             Target = "target",Value = "value", NodeID = "name",
             Nodesize="a",Group = "group", height=NULL,width=NULL,
             colourScale = JS("d3.scaleOrdinal(d3.schemeCategory20);"),
             fontSize=25,linkDistance=350,opacity = 1, 
             linkWidth = JS("function(d) { return Math.sqrt(d.value); }"),
             linkColour = "black",
             radiusCalculation = JS("Math.sqrt(d.nodesize)+10"),
             opacityNoHover=10,zoom=TRUE,
             legend=FALSE,arrows = TRUE)


