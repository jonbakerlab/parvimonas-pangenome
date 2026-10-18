## 03. Pangenome construction (anvi'o)

The anvi'o pangenomics workflow was run with a customized `pan-default.json` (threads and job counts adjusted, available in this folder):

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

Submitted with `sbatch run_pangenome.sh` (shell script in this folder).
