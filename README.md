
# CDK11 Study — Repository

Code and analysis scripts accompanying the following preprint:

> Julian LA, Crozier L, Lukow D, et al. *On-target toxicity limits the efficacy of CDK11 inhibition against cancers with 1p36 deletions.* bioRxiv. 2025;2025.08.03.668359. Published 2025 Aug 3. doi:[10.1101/2025.08.03.668359](https://doi.org/10.1101/2025.08.03.668359)

## Contents

- **Intron retention**  
  Code and configuration for **Figure 2**: `Figure2/Intron-Retention/config`

- **ChIP-seq analysis**  
  Code and configuration for **Figure S4**: `Supplementary Figs/data/ChIP-seq-FigureS4/config`

- **Biomarker analysis**  
  Code and configuration for **Figure 4**: `Figure4/config`

- **Figure generation**  
  Jupyter notebooks used to generate the manuscript figures.

---

## Dependencies

The analyses were developed and tested with the following software versions:

| Package | Version |
|---------|---------|
| Python | 3.10 |
| pandas | 2.0.3 |
| numpy | 1.23.0 |
| scipy | 1.10.1 |
| matplotlib | 3.7.3 |
| seaborn | 0.11.0 |
| PyYAML | 5.3.1 |
| deepTools | latest compatible version |
| yq | latest compatible version |

---

## PSI-Sigma

Alternative splicing analysis was performed using **PSI-Sigma v2.1**.

PSI-Sigma was executed from a **Singularity container**. Please refer to the [PSI-Sigma GitHub repository](https://github.com/wososa/PSI-Sigma) for instructions on obtaining and running the Singularity image.