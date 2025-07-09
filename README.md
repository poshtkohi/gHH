# gHH: Generalised Hodgkin–Huxley Model

Welcome to the repository for the **generalised Hodgkin–Huxley (gHH) model** for human P2X<sub>1–7</sub> and GluA1 receptors, as described in our manuscript under review at *The Journal of Physiology*. This repository provides all MATLAB source code, simulation files, and example datasets used in our study.

---

## About the Model

The **gHH model** is a generalisation of the classic Hodgkin–Huxley framework, specifically designed to model ligand-gated ionotropic receptors such as human P2X<sub>1–7</sub> and AMPA-type GluA1 receptors.  
- The model features two activation and two inactivation gates, enabling the accurate reproduction of complex gating kinetics, including activation, desensitisation, and recovery.  
- Five distinct current formulations are implemented to allow receptor-specific flexibility in modelling.  
- The approach supports robust parameter fitting to experimental current recordings, facilitating mechanistic insights and quantitative predictions across a wide range of physiological conditions.

---

## Repository Structure

- **`hP2XR-hGluAR-model/data/`**  
  Contains all experimental data files used for model fitting. See the folder README for details on file contents and units.
- **`hP2XR-hGluAR-model/ode_gHH.m`**  
  Defines the system of differential equations for the generalised HH model.
- **`hP2XR-hGluAR-model/total_gHH_current.m`**  
  Implements the receptor current calculation using the gating variables.
- **`hP2XR-hGluAR-model/main_gHH_fit.m`**  
  Main entry point for fitting model parameters to data.
- **`hP2XR-hGluAR-model/model_fitting_configurations.m`**  
  Contains configuration options for the fitting routines.
- **`hP2XR-hGluAR-model/perform_final_simulations.m`**  
  Runs simulations and generates figures using optimised parameters.

---

## Getting Started

1. **Clone or download** this repository.
2. Make sure you have **MATLAB** installed (tested on R2024b).
3. Add the project folders to your MATLAB path.
4. To fit the model to data, run:  
   `main_gHH_fit.m`
5. To simulate or visualise results using fitted parameters, run:  
   `perform_final_simulations.m`
6. For details on data files, see the README in the `hP2XR-hGluAR-model/data` directory.

---

## Data Provenance

- All datasets were extracted from published experimental studies, as referenced in our manuscript.
- Extraction methods and file details are described in `hP2XR-hGluAR-model/data/README.md`.

---

