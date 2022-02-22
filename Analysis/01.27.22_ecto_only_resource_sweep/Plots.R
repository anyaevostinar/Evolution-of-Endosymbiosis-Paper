require(ggplot2)
install.packages("viridis")
library(viridis)

#Bonferroni correction for multiple comparisons for all wilcox rank sum tests
bonferroni <- 9

initial_data <- read.table("01.27.22_ecto_only_resource_sweep/ectoOnly_resSweep_munged_data.dat", h=T)
#symbiont <- subset(initial_data, partner=="Sym")
final_update <-subset(initial_data, update ==100000)


labelForX <- c("10", "50", "100", "500", "1000")
labelForLeg = c("10", "50", "100", "500", "1000")

#4 in x 4 in
ggplot(data=final_update, aes(x=as.factor(host_res_dis), y=free_sym_val, color=as.factor(sym_res_dis))) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Ectosymbiont Interaction Value") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.8, 0.75)) + guides(fill=FALSE) +ylim(-1,1) + scale_color_manual(name="FLS Resources", values=viridis(5), labels = labelForLeg) +  scale_x_discrete(labels= labelForX)
