#!/bin/bash

CONFIG_FILE="../../config/config.yaml"

# Load config values using yq
JOB_NAME=$(yq e '.psisigma.job.name' "$CONFIG_FILE")
NTASKS=$(yq e '.psisigma.job.ntasks' "$CONFIG_FILE")
MEM=$(yq e '.psisigma.job.mem' "$CONFIG_FILE")
TIME=$(yq e '.psisigma.job.time' "$CONFIG_FILE")
PARTITION=$(yq e '.psisigma.job.partition' "$CONFIG_FILE")
MAIL_USER=$(yq e '.psisigma.job.mail_user' "$CONFIG_FILE")
MAIL_TYPE=$(yq e '.psisigma.job.mail_type' "$CONFIG_FILE")

MODULE=$(yq e '.psisigma.environment.module' "$CONFIG_FILE")
CONDA_ENV=$(yq e '.psisigma.environment.conda_env' "$CONFIG_FILE")
SINGULARITY_IMAGE=$(yq e '.psisigma.environment.singularity_image' "$CONFIG_FILE")

PERL_PATH=$(yq e '.psisigma.script.perl_path' "$CONFIG_FILE")
GTF=$(yq e '.psisigma.script.gtf' "$CONFIG_FILE")
NREAD=$(yq e '.psisigma.script.nread' "$CONFIG_FILE")
RUN_NAME=$(yq e '.psisigma.script.name' "$CONFIG_FILE")
TYPE=$(yq e '.psisigma.script.type' "$CONFIG_FILE")
THREADS=$(yq e '.psisigma.script.threads' "$CONFIG_FILE")
FMODE=$(yq e '.psisigma.script.fmode' "$CONFIG_FILE")

# Set SLURM headers
#SBATCH --job-name=${JOB_NAME}
#SBATCH --ntasks=${NTASKS}
#SBATCH --mem=${MEM}
#SBATCH --time=${TIME}
#SBATCH --partition=${PARTITION}
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err
#SBATCH --mail-user=${MAIL_USER}
#SBATCH --mail-type=${MAIL_TYPE}

# Load environment
module load ${MODULE}
conda activate ${CONDA_ENV}

# Execute the PSI-Sigma script
singularity exec --bind /mnt:/mnt ${SINGULARITY_IMAGE} perl ${PERL_PATH} \
  --gtf ${GTF} \
  --nread ${NREAD} \
  --name ${RUN_NAME} \
  --type ${TYPE} \
  --threads ${THREADS} \
  --fmode ${FMODE}
