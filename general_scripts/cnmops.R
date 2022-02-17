if (!requireNamespace("BiocManager", quietly = TRUE))
install.packages("BiocManager")
#BiocManager::install("cn.mops")
#BiocManager::install("DNAcopy")

library(cn.mops)
library(DNAcopy)

BAMFiles<-c("/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-006-2/L-006-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-012-3/L-012-3_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-014-2/L-014-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-029-2/L-029-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-031-2/L-031-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-038-3/L-038-3_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-042/L-042_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-052/L-052_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-059-4/L-059-4_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-068-3/L-068-3_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-070/L-070_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-076/L-076_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-077/L-077_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-081-3/L-081-3_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-083/L-083_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-089-2/L-089-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-091-2/L-091-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-094/L-094_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-095-10/L-095-10_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-098-2/L-098-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-102/L-102_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-108-3/L-108-3_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-111/L-111_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-115/L-115_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-116/L-116_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-117-2/L-117-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-118/L-118_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-119/L-119_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-122/L-122_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-124/L-124_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-126-2/L-126-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-127-2/L-127-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-128/L-128_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-129/L-129_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-140/L-140_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-141-2/L-141-2_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-142/L-142_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-143/L-143_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-144/L-144_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-147/L-147_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-148/L-148_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-149/L-149_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-150/L-150_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-151/L-151_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-154/L-154_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-155/L-155_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-158/L-158_recal_reads.bam")

#	     "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0033/0033_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0152/0152_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0213/0213_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0270/0270_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0308/0308_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0372/0372_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0572/0572_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0596/0596_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0611/0611_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0637/0637_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0643/0643_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0807/0807_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/0850/0850_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/1083/1083_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/1202/1202_recal_reads.bam",
#            "/home/jperez/pruebapipe/JordiD/results/pipeline/MCI/1209/1209_recal_reads.bam",

controlBAMFiles<-c("/home/jperez/pruebapipe/JordiD/results/pipeline/control/0039/0039_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0069/0069_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0104/0104_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0115-6/0115-6_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0155/0155_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0180/0180_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0202/0202_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0217/0217_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0259/0259_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0276/0276_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0477/0477_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0538/0538_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0552/0552_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0591/0591_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0606-6/0606-6_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0638/0638_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0732/0732_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0771/0771_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0870/0870_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0925/0925_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/0982/0982_recal_reads.bam",
            "/home/jperez/pruebapipe/JordiD/results/pipeline/control/1048/1048_recal_reads.bam")

segments <- read.table("/home/jperez/ref/JordiD/Exome_V6.bed",
                       sep="\t",as.is=TRUE)
gr<-GRanges(segments[,1],IRanges(segments[,2],segments[,3]))
samples<-getSegmentReadCountsFromBAM(BAMFiles,GR=gr)
controls<-getSegmentReadCountsFromBAM(controlBAMFiles,GR=gr)

###Case-control
resRef<-referencecn.mops(samples, controls)
resRef <- calcIntegerCopyNumbers(resRef)
CNVs<-as.data.frame(cnvs(resRef))
CNVRegions <- as.data.frame(cnvr(resRef))
write.csv(CNVs,file="/home/jperez/pruebapipe/JordiD/results/pipeline/cnv/cnmops/case_control_cnvs.csv")
write.csv(CNVRegions,file="/home/jperez/pruebapipe/JordiD/results/pipeline/cnv/cnmops/case_control_regions.csv")

### Exome
#resCNMOPS<-exomecn.mops(X)
#resCNMOPS<-calcIntegerCopyNumbers(resCNMOPS)
#CNVs<-as.data.frame(cnvs(resCNMOPS))
#CNVRegions <- as.data.frame(cnvr(resCNMOPS))
#write.csv(CNVs,file="/home/jperez/pruebapipe/JordiD/results/pipeline/cnv/cnmops/cnmopsAD_cnvs.csv")
#write.csv(CNVRegions,file="/home/jperez/pruebapipe/JordiD/results/pipeline/cnv/cnmops/cnmopsAD_regions.csv")

