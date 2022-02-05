library("ggplot2")
library("scales")
library(viridis)

getOption("scipen")
options(scipen = 100L)


initial_data <- read.table("ectoonly_munged_data.dat", h=T)

initial_data <- cbind(initial_data, VAR=factor(initial_data$vt))

colors <- plasma(11)

##################################
### STANDARD SET OF LINE PLOTS ###
##################################
#to remove the break down into replicates, comment out '+ facet_wrap(~rep)'
ggplot(data=initial_data, aes(x=update, y=free_sym_val, group=VAR, colour=VAR)) + 
  ylab("Free Sym Val") + xlab("Time") + 
  stat_summary(aes(color=VAR, fill=VAR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill="none") +  
  scale_colour_manual(name="VT", values=colors) + 
  scale_fill_manual(values=colors) +
  ylim(-1.1,1.1) #+ facet_wrap(~rep)

ggplot(data=initial_data, aes(x=update, y=hosted_sym_val, group=VAR, colour=VAR)) + 
  ylab("Hosted Sym Val") + xlab("Time") + 
  stat_summary(aes(color=VAR, fill=VAR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill="none") +  scale_colour_manual(name="VT", values=colors) + scale_fill_manual(values=colors) +
  ylim(-1.1,1.1) #+ facet_wrap(~rep)

ggplot(data=initial_data, aes(x=update, y=host_val, group=VAR, colour=VAR)) + 
  ylab("Host Val") + xlab("Time") + 
  stat_summary(aes(color=VAR, fill=VAR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill="none") +  scale_colour_manual(name="VT", values=colors) + scale_fill_manual(values=colors) +
  ylim(-1.1,1.1) #+ facet_wrap(~rep)

ggplot(data=initial_data, aes(x=update, y=free_sym_infectchance, group=VAR, colour=VAR)) + 
  ylab("Free Sym Infection Chance") + xlab("Time") + 
  stat_summary(aes(color=VAR, fill=VAR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill="none") +  scale_colour_manual(name="VT", values=colors) + scale_fill_manual(values=colors) +
  ylim(-0.01,1.01) #+ facet_wrap(~rep)

ggplot(data=initial_data, aes(x=update, y=hosted_sym_infectchance, group=VAR, colour=VAR)) + 
  ylab("Hosted Sym Infection Chance") + xlab("Time") + 
  stat_summary(aes(color=VAR, fill=VAR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill="none") +  scale_colour_manual(name="VT", values=colors) + scale_fill_manual(values=colors) +
  ylim(-0.01,1.01) #+ facet_wrap(~rep)

ggplot(data=initial_data, aes(x=update, y=hosted_sym_count, group=VAR, colour=VAR)) + 
  ylab("Hosted Sym Count") + xlab("Time") + 
  stat_summary(aes(color=VAR, fill=VAR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill="none") +  scale_colour_manual(name="VT", values=colors) + scale_fill_manual(values=colors) +
  scale_y_continuous(labels = comma, limits=c(-1,10001)) #+ facet_wrap(~reo)

ggplot(data=initial_data, aes(x=update, y=free_sym_count, group=VAR, colour=VAR)) + 
  ylab("Free Sym Count") + xlab("Time") + 
  stat_summary(aes(color=VAR, fill=VAR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill="none") +  scale_colour_manual(name="VT", values=colors) + scale_fill_manual(values=colors) +
  scale_y_continuous(labels = comma, limits=c(-1,10001)) #+ facet_wrap(~rep)