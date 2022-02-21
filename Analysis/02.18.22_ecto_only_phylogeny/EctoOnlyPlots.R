library("ggplot2")
library("scales")
library(viridis)
library(tidyr)

######################################
######## Time spent in states ########
######################################
munge <- read.table("ecto_only_dom_stateseq.data", h=T)
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


######################################
########## Average Int Vals ##########
######################################
getOption("scipen")
options(scipen = 100L)


initial_data <- read.table("ecto_only_munged_data.dat", h=T)
initial_data[4][initial_data[4] == '500'] <- 'SR500'
initial_data[4][initial_data[4] == '1000'] <- 'SR1000'
hosts <- data.frame("rep"=initial_data$rep, 
                    "sr"=initial_data$sr, 
                    "int_val" = initial_data$host_val, 
                    "update" = initial_data$update,
                    "count" = initial_data$host_count)
syms <- data.frame("rep"=initial_data$rep, 
                   "sr"=initial_data$sr, 
                   "int_val" = initial_data$sym_val, 
                   "update" = initial_data$update,
                   "count" = initial_data$sym_count)

colors <- turbo(2)
line_names <- c("Hosts", "Symbionts")
colors_dictionary <- c()
for(i in 1:(length(line_names))){
  colors_dictionary[line_names[i]] <- colors[i]
}

ggplot(NULL, aes(x=update, y=int_val)) +
  ylab("Interaction Value") + xlab("Time") + 
  theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  stat_summary(aes(color = "Hosts", fill="Hosts"), data = hosts, fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) +
  stat_summary(aes(color = "Symbionts", fill="Symbionts"), data = syms, fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) +
  scale_color_manual(name = "Organism", breaks = line_names, values = colors_dictionary) + 
  scale_fill_manual(values=colors_dictionary, guide="none") +
  scale_y_continuous(labels = comma, limits = c(-1.0, 1.0)) + facet_wrap(~sr) 

ggplot(NULL, aes(x=update, y=count)) +
  ylab("Organism Count") + xlab("Time") + 
  theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  stat_summary(aes(color = "Hosts", fill="Hosts"), data = hosts, fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) +
  stat_summary(aes(color = "Symbionts", fill="Symbionts"), data = syms, fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) +
  scale_color_manual(name = "Organism", breaks = line_names, values = colors_dictionary) + 
  scale_fill_manual(values=colors_dictionary, guide="none") +
  scale_y_continuous(labels = comma, limits = c(0, 10000)) + facet_wrap(~sr) 
