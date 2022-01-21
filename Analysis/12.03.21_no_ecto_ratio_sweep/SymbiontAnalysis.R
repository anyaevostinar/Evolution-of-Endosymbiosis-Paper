require(ggplot2)

install.packages("viridis")
library(viridis)

initial_data <- read.table("munged_sym_average.dat", h=T)
symbiont_final <-subset(initial_data, update ==100000)

symbiont_final$HR <- factor(symbiont_final$HR, levels=c("HR10", "HR50", "HR100", "HR500", "HR1000"))
symbiont_final$SR <- factor(symbiont_final$SR, levels=c("SR10", "SR50", "SR100", "SR500", "SR1000"))


ggplot(data=initial_data, aes(x=update, y=symHostedCount, group=HR, colour=HR)) + labs(title=("Ratio of resources received by host (HR) versus free-living symbionts (SR)")) + ylab("Count of Endosymbionts") + xlab("Updates") + stat_summary(aes(color=HR, fill=HR),fun.data="mean_cl_boot", geom=c("smooth"), se=TRUE) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill="none") +scale_colour_manual(name="Host Resources",values=viridis(5)) + scale_fill_manual(values=viridis(5)) + facet_wrap(~SR)


ggplot(data=symbiont_final, aes(x=HR, y=symHostedCount, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Endosymbiont Count") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\nper update", values=viridis(5))

ggplot(data=symbiont_final, aes(x=HR, y=symFreeCount, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Free Symbiont Count") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\n per update", values=viridis(5))


ggplot(data=symbiont_final, aes(x=HR, y=symHostedCount/symFreeCount, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Ratio of Endosymbionts to Free-living Symbionts") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\nper update", values=viridis(5)) + ylim(0,5)

ggplot(data=symbiont_final, aes(x=HR, y=symHostedDonate, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Endosymbiont Interaction Value") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\nper update", values=viridis(5)) +ylim(-1,1)

ggplot(data=symbiont_final, aes(x=HR, y=symFreeDonate, color=SR)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Free Symbiont Interaction Value") + xlab("Resources per Host per Update") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  + scale_color_manual(name = "Free-living Symbiont \nresources per symbiont\nper update", values=viridis(4)) + ylim(-1,1)

#Attempt at violin plots but they look terrible
ggplot(data=symbiont_final, aes(x=HR, y=symHostedCount, color=SR)) + geom_violin(draw_quantiles = c(0.25, 0.5, 0.75)) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())  +  ylab("Final Count of Hosted Symbionts") + xlab("Treatment")

