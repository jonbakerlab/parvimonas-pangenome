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
