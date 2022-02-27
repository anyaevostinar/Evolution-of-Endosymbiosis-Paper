library("ggplot2")
library("scales")
library(viridis)
library(tidyr)

######################################
######## Time spent in states ########
######################################
munge <- read.table("endo_only_dom_stateseq.data", h=T)
munge <- munge[order(munge$origin_time),] 
munge[3][munge[3] == '500'] <- 'FLS Resources 500'
munge[3][munge[3] == '1000'] <- 'FLS Resources 1000'
munge[1][munge[1] == 'Sym'] <- 'Symbiont'


ggplot(munge, aes(fill=info, y=time_in_state, x=rep)) + 
  geom_bar(position="stack", stat="identity", width = 0.8) +
  scale_fill_viridis(option="mako")+
  xlab("Replicate") + ylab("Time in state (in updates)") +
  facet_grid(sr ~ partner) +
  coord_flip() 

######################################
##### Count time spent parasitic #####
######################################
sum_of_states = data.frame("partner", "rep", "sr", "info", "total_time_in_state")
colnames(sum_of_states) <- c("partner", "rep", "sr", "info", "total_time_in_state")
sum_of_states = sum_of_states[-1,]

for(r in 10:40){
  for(s in c("SR500", "SR1000")){
    for(p in c("Symbiont")){ #only focusing on symbionts, for now
      for(i in 0:3){
        sum <- sum(munge[which(munge$partner==p &
                                 munge$rep==r &
                                 munge$sr==s &
                                 munge$info==i
        ), 8])
        subset <- c(p, r, s, i, sum)
        sum_of_states[nrow(sum_of_states) + 1,] <- subset
      }
    }
  }
}


no_bin_1 <- subset(sum_of_states, sum_of_states$info==1 & sum_of_states$total_time_in_state==0)
print(nrow(no_bin_1))

no_bin_0 <- subset(sum_of_states, sum_of_states$sr=="SR1000"& sum_of_states$info==0 & sum_of_states$total_time_in_state==0)
print(nrow(no_bin_0))
