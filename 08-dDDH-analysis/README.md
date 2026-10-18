## 08. dDDH analysis

dDDH analysis was calculated using the Type (Strain) Genome Server (TYGS)(https://tygs.dsmz.de) inputting a subset of 7 genomes, resulting in `dDDH-output.csv`, all 7 genomes had dDDH d4 well under 70% against all 6 other genomes strongly indicating that they are each different species.: 



| Query strain | Subject strain | dDDH (d0, in %) | C.I. (d0, in %) | dDDH (d4, in %) | C.I. (d4, in %) | dDDH (d6, in %) | C.I. (d6, in %) | G+C content difference (in %) |
|---|---|---|---|---|---|---|---|---|
| JM503A | Parvimonas_micra_GCF_900637905 | 71.0 | [67.0 - 74.6] | 44.0 | [41.4 - 46.5] | 66.0 | [62.6 - 69.2] | 0.59 |
| JM503A | Parvimonas_sp__JM503A11_GCF_062004069 | 71.3 | [67.3 - 74.9] | 43.1 | [40.6 - 45.6] | 65.9 | [62.5 - 69.1] | 0.06 |
| Parvimonas_micra_GCF_900637905 | Parvimonas_sp__JM503A11_GCF_062004069 | 67.6 | [63.7 - 71.2] | 42.3 | [39.8 - 44.8] | 62.7 | [59.3 - 65.9] | 0.53 |
| Parvimonas_micra_GCF_900637905 | Parvimonas_oralis_GCF_977017665 | 71.0 | [67.1 - 74.7] | 42.1 | [39.6 - 44.6] | 65.3 | [61.9 - 68.5] | 0.42 |
| Parvimonas_oralis_GCF_977017665 | Parvimonas_sp__JM503A11_GCF_062004069 | 64.1 | [60.3 - 67.7] | 38.7 | [36.3 - 41.3] | 58.5 | [55.2 - 61.6] | 0.11 |
| JM503A | Parvimonas_oralis_GCF_977017665 | 72.4 | [68.5 - 76.1] | 38.6 | [36.2 - 41.2] | 64.8 | [61.5 - 68.1] | 0.18 |
| Parvimonas_oralis_GCF_977017665 | Parvimonas_pharyngis_GCF_050262165 | 62.6 | [58.8 - 66.2] | 31.2 | [28.8 - 33.7] | 53.7 | [50.6 - 56.8] | 0.1 |
| Parvimonas_micra_GCF_900637905 | Parvimonas_pharyngis_GCF_050262165 | 55.9 | [52.3 - 59.4] | 30.7 | [28.3 - 33.2] | 48.7 | [45.7 - 51.7] | 0.32 |
| Parvimonas_oralis_GCF_977017665 | Parvimonas_parva_GCF_045866535 | 50.0 | [46.6 - 53.4] | 30.5 | [28.1 - 33.0] | 44.4 | [41.4 - 47.4] | 0.61 |
| Parvimonas_pharyngis_GCF_050262165 | Parvimonas_sp__JM503A11_GCF_062004069 | 53.8 | [50.3 - 57.2] | 30.5 | [28.1 - 33.0] | 47.1 | [44.1 - 50.1] | 0.21 |
| JM503A | Parvimonas_pharyngis_GCF_050262165 | 63.1 | [59.4 - 66.7] | 30.5 | [28.2 - 33.1] | 53.7 | [50.6 - 56.8] | 0.27 |
| Parvimonas_micra_GCF_900637905 | Parvimonas_parva_GCF_045866535 | 44.5 | [41.2 - 48.0] | 30.3 | [28.0 - 32.8] | 40.3 | [37.3 - 43.3] | 0.19 |
| Parvimonas_parva_GCF_045866535 | Parvimonas_sp__JM503A11_GCF_062004069 | 43.1 | [39.7 - 46.5] | 30.2 | [27.8 - 32.7] | 39.2 | [36.2 - 42.2] | 0.72 |
| JM503A | Parvimonas_parva_GCF_045866535 | 46.6 | [43.2 - 50.1] | 29.9 | [27.5 - 32.4] | 41.7 | [38.7 - 44.7] | 0.78 |
| Parvimonas_parva_GCF_045866535 | Parvimonas_pharyngis_GCF_050262165 | 43.6 | [40.2 - 47.0] | 27.8 | [25.4 - 30.3] | 38.6 | [35.7 - 41.7] | 0.51 |
| Finegoldia magna | Parvimonas_parva_GCF_045866535 | 13.0 | [10.3 - 16.3] | 26.0 | [23.6 - 28.4] | 13.4 | [11.0 - 16.2] | 3.39 |
| Finegoldia magna | Parvimonas_sp__JM503A11_GCF_062004069 | 12.8 | [10.1 - 16.1] | 24.1 | [21.8 - 26.6] | 13.2 | [10.9 - 16.0] | 4.11 |
| Finegoldia magna | JM503A | 12.9 | [10.2 - 16.1] | 23.0 | [20.7 - 25.5] | 13.2 | [10.9 - 16.0] | 4.17 |
| Finegoldia magna | Parvimonas_pharyngis_GCF_050262165 | 12.9 | [10.2 - 16.2] | 21.1 | [18.9 - 23.6] | 13.3 | [11.0 - 16.1] | 3.9 |
| Finegoldia magna | Parvimonas_oralis_GCF_977017665 | 13.0 | [10.3 - 16.3] | 20.0 | [17.7 - 22.4] | 13.4 | [11.0 - 16.1] | 4.0 |
| Finegoldia magna | Parvimonas_micra_GCF_900637905 | 13.0 | [10.3 - 16.3] | 19.7 | [17.5 - 22.1] | 13.4 | [11.0 - 16.1] | 3.58 |


