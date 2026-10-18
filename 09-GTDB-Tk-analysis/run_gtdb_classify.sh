#!/bin/bash

#SBATCH --job-name=gtdbtk-classify
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem-per-cpu=12G
#SBATCH --time=18:00:00
#SBATCH --export=ALL
#SBATCH --output=gtdbtk_classify_%j.out
#SBATCH --error=gtdbtk_classify_%j.err

absolute_path="/home/groups/BakerLab/gscratch/parvimonas/pangenome"
env_path="/home/exacloud/gscratch/BakerLab/miniforge3/envs/"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

source "/home/exacloud/gscratch/BakerLab/miniforge3/etc/profile.d/conda.sh"
conda activate "${env_path}/gtdbtk-2.8.0_env"


srun gtdbtk classify_wf \
--genome_dir other-genomes \
--out_dir gtdbtk_classify_output \
--cpus $SLURM_CPUS_PER_TASK
