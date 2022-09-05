#!/bin/bash
#SBATCH --job-name="Excavator"
#SBATCH --mem=40G
#SBATCH --cpus-per-task 4

module load  R/4.0.2-foss-2016b-X11-20160819

export dir=/home/jperez/Jordi/programes/EXCAVATOR2_Package_v1.1.2
export refDir=/home/jperez/ref/JordiD

#cat SourceTarget.txt 
#data/ucsc.hg19.bw /home/gordeeva/human_genome/hs37d5.fa

perl ${dir}/TargetPerla.pl  ${dir}/SourceTarget.txt ${refDir}/Exome_V6.bed  Vallecas 50000 hg38

#PrepareFile.txt Tab-delimited)
#/home/gordeeva/./comparasion_study/exome_data/NA06986.bam    /home/gordeeva/./comparasion_study/calling_tools/excavator/DataPrepare/NA0698    NA06986

#perl ${dir}/EXCAVATORDataPrepare.pl ${dir}/PrepareFile.txt --processors 4 --target Vallecas --assembly hg38

##AnalysisFile.txt Tab-delimited)
##C1 /home/gordeeva/./comparasion_study/calling_tools/excavator/DataPrepare/NA06986    NA06986
##C2 /home/gordeeva/./comparasion_study/calling_tools/excavator/DataPrepare/NA06989    NA06989
##...
##T1 /home/gordeeva/./comparasion_study/calling_tools/excavator/DataPrepare/NA12878    NA12878
#
#perl ${dir}/EXCAVATORDataAnalysis.pl ${dir}/AnalysisFile.txt --processors 4 --target Vallecas --assembly hg38  --output /home/jperez/pruebapipe/JordiD/results/pipeline/cnv/excavator --mode pooling
#
