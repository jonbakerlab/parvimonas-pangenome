## Phylogenomics based on amino acid sequences of single copy core genes 

The pangenome was used to create a bespoke panel of single-copy core genes with which to perform phylogenomic analysis. Across the pangenome containing 142 genomes, a search for single copy core genes yielded zero genes, likely due to either incomplete genomes or over-splitting of gene clusters by `anvi-pan-genome`.  Iterative decreasing of the number of genomes required produced the following:

|--min-num-genomes-gene-cluster-occurs|number of single-copy core genes |
|---|---|
|142 genomes | 0 | 
|141 genomes | 1 | 
|140 genomes | 3 |
|139 genomes | 5 | 
|138 genomes | 15 |
|137 genomes | 28 |
|136 genomes | 45 |

This suggested that inclusion of incomplete genomes was more of a hinderance on obtaining single-copy core genes than over splitting of gene clusters during the pangenome analysis.

To minimize gaps in the sequencing alignment while maximizing un-gapped sequence heterogeneity (to prevent flat branches), several combinations of geometric and functional homogeneity cutoffs were examined. The following script and cutoffs were used to yield an alignment of 13 single copy core genes that best fit our criteria:

```bash
anvi-get-sequences-for-gene-clusters \
    -g 03_PAN/parvimonas-pangenome-GENOMES.db \
    -p 03_PAN/parvimonas-pangenome-PAN.db \
    -o better-core2.fa \
    --min-num-genomes-gene-cluster-occurs 137 \
    --max-num-genes-from-each-genome 1 \
    --min-geometric-homogeneity-index 0.95 \
    --max-functional-homogeneity-index 0.98 \
    --concatenate-gene-cluster
```

The resulting concatenated core genes `better-core2.fa` was used to make a tree with `iqtree2`: 

`iqtree -s better-core2.fa -nt 10 -m WAG -B 1000`

The resulting `better-core2.fa.contree` file was re-rooted to *F. magna* using iToL. Annotations for the 13 single-copy core genes used are provided in `better-core-list.txt` and include RecR, HslR, RsfS, RplL, NrdG, PotA, Apt, SerB, GalU, YbcJ, DnaX, MoaB, and a conserved hypothetical containing a DUF4446 domain.
