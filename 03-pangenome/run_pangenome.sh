#!/bin/bash

#SBATCH --job-name=parvimonas_pan
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=12G
#SBATCH --time=18:00:00
#SBATCH --export=ALL
#SBATCH --output=parvimonas_pan_%j.out
#SBATCH --error=parvimonas_pan_%j.err

absolute_path="/home/exacloud/gscratch/BakerLab/parvimonas/pangenome"
env_path="/home/exacloud/gscratch/BakerLab/miniforge3/envs/"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

source "/home/exacloud/gscratch/BakerLab/miniforge3/etc/profile.d/conda.sh"
conda activate "${env_path}/anvio-dev"


srun anvi-pan-genome \
-g 03_PAN/parvimonas-pangenome-GENOMES.db \
--num-threads $SLURM_CPUS_PER_TASK \
-o 03_PAN/parvimonas-pangenome-PAN.db \
--project-name parvimonas-pangenome \
--I-know-this-is-not-a-good-idea \
--mcl-inflation 4
