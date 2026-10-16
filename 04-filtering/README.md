## 4. Filtering metadata and genome lists

- **`parvimonas-metadata-filtered.txt`**: the metadata restricted to genomes in `external-genomes.txt`, with the anvi'o genome `name` added. Names were matched to metadata by converting the accession embedded in each name (e.g. `..._GCF_000493795_1` -> `GCF_000493795.1`). All 132 NCBI-derived genomes matched; the 10 in-house/outgroup genomes (JM503 isolates and *F. magna*) have no NCBI accession and are not in this table.
- **`external-genomes-complete.txt`**: the subset of `external-genomes.txt` whose assembly level is `Complete Genome` in the filtered metadata (**25 genomes**).
