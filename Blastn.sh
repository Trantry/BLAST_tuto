#!/bin/bash
#SBATCH --array=1-6
#SBATCH --job-name=Blastx
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=00-01:00:00
#SBATCH --partition=Cascade,Genoa-premium,Emerald-premium
#SBATCH --output=/home/tbessonn/stdout/%x_%A_%a.out
#SBATCH --error=/home/tbessonn/stderr/%x_%A_%a.err

#Set your variables her
WORKDIR=path_to_your_workdir
GENOME=path_to_your_genome

#Make your DB (In the genome is better for blast tiny sequences)
#executed this command one time after add a # to the makeblastdb
makeblastdb -in $GENOME -dbtype nucl

mkdir -p $WORKDIR/BLAST
cd $WORKDIR/BLAST

 blastn -query /home/tbessonn/blast_white/guide_white.fasta \
        -db $GENOME \
        -out $WORKDIR/BLAST/Blast.outfmt6 \
        -evalue 1e-3 \
        -word_size 23 \
        -perc_identity 80 \
        -outfmt 6 \
        -num_threads 8 \

#-word_size it's the size of your sequences
#-query it's your sequnces_file.fasta (like your geisha CRISPR)
#-db is the thing you put in the makeblast -in THING

#For searching the sequences in the genome :
#samtools faidx $Geno Scmw4ez_472:15365203-15557205
