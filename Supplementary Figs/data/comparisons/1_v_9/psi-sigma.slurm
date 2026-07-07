#!/bin/bash
#SBATCH --job-name=PSI-Sigma   # Job name
#SBATCH --ntasks=8             # Run on a single CPU
#SBATCH --mem=48G              # Job memory request
#SBATCH --time=5:00:00         # Time limit days-hrs:min:sec
#SBATCH --partition=day        # Submit to the week-long queue
#SBATCH --output=%x.%j.out     # Standard output log
#SBATCH --error=%x.%j.err      # Standard error log
#SBATCH --mail-user=ryan.hagenson@yale.edu
#SBATCH --mail-type=ALL

module load miniconda
conda activate PSI-Sigma

singularity exec \
  --bind /mnt:/mnt docker://woodydon/psi_sigma_pipeline:3.9 perl /usr/local/bin/PSI-Sigma-2.1/dummyai.pl \
  --gtf ../genome.gtf \
  --nread 10 \
  --name 1_v_9 \
  --type 2 \
  --threads 8 \
  --fmode 3

