# Parvimonas pangenome: workflow and analysis notes

Companion repository for the *Parvimonas* pangenome manuscript (jonbakerlab/parvimonas-pangenome). This document describes how the genome set was assembled, how the pangenome was built, and how the downstream analyses were performed.

## Overview
Each analysis step is documented in its own folder, alongside its associated data files:

1. [Genome retrieval and curation](01-genome-retrieval/)
2. [Metadata](02-metadata/)
3. [Pangenome construction (anvi'o)](03-pangenome/)
4. [Filtering metadata and genome lists](04-filtering/)
5. [16S rRNA analysis](05-16S-rRNA/)
6. [ANI clustermap](06-ANI-clustermap/)
7. [Core genes phylogeny](07-core-genes-phylogeny/)
8. [dDDH analysis](08-dDDH-analysis/)
9. [GTDB-Tk analysis](09-GTDB-Tk-analysis/)

## Software

| Tool | Used for | Version |
|---|---|---|
| ncbi-genome-download | Genome download | 0.3.3 |
| NCBI `datasets` / `dataformat` | Assembly metadata | 18.15.0 |
| anvi'o (`anvio-dev` env) | Pangenomics workflow, 16S HMM extraction | active codebase |
| MUSCLE (>=5,<6) | Alignment inside `anvi-pan-genome` | 5.3.linux64 |
| R (readxl, dplyr, tidyr) | Metadata pivot table | 4.3.3 |
| FAMSA (via `pyfamsa` 0.7.0) | 16S alignment | 0.7.0 (pyfamsa) |
| IQ-TREE | 16S maximum-likelihood tree | 2.3.6 |
| Python (Biopython, pandas, scipy, matplotlib) | ANI clustermap | 3.10.14 |
| SLURM (OHSU ARC) | compute cluster management | n/a |
| GTDB-TK | GTDB placement | 2.8.0 |
| GTDB | GTDB placement | release 232 | 
| pyani| ANI calculation | 0.2.12 |

