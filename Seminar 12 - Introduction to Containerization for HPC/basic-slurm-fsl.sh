#!/bin/bash

#SBATCH --job-name=fsl_job
#SBATCH --partition=free
#SBATCH --time=01:00:00
#SBATCH --cpus-per-task=1
#SBATCH --output=fsl_%j.out
#SBATCH --error=fsl_%j.err

# Load Apptainer
module load apptainer

# Run FSL command (example: brain extraction)
apptainer exec /path/to/fsl.sif bet input.nii.gz output.nii.gz
