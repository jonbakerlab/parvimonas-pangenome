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

Ten additional genomes were then added manually to `fasta.txt` (in this folder): the Merritt Lab genomes (JM503 isolates; JM503A, JM503A1, JM503A3, JM503A11, JM503A16, JM503A42, JM503A82, JM503CC1, JM503OC4) and the outgroup *Finegoldia magna* (these fasta files are in available in this folder). The final analysis set is **142 genomes**.
