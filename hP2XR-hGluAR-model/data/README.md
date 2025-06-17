# Data for gHH Model: Human P2X<sub>1–7</sub> and GluA1 Receptor Currents

This folder contains all digitised current traces and experimental datasets used in the development and validation of the **generalised Hodgkin–Huxley (gHH) model** for human P2X and AMPA (GluA1) receptors.  
All data were extracted from published figures in primary experimental papers using **WebPlotDigitizer** (https://automeris.io/WebPlotDigitizer).  
Each file is formatted for direct use in the model fitting and simulation scripts provided in this repository.

---

## File Format

All data files are plain text files (`.dat`), each containing two columns:
- **Column 1:** Time (s or ms)
- **Column 2:** Current (μA or nA for P2X; pA for GluA1—see individual file notes)

Values are comma or tab-delimited as indicated per file.

---

## Dataset Inventory & Units

Below, each dataset is listed with its units and the corresponding experimental reference:

### **P2X1 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x1-0.1uM.dat`           | s        | μA           | hP2X1, ATP = 0.1 μM                    |
| `hp2x1-0.3uM.dat`           | s        | μA           | hP2X1, ATP = 0.3 μM                    |
| `hp2x1-1uM.dat`             | s        | μA           | hP2X1, ATP = 1 μM                      |
| `hp2x1-3uM.dat`             | s        | μA           | hP2X1, ATP = 3 μM                      |
| `hp2x1-100uM.dat`           | s        | μA           | hP2X1, ATP = 100 μM                    |

### **P2X2 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x2-3uM.dat`             | s        | μA           | hP2X2, ATP = 3 μM                      |
| `hp2x2-10uM.dat`            | s        | μA           | hP2X2, ATP = 10 μM                     |
| `hp2x2-30uM.dat`            | s        | μA           | hP2X2, ATP = 30 μM                     |
| `hp2x2-100uM.dat`           | s        | μA           | hP2X2, ATP = 100 μM                    |
| `hp2x2-300uM.dat`           | s        | μA           | hP2X2, ATP = 300 μM                    |

### **P2X3 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x3-0.1uM.dat`           | s        | nA           | hP2X3, ATP = 0.1 μM                    |
| `hp2x3-0.3uM.dat`           | s        | nA           | hP2X3, ATP = 0.3 μM                    |
| `hp2x3-1uM.dat`             | s        | nA           | hP2X3, ATP = 1 μM                      |
| `hp2x3-3uM.dat`             | s        | nA           | hP2X3, ATP = 3 μM                      |
| `hp2x3-30uM.dat`            | s        | nA           | hP2X3, ATP = 30 μM                      |
| `hp2x3-100uM.dat`           | s        | nA           | hP2X3, ATP = 100 μM                    |

### **P2X4 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x4-0.5uM.dat`           | s        | μA           | hP2X4, ATP = 0.5 μM                    |
| `hp2x4-1uM.dat`             | s        | μA           | hP2X4, ATP = 1 μM                      |
| `hp2x4-5uM.dat`             | s        | μA           | hP2X4, ATP = 5 μM                      |
| `hp2x4-10uM.dat`            | s        | μA           | hP2X4, ATP = 10 μM                     |
| `hp2x4-50uM.dat`            | s        | μA           | hP2X4, ATP = 50 μM                     |
| `hp2x4-100uM.dat`           | s        | μA           | hP2X4, ATP = 100 μM                    |
| `hp2x4-500uM.dat`           | s        | μA           | hP2X4, ATP = 500 μM                    |

### **P2X5 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x5-1uM.dat`             | s        | nA           | hP2X5, ATP = 1 μM                      |
| `hp2x5-3uM.dat`             | s        | nA           | hP2X5, ATP = 3 μM                      |
| `hp2x5-10uM.dat`            | s        | nA           | hP2X5, ATP = 10 μM                     |
| `hp2x5-30uM.dat`            | s        | nA           | hP2X5, ATP = 30 μM                     |
| `hp2x5-100uM.dat`           | s        | nA           | hP2X5, ATP = 100 μM                    |

### **P2X6 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x6-30uM.dat`           | s        | nA           | hP2X6, ATP = 100 μM                    |

### **P2X7 Receptor**
| File                        | Time Unit | Current Unit | Notes / ATP Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hp2x7-0.01mM.dat`          | s        | nA           | hP2X7, ATP = 0.01 mM                   |
| `hp2x7-0.1mM.dat`           | s        | nA           | hP2X7, ATP = 0.1 mM                    |
| `hp2x7-1mM.dat`             | s        | nA           | hP2X7, ATP = 1 mM                      |
| `hp2x7-3mM.dat`             | s        | nA           | hP2X7, ATP = 3 mM                      |
| `hp2x7-5mM.dat`             | s        | nA           | hP2X7, ATP = 5 mM                      |
| `hp2x7-10mM.dat`            | s        | nA           | hP2X7, ATP = 10 mM                     |

### **GluA1 (AMPA) Receptor**
| File                        | Time Unit | Current Unit | Notes / Glu Concentrations              |
|-----------------------------|-----------|--------------|-----------------------------------------|
| `hglua1-0.1mM.dat`          | ms        | pA           | hGluA1, Glu = 0.1 mM                    |
| `hglua1-1mM.dat`            | ms        | pA           | hGluA1, Glu = 1 mM                      |
| `hglua1-10mM.dat`           | ms        | pA           | hGluA1, Glu = 10 mM                     |

---

## References

See the main manuscript for primary references corresponding to each experimental data source.  
All data are for research and reproducibility purposes only.

---

*Last updated: June 2025*

