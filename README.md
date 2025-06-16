# gHH: Generalised Hodgkin–Huxley Model

This is a home page regarding the MATLAB source codes for a novel generalised Hodgkin–Huxley (gHH) model for human P2X<sub>1-7<sub> and GluA1 receptors

This respiratory has two models as follows.

## 1. gHH Model for Human P2X and Glu Receptors
It develops a new IP<sub>3</sub>R (IP<sub>3</sub> receptor) model along with a complete biophysical model to capture human microglial Ca<sup>2+</sup> data from activation of P2Y<sub>12</sub> receptor to Ca<sup>2+</sup> release from intracellular stores consisting of SERCA and Ca<sup>2+</sup> leak channel.

This model has several files, among the most important of which are explained below:

1. The experimental data used can be found under the directory _hP2XR-hGluAR-model/data_.
2. The differntial equations for the model resides in the file _hP2XR-hGluAR-model/ode_gHH.m_.
3. The receptor currents are implemented as a function in the file _hP2XR-hGluAR-model/total_gHH_current.m_.
4. The fitting process which includes a mathematical optimisation procedure can be found in the file _hP2XR-hGluAR-model/main_gHH_fit.m_.
5. The model predictions are implemented in the file _hP2XR-hGluAR-model/perform_final_simulations.m_.
