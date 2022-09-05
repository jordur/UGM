#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("exomeCopy")
#BiocManager::install("GenomicRanges")

library(exomeCopy)  
library(GenomicRanges)

target.file <- "/home/jperez/ref/JordiD/Exome_V6.bed"
bam.files <- c("/home/jperez/pruebapipe/JordiD/results/pipeline/AD/L-006-2/L-006-2_recal_reads.bam",
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

sample.names <- c("L-006-2","L-012-3","L-014-2","L-029-2","L-031-2","L-038-3","L-042","L-052","L-059-4","L-068-3","L-070","L-076","L-077","L-081-3","L-083","L-089-2","L-091-2","L-094","L-095-10","L-098-2","L-102","L-108-3","L-111","L-115","L-116","L-117-2","L-118","L-119","L-122","L-124","L-126-2","L-127-2","L-128","L-129","L-140","L-141-2","L-142","L-143","L-144","L-147","L-148","L-149","L-150","L-151","L-154","L-155","L-158")
reference.file <- "/home/jperez/ref/JordiD/Homo_sapiens_assembly38.fasta"

#sample.names<-c("L-006-2","L-012-3")

target.df <- read.delim(target.file, header = FALSE)
target <- GRanges(seqname = target.df[, 1], IRanges(start = target.df[,2] + 1, end = target.df[, 3]))
counts <- target
for (i in 1:length(bam.files)) {
  mcols(counts)[[sample.names[i]]] <- countBamInGRanges(bam.files[i],target)
}
counts$GC <- getGCcontent(target, reference.file)
counts$GC.sq <- counts$GC^2
counts$bg <- generateBackground(sample.names, counts, median)
counts<-counts[counts$bg > 0, ]
counts$log.bg <- log(counts$bg + 0.1)
counts$width <- width(counts)
fit.list <- lapply(sample.names, function(sample.name) {
  lapply(seqlevels(target), function(seq.name) {
    exomeCopy(counts[seqnames(counts) == seq.name],sample.name, X.names = c("log.bg", "GC","GC.sq", "width"), S = 0:4, d = 2)
  })
})
compiled.segments <- compileCopyCountSegments(fit.list)
CNV.segments <- compiled.segments[compiled.segments$copy.count !=2]
CNV.segments <- CNV.segments[CNV.segments$nranges > 5,]
CNV.segments<-as(CNV.segments, "data.frame")
cnv.cols <- c("red", "orange", "black", "deepskyblue","blue")
write.table(CNV.segments,paste0("/home/jperez/pruebapipe/JordiD/results/pipeline/cnv/exomecopy/results_all"),col.names = T,row.names = F,quote = F,sep="\t")

# pdf(file="/home/jperez/pruebapipe/JordiD/results/pipeline/plots/prova.pdf")
# par(mfrow = c(2, 1), mar = c(4, 3, 2, 1))
# plotCompiledCNV(CNV.segments = CNV.segments, seq.name = "chr2",col = cnv.cols)
# dev.off()
