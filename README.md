
# CDK11 Study — Repository

Code and analysis scripts accompanying the following preprint:

> Julian LA, Crozier L, Lukow D, et al. *On-target toxicity limits the efficacy of CDK11 inhibition against cancers with 1p36 deletions.* bioRxiv. 2025;2025.08.03.668359. Published 2025 Aug 3. doi:[10.1101/2025.08.03.668359](https://doi.org/10.1101/2025.08.03.668359)

## Contents

- **Intron retention**  
  Analysis code is located in the `Figure2/Intron-Retention/` directory. Configuration files for reproducing **Figure 2** are in `Figure2/Intron-Retention/config`.

- **ChIP-seq analysis**  
  Analysis code is located in `Supplementary Figs/ChIP-seq-FigureS4`. Configuration files for reproducing **Figure S4** are in `Supplementary Figs/ChIP-seq-FigureS4/config`.

- **Biomarker analysis**  
  Analysis code is located in the `Figure4` directory. Configuration files for reproducing **Figure 4** are in `Figure4/config`.

- **Figure generation**  
  Jupyter notebooks used to generate the manuscript figures.
  - `Figure2/Figure2.ipynb`
  - `Figure4/Figure4.ipynb`
  - `Supplementary Figs/FigureSupplemental.ipynb`

- **Data**
  - Data used to generate the figures are available in the `data` subdirectory.
  - Public datasets can be obtained from the **DepMap** portal and **TCGA**.

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