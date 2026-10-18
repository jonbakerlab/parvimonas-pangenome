# Parvimonas pangenome: workflow and analysis notes

Companion repository for the *Parvimonas* pangenome manuscript (jonbakerlab/parvimonas-pangenome). This document describes how the genome set was assembled, how the pangenome was built, and how the downstream analyses were performed.

> Items marked **TODO** need to be filled in by the authors (versions, parameters, citations).

## Overview
Each analysis step is documented in its own folder, alongside its associated data files:

1. [Genome retrieval and curation](01-genome-retrieval/)
2. [Metadata](02-metadata/README.md)
3. [Pangenome construction (anvi'o)](03-pangenome/README.md)
4. [Filtering metadata and genome lists](04-filtering/README.md)
5. [16S rRNA analysis](05-16S-rRNA/README.md)
6. [ANI clustermap](06-ANI-clustermap/README.md)
7. [Core genes phylogeny](07-core-genes-phylogeny/README.md)
8. [dDDH analysis](08-dDDH-analysis/README.md)
9. [GTDB-Tk analysis](09-GTDB-Tk-analysis/README.md)

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
| SLURM (OHSU ARC) | Pangenome compute | n/a |

## Section documentation



## Repository contents

| File | Description |
|---|---|
| `october-scripts.sh` | Original command log |
| `external-genomes.txt`, `external-genomes-complete.txt` | anvi'o external genomes (all 142; the 25 complete) |
| `parvimonas-metadata.txt`, `parvimonas-metadata-filtered.txt` | NCBI metadata (full; filtered with names) |
| `16S_*` files | 16S extraction, alignments, and summaries |
| `ani-output/` | ANIb tables and trees |
| `make_ani_clustermap.py`, `parvimonas_ANI_clustermap.pdf` | ANI clustermap script and figure |

Data files and scripts listed above belong with the section folders (`01-genome-retrieval/` to `09-GTDB-Tk-analysis/`) that describe them; file names in the section notes are relative to the project root unless otherwise stated.
