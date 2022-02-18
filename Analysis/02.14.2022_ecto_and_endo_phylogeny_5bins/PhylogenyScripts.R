library("ggplot2")
library("scales")
library(viridis)
library(tidyr)

######################################
######## Time spent in states ########
######################################
munge <- read.table("ecto_endo_dom_stateseq.data", h=T)
munge <- munge[order(munge$origin_time),] 
munge[3][munge[3] == '500'] <- 'SR500'
munge[3][munge[3] == '1000'] <- 'SR1000'
munge[1][munge[1] == 'Sym'] <- 'Symbiont'

  

ggplot(munge, aes(fill=info, y=time_in_state, x=rep)) + 
  geom_bar(position="stack", stat="identity") +
  scale_fill_viridis(option="magma")+
  xlab("Replicate") + ylab("Time in state (in updates)") +
  facet_grid(sr ~ partner) +
  coord_flip()


