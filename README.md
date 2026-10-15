# Parvimonas pangenome: workflow and analysis notes

Companion repository for the *Parvimonas* pangenome manuscript (jonbakerlab/parvimonas-pangenome). This document describes how the genome set was assembled, how the pangenome was built, and how the downstream 16S rRNA and ANI analyses were produced. The original command log is in `october-scripts.sh`.

> Items marked **TODO** need to be filled in by the authors (versions, parameters, citations).

## Overview

1. Genome retrieval and curation (NCBI RefSeq and GenBank)
2. Metadata retrieval and formatting
3. Pangenome construction with anvi'o
4. Metadata and genome-list filtering
5. 16S rRNA extraction and phylogeny
6. ANI clustermap

## Software

| Tool | Used for | Version |
|---|---|---|
| ncbi-genome-download | Genome download | TODO |
| NCBI `datasets` / `dataformat` | Assembly metadata | TODO |
| anvi'o (`anvio-dev` env) | Pangenomics workflow, 16S HMM extraction | TODO |
| MUSCLE (>=5,<6) | Alignment inside `anvi-pan-genome` | TODO |
| R (readxl, dplyr, tidyr) | Metadata pivot table | TODO |
| FAMSA (via `pyfamsa` 0.7.0) | 16S alignment | 0.7.0 (pyfamsa) |
| IQ-TREE | 16S maximum-likelihood tree | TODO |
| Python (Biopython, pandas, scipy, matplotlib) | ANI clustermap | TODO |
| SLURM (OHSU ARC) | Pangenome compute | n/a |

## 1. Genome retrieval and curation

- `ncbi-genome-download` listed 97 *Parvimonas* genomes in RefSeq and 144 in GenBank.
- Genomes present in both databases were de-duplicated in Excel, keeping the RefSeq version.
- 14 genomes were removed manually because NCBI Genome flagged contamination, small size, or other quality issues.
- The curated set is **97 RefSeq + 35 GenBank = 132 NCBI genomes**.

```bash
ncbi-genome-download bacteria -A refseq-accessions.txt -s refseq  --metadata NCBI-METADATA-R.txt
ncbi-genome-download bacteria -A genbank-accessions.txt -s genbank --metadata NCBI-METADATA-G.txt
# The two metadata tables were combined manually in Excel: NCBI-METADATA-combined.txt
```

The anvi'o input table was generated with:

```bash
anvi-script-process-genbank-metadata -m NCBI-METADATA-combined.txt \
    --output-dir parvi-pan-genomes --output-fasta-txt fasta.txt -E
```

Ten additional genomes were then added manually to `fasta.txt`: the Merritt Lab genomes (JM503 isolates; JM503A, JM503A1, JM503A3, JM503A11, JM503A16, JM503A42, JM503A82, JM503CC1, JM503OC4) and the outgroup *Finegoldia magna*. The final analysis set is **142 genomes**.

## 2. Metadata

```bash
datasets summary genome taxon "Parvimonas" --as-json-lines --assembly-source all > parvimonas-metadata-all.jsonl

dataformat excel genome --inputfile parvimonas-metadata-all.jsonl \
  --fields accession,assminfo-level,assminfo-release-date,assminfo-biosample-attribute-name,assminfo-biosample-attribute-value \
  --outputfile parvi-all.xlsx
```

BioSample attributes were pivoted to a wide, human-readable table in R (one row per assembly accession, columns for assembly level, release date, and each BioSample attribute):

```bash
Rscript -e "library(readxl);library(dplyr);library(tidyr);read_excel('parvi-all.xlsx') %>% pivot_wider(id_cols=c(\`Assembly Accession\`,\`Assembly Level\`,\`Assembly Release Date\`),names_from=\`Assembly BioSample Attribute Name\`,values_from=\`Assembly BioSample Attribute Value\`,values_fn=first) %>% write.csv('test_wide.csv',row.names=FALSE)"
```

The metadata table used downstream (`parvimonas-metadata.txt`) keeps assembly accession, assembly level, release date, `isolation_source`, and `geo_loc_name`.

## 3. Pangenome construction (anvi'o)

The anvi'o pangenomics workflow was run with a customized `pan-default.json` (threads and job counts adjusted):

```bash
anvi-run-workflow -w pangenomics -c pan-default.json
```

Two problems were handled manually:

- The workflow stalled at `anvi-run-ncbi-cogs` for `Parvimonas_micra_GCF_977006265_1`; that command was re-run by hand and completed.
- `anvi-pan-genome` required MUSCLE v5 (`mamba install -c conda-forge -c bioconda "muscle>=5,<6"`) and the `--I-know-this-is-not-a-good-idea` flag, which anvi'o requires because of the large number of genomes.

Because the local run was too slow, the pangenome step was run on the OHSU ARC cluster (SLURM; 1 node, 16 CPUs, 12 GB/CPU, 18 h limit) with an MCL inflation of 4:

```bash
srun anvi-pan-genome \
  -g 03_PAN/parvimonas-pangenome-GENOMES.db \
  --num-threads $SLURM_CPUS_PER_TASK \
  -o 03_PAN/parvimonas-pangenome-PAN.db \
  --project-name parvimonas-pangenome \
  --I-know-this-is-not-a-good-idea \
  --mcl-inflation 4
```

Submitted with `sbatch run_pangenome.sh` (job script contents are in `october-scripts.sh`).

## 4. Filtering metadata and genome lists

- **`parvimonas-metadata-filtered.txt`**: the metadata restricted to genomes in `external-genomes.txt`, with the anvi'o genome `name` added. Names were matched to metadata by converting the accession embedded in each name (e.g. `..._GCF_000493795_1` -> `GCF_000493795.1`). All 132 NCBI-derived genomes matched; the 10 in-house/outgroup genomes (JM503 isolates and *F. magna*) have no NCBI accession and are not in this table.
- **`external-genomes-complete.txt`**: the subset of `external-genomes.txt` whose assembly level is `Complete Genome` in the filtered metadata (**25 genomes**).

## 5. 16S rRNA analysis

16S sequences were extracted from the 25 complete genomes using the anvi'o HMM hits:

```bash
anvi-get-sequences-for-hmm-hits -e external-genomes-complete.txt \
  --hmm-source Ribosomal_RNA_16S --gene-names 16S_rRNA_bac \
  -o 16S_alignment-complete-only.txt
```

Findings:

- 76 sequences total: 3 copies per genome, 4 for *F. magna*. Lengths range from 1518 to 1526 bp (most are 1521 or 1522).
- No genome has fully identical copies: every genome has at least 2 distinct sequences (exact string comparison, unaligned).
- The extracted file is not an alignment, so it was aligned with FAMSA after simplifying the FASTA headers to `{bin_id}_{gene_callers_id suffix}` (IQ-TREE requires equal-length sequences and simple names).
- A first IQ-TREE run on all 76 sequences produced a tree dominated by zero-length branches (42 distinct sequences, several shared across genomes).
- To simplify the tree, one 16S copy per genome was retained: the copy with the lowest summed mismatches to the other copies of that genome (a medoid). Within-genome copies differed by up to 12 mismatches. Columns that were all gaps after subsetting were removed (1530 columns, 25 sequences).
- The tree was rooted on *Finegoldia magna*.

Example IQ-TREE command for the representative alignment:

```bash
iqtree2 -s 16S_representatives_aligned.fa -m MFP -B 1000 -T AUTO -o Finegoldia_magna
```

Files: `16S_alignment-complete-only.txt` (raw extraction), `16S_simple-deflines.fa`, `16S_aligned.fa`, `16S_lengths.tsv`, `16S_identical_per_bin.tsv`, `16S_representatives_aligned.fa`, `16S_representatives.tsv` (which copy was kept per genome).

## 6. ANI clustermap

Average nucleotide identity (ANIb) results were in `ani-output/` (`ANIb_percentage_identity.txt` and its Newick tree; **TODO**: document the ANI tool, version, and command that produced these). The clustermap (`parvimonas_ANI_clustermap.pdf`) is generated by `make_ani_clustermap.py`:

- Rows and columns follow the tip order of the ANIb Newick tree, rerooted on *F. magna* and ordered so that the root is at the top left. The tree is drawn as a cladogram.
- The ANI matrix is symmetrized by averaging the two directions of each pair.
- Color scale: pairwise ANI < 0.94 is white; 0.94 to 0.96 is a yellow-to-orange gradient; 0.96 to 1.0 is an orange-to-red gradient.
- About 62% of pairwise comparisons fall below 0.94.

```bash
python3 make_ani_clustermap.py   # run from the project root
```

## Repository contents

| File | Description |
|---|---|
| `october-scripts.sh` | Original command log |
| `external-genomes.txt`, `external-genomes-complete.txt` | anvi'o external genomes (all 142; the 25 complete) |
| `parvimonas-metadata.txt`, `parvimonas-metadata-filtered.txt` | NCBI metadata (full; filtered with names) |
| `16S_*` files | 16S extraction, alignments, and summaries |
| `ani-output/` | ANIb tables and trees |
| `make_ani_clustermap.py`, `parvimonas_ANI_clustermap.pdf` | ANI clustermap script and figure |
