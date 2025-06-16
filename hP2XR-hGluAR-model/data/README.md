# Data for gHH Model: Human P2X<sub>1–7</sub> and GluA1 Receptor Currents

This folder contains all digitised current traces and experimental datasets used in the development and validation of the **generalised Hodgkin–Huxley (gHH) model** for human P2X and AMPA (GluA1) receptors.  
All data were extracted from published figures in primary experimental papers using **WebPlotDigitizer** (https://automeris.io/WebPlotDigitizer).  
Each file is formatted for direct use in the model fitting and simulation scripts provided in this repository.

---

## File Format

All data files are plain text files (`.dat`), each containing two columns:
- **Column 1:** Time (ms)
- **Column 2:** Current (nA for most P2X; pA for GluA1—see individual file notes)

Values are comma or tab-delimited as indicated per file.

---

## Dataset Inventory & Units

Below, each dataset is listed with its units and the corresponding experimental reference:

### **P2X1 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x1_0.1uM.dat`           | s        | μA           | hP2X1, ATP = 0.1 μM                    |
| `hp2x1_0.3uM.dat`           | s        | μA           | hP2X1, ATP = 0.3 μM                    |
| `hp2x1_1uM.dat`             | s        | μA           | hP2X1, ATP = 1 μM                      |
| `hp2x1_10uM.dat`            | s        | μA           | hP2X1, ATP = 10 μM                     |
| `hp2x1_100uM.dat`           | s        | μA           | hP2X1, ATP = 100 μM                    |

### **P2X2 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x2_3uM.dat`             | s        | μA           | hP2X2, ATP = 3 μM                      |
| `hp2x2_10uM.dat`            | s        | μA           | hP2X2, ATP = 10 μM                     |
| `hp2x2_30uM.dat`            | s        | μA           | hP2X2, ATP = 30 μM                     |
| `hp2x2_100uM.dat`           | s        | μA           | hP2X2, ATP = 100 μM                    |
| `hp2x2_300uM.dat`           | s        | μA           | hP2X2, ATP = 300 μM                    |

### **P2X3 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x3_0.1uM.dat`           | s        | nA           | hP2X3, ATP = 0.1 μM                    |
| `hp2x3_0.3uM.dat`           | s        | nA           | hP2X3, ATP = 0.3 μM                    |
| `hp2x3_1uM.dat`             | s        | nA           | hP2X3, ATP = 1 μM                      |
| `hp2x3_3uM.dat`             | s        | nA           | hP2X3, ATP = 3 μM                      |
| `hp2x3_100uM.dat`           | s        | nA           | hP2X3, ATP = 100 μM                    |

### **P2X4 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x4_0.3uM.dat`           | s        | μA           | hP2X4, ATP = 0.3 μM                    |
| `hp2x4_1uM.dat`             | s        | μA           | hP2X4, ATP = 1 μM                      |
| `hp2x4_3uM.dat`             | s        | μA           | hP2X4, ATP = 3 μM                      |
| `hp2x4_10uM.dat`            | s        | μA           | hP2X4, ATP = 10 μM                     |
| `hp2x4_30uM.dat`            | s        | μA           | hP2X4, ATP = 30 μM                     |
| `hp2x4_100uM.dat`           | s        | μA           | hP2X4, ATP = 100 μM                    |

### **P2X5 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x5_1uM.dat`             | s        | nA           | hP2X5, ATP = 1 μM                      |
| `hp2x5_3uM.dat`             | s        | nA           | hP2X5, ATP = 3 μM                      |
| `hp2x5_10uM.dat`            | s        | nA           | hP2X5, ATP = 10 μM                     |
| `hp2x5_30uM.dat`            | s        | nA           | hP2X5, ATP = 30 μM                     |
| `hp2x5_100uM.dat`           | s        | nA           | hP2X5, ATP = 100 μM                    |

### **P2X6 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x6_100uM.dat`           | ms        | nA           | hP2X6, ATP = 100 μM                    |

### **P2X7 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x7_0.01mM.dat`          | s        | nA           | hP2X7, ATP = 0.01 mM                   |
| `hp2x7_0.03mM.dat`          | s        | nA           | hP2X7, ATP = 0.03 mM                   |
| `hp2x7_0.1mM.dat`           | s        | nA           | hP2X7, ATP = 0.1 mM                    |
| `hp2x7_0.3mM.dat`           | s        | nA           | hP2X7, ATP = 0.3 mM                    |
| `hp2x7_1mM.dat`             | s        | nA           | hP2X7, ATP = 1 mM                      |
| `hp2x7_3mM.dat`             | s        | nA           | hP2X7, ATP = 3 mM                      |
| `hp2x7_10mM.dat`            | s        | nA           | hP2X7, ATP = 10 mM                     |

### **GluA1 (AMPA) Receptor**
| File                        | Time Unit | Current Unit | Notes / Glu Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hglua1_0.1mM.dat`          | ms        | pA           | hGluA1, Glu = 0.1 mM                    |
| `hglua1_1mM.dat`            | ms        | pA           | hGluA1, Glu = 1 mM                      |
| `hglua1_10mM.dat`           | ms        | pA           | hGluA1, Glu = 10 mM                     |

---

## References

See the main manuscript for primary references corresponding to each experimental data source.  
All data are for research and reproducibility purposes only.

---

*Last updated: June 2025*

