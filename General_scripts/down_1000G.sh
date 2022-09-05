#!/bin/sh
#SBATCH --job-name="down"

for i in `cat /home/jperez/ref/samples_1000G.sh`; do
	wget ${i} -P /home/jperez/ref/1000G; done

