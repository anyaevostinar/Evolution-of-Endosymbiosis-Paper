require(ggplot2)
install.packages("viridis")
library(viridis)

initial_data <- read.table("12.16.21_no_ecto_resource_sweep_again/munged_sym_average.dat", h=T)
View(initial_data)
other_data <- read.table("12.16.21_ecto_and_endo_resource_sweep/munged_sym_average.dat", h=T)

View(initial_data)
initial_data <- cbind(initial_data, ratio =initial_data$symHostedCoun/initial_data$symFreeCoun)
other_data <- cbind(other_data, ratio =other_data$symHostedCoun/other_data$symFreeCoun)

initial_data <- cbind(initial_data, ecto="No Ectosymbiosis")
other_data <- cbind(other_data, ecto="With Ectosymbiosis")


symbiont_final <-subset(initial_data, update == 100000)
symbiont_final2 <-subset(other_data, update == 100000)

#Command for nan to 0 

symbiont_final$HR <- factor(symbiont_final$HR, levels=c("HR10", "HR50", "HR100", "HR500", "HR1000"))
symbiont_final$SR <- factor(symbiont_final$SR, levels=c("SR10", "SR50", "SR100", "SR500", "SR1000"))
symbiont_final$ratio[is.nan(symbiont_final$ratio)]<-0
symbiont_final$symHostedDonate[is.na(symbiont_final$symHostedDonate)] <- -2

symbiont_final2$HR <- factor(symbiont_final2$HR, levels=c("HR10", "HR50", "HR100", "HR500", "HR1000"))
symbiont_final2$SR <- factor(symbiont_final2$SR, levels=c("SR10", "SR50", "SR100", "SR500", "SR1000"))
symbiont_final2$ratio[is.nan(symbiont_final2$ratio)]<-0

restrictedNoEcto <- subset(symbiont_final, HR == "HR100" | HR == "HR1000" | HR == "HR500")
restrictedEcto <- subset(symbiont_final2, HR == "HR100" | HR == "HR1000" | HR == "HR500")
combined <- rbind(restrictedNoEcto, restrictedEcto)

ggplot(data=initial_data, aes(x=update, y=symHostedDonate, group=HR, colour=HR)) + labs(title=("Ratio of resources received by host (HR) versus free-living symbionts (SR)")) + ylab("Interaction Value of Endosymbionts") + xlab("Updates") + stat_summary(aes(color=HR, fill=HR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill="none") +scale_colour_manual(name="Host Resources and Symbiont Resources",values=viridis(5)) + scale_fill_manual(values=viridis(5)) + facet_wrap(~SR)


ggplot(data=symbiont_final, aes(x=HR, y=symHostedCount, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Endosymbiont Count") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\n per update", values=viridis(5))

ggplot(data=symbiont_final, aes(x=HR, y=symFreeCount, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Free Symbiont Count") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\n per update", values=viridis(5))

labelForX <- c("100", "500", "1000")
#4 in x 7 in
ggplot(data=combined, aes(x=HR, y=ratio, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Ratio of Endosymbionts to Free-living Symbionts") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "FLS Resources", values=viridis(5), labels = labelForLeg) + scale_x_discrete(labels= labelForX) + ylim(0, 6) + facet_wrap(~ecto)


#Just endo graphs
labelForX <- c("10", "50", "100", "500", "1000")
labelForLeg <- c("10", "50", "100", "500", "1000")
#4 in x 4 in
ggplot(data=symbiont_final, aes(x=HR, y=ratio, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Ratio of Endosymbionts to Free-living Symbionts") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.2, 0.75))  + scale_color_manual(name = "FLS Resources", values=viridis(5), labels = labelForLeg) + scale_x_discrete(labels= labelForX) + ylim(0, 6) 

#4 in x 4 in
ggplot(data=symbiont_final, aes(x=HR, y=symHostedDonate, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Endosymbiont Interaction Value") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), legend.position = c(0.2, 0.75))  + scale_color_manual(name = "FLS Resources", values=viridis(5), drop=FALSE, labels = labelForLeg) +ylim(-1,1) + scale_x_discrete(labels= labelForX)
 



#Yes 


View(symbiont_final)

sub <- subset(symbiont_final, HR == "HR500" & SR =="SR100")
View(sub)
m<- mean(sub$symHostedDonate)#comput wilcoxon tests for this. 
m
ggplot(data=symbiont_final, aes(x=HR, y=symFreeDonate, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Free Symbiont Interaction Value") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\nper update", values=viridis(4)) + ylim(-1,1)

#Attempt at violin plots but they look terrible
ggplot(data=symbiont_final, aes(x=HR, y=symHostedCount, color=SR)) + geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  +  ylab("Final Count of Hosted Symbionts") + xlab("Treatment")

