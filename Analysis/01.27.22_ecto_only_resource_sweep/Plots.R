require(ggplot2)
install.packages("viridis")
library(viridis)

#Bonferroni correction for multiple comparisons for all wilcox rank sum tests
bonferroni <- 9

initial_data <- read.table("01.27.22_ecto_only_resource_sweep/ectoOnly_resSweep_munged_data.dat", h=T)
#symbiont <- subset(initial_data, partner=="Sym")
#symbiont <- na.omit(symbiont)
final_update <-subset(initial_data, update ==100000)
final_update <- cbind(final_update, ratio=final_update$hosted_sym_count/final_update$free_sym_count)
final_update$ratio[is.na(final_update$ratio)] <- 0


#All HTMR, all VT
labelForX <- c("10", "50", "100", "500", "1000")
labelForLeg = c("10", "50", "100", "500", "1000")

#3 in x 6 in
ggplot(data=final_update, aes(x=host_res_dis, y=ratio, color=sym_res_dis)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Mean Symbiont Interaction Value") + xlab("Vertical Transmission Rate") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.87, 0.3)) + guides(fill=FALSE) +ylim(-1,1) + scale_color_manual(name="Horizontal\nTransmission\nMutation Rate", values=viridis(5), labels = labelForLeg) +  scale_x_discrete(labels= labelForX)
