## 05. 16S rRNA analysis

16S sequences were extracted from the 25 complete genomes (`external-genomes-complete.txt`) using the anvi'o HMM hits:

```bash
anvi-get-sequences-for-hmm-hits -e external-genomes-complete.txt \
  --hmm-source Ribosomal_RNA_16S --gene-names 16S_rRNA_bac \
  -o 16S_alignment-complete-only.txt
```

Findings:

- 76 sequences total (16S_extrated-complete-only.txt`: 3 copies per genome, 4 for *F. magna*. Lengths range from 1518 to 1526 bp (most are 1521 or 1522).
- No genome has fully identical copies: every genome has at least 2 distinct sequences (exact string comparison, unaligned).
- Deflines were simplified using `simplify-deflines.sh` and sequences were aligned using `align-with-famsa.sh`.
- The extracted file is not an alignment, so it was aligned with FAMSA after simplifying the FASTA headers to `{bin_id}_{gene_callers_id suffix}` (IQ-TREE requires equal-length sequences and simple names).
- A first IQ-TREE run on all 76 sequences produced `16S_all_aligned.fa.contree` dominated by zero-length branches (42 distinct sequences, several shared across genomes).
- To simplify the tree, one 16S copy per genome was retained: the copy with the lowest summed mismatches to the other copies of that genome (a medoid) using `rep-selection.sh`. Within-genome copies differed by up to 12 mismatches. Columns that were all gaps after subsetting were removed (1530 columns, 25 sequences) using `reconstruct-final-alignment.sh`.
- A final tree `16S_representatives_aligned.fa.contree` was created and rooted on *Finegoldia magna* using:

```bash
iqtree2 -s 16S_representatives_aligned.fa -m MFP -B 1000 -T AUTO -o Finegoldia_magna
```

