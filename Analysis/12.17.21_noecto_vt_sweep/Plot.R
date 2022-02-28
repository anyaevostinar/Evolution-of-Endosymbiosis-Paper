require(ggplot2)
install.packages("viridis")
library(viridis)

initial_data <- read.table("12.17.21_noecto_vt_sweep/vtsweep_munged_data.dat", h=T)
#symbiont <- subset(initial_data, partner=="Sym")
final_update <-subset(initial_data, update ==100000)


ggplot(data=final_update, aes(x=as.factor(vt*100), y=hosted_sym_count)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Endosymbiont Count") + xlab("Vertical Transmission Rate %") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE)  + scale_color_manual(name="Vertical Transmission rate", values=magma(12)) + ylim(0, 7000)

