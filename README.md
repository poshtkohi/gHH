# gHH: Generalised Hodgkin–Huxley Model for Human P2X and Glu Receptors

This is a home page regarding the MATLAB source codes for a novel generalised Hodgkin–Huxley (gHH) model for human P2X<sub>1-7<sub> and GluA1 receptors

This respiratory has two models as follows.

## 1. P2Y<sub>12</sub> Model
It develops a new IP<sub>3</sub>R (IP<sub>3</sub> receptor) model along with a complete biophysical model to capture human microglial Ca<sup>2+</sup> data from activation of P2Y<sub>12</sub> receptor to Ca<sup>2+</sup> release from intracellular stores consisting of SERCA and Ca<sup>2+</sup> leak channel.

This model has several files, among the most important of which are explained below:

1. The experimental data used can be found under the directory _hP2XR-hGluAR-model/data_.
2. The reaction network for P2Y and IP3R models resides in the file _reaction_network_hp2y12.m_.
3. SECRA, IP3R and leak currents are implemented as three separate functions in the files _secra_current.m_, _ip3r_current.m_ and _leak_current.m_.
4. The fitting process which includes a mathematical optimisation function using an evolutionary strategy for numerical simulation of the model differential equations can be found in several files including _cmaes.m_, _fhngen_hp2y12_fit.m_, _loss_function.m_ and _main_hp2y12_fit.m_.
5. The model predictions are implemented in the file _hp2y12_cai_prediction.m_.
