library("mothuR")

#pdf("chao_r.pdf")
rarePlot("stability.opti_mcc.groups.r_chao",groups,ylab= "Number of Different OTUs",xlab= "Number of Tags Sampled",
         pch= NA, xlim = NULL, ylim = NULL, error=FALSE, delNum=6)
#dev.off()
