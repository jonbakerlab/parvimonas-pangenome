## 07. Core genes phylogeny

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

The resulting concatenated core genes `better-core2.fa` Annotations for the 13 single-copy core genes used are provided in `better-core-list.txt`:

| SynGC | Source | Accession | Function |
|---|---|---|---|
| GC_00000328 | COG24_FUNCTION | COG0353 | Recombinational DNA repair protein RecR (RecR) (PDB:2JGR) (PUBMED:26337406) |
| GC_00000431 | COG24_FUNCTION | COG1188 | Ribosomal 50S subunit-recycling heat shock protein, contains S4 domain (HslR) (PDB:3BBU) |
| GC_00000432 | COG24_FUNCTION | COG0799 | Ribosomal silencing factor RsfS, regulates association of 30S and 50S subunits (RsfS) (PDB:6SJ6) |
| GC_00000434 | COG24_FUNCTION | COG0359 | Ribosomal protein L9 (RplI) (PDB:1VS6_BH) (PUBMED:27112601) |
| GC_00000439 | Pfam | PF14584.11 | Protein of unknown function (DUF4446) |
| GC_00000441 | COG24_FUNCTION | COG0602 | Organic radical activating enzyme, includes 7-carboxy-7-deazaguanine synthase NrdG/QueE (QueE) (PDB:6NHL) (PUBMED:14660578;17384645) |
| GC_00000462 | COG24_FUNCTION | COG3842 | ABC-type Fe3+/spermidine/putrescine transport systems, ATPase component (PotA) (PDB:1Z47) |
| GC_00000513 | COG24_FUNCTION | COG0503 | Adenine/guanine phosphoribosyltransferase or related PRPP-binding protein (Apt) (PDB:1QB7) |
| GC_00000514 | COG24_FUNCTION | COG0560 | Phosphoserine phosphatase (SerB) (PDB:3N28) |
| GC_00000526 | COG24_FUNCTION | COG1210 | UTP-glucose-1-phosphate uridylyltransferase (GalU) (PDB:2E3D) |
| GC_00000531 | COG24_FUNCTION | COG2501 | Ribosome-associated RNA-binding protein YbcJ, S4-like RNA-binding protein (YbcJ) (PDB:1P9K) (PUBMED:36987847) |
| GC_00000534 | COG24_FUNCTION | COG2812 | DNA polymerase III, gamma/tau subunits (DnaX) (PDB:1JR3) |
| GC_00000552 | COG24_FUNCTION | COG0521 | Molybdopterin adenylyltransferase MoaB/MogA (MoaB) (PDB:1DI6) (PUBMED:32239579) |


There gene clusters were used to make a tree with `iqtree2`: 

`iqtree -s better-core2.fa -nt 10 -m WAG -B 1000`

The resulting `better-core2.fa.contree` file was re-rooted to *F. magna* using iToL.  Here is a preview with the species level clades collapsed: ADD
