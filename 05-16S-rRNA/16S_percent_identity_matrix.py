#!/usr/bin/env python3
"""Pairwise percent identity matrix from an aligned FASTA, ordered by tree tip order.

Identity = matching bases / positions where both sequences have a base
(columns that are gaps in either sequence are ignored).

Usage:
    python3 16S_percent_identity_matrix.py \
        16S_representatives_aligned.fa \
        16S_representatives_aligned.fa.treefile \
        16S_percent_identity_matrix.tsv
"""
import re
import sys


def read_fasta(path):
    seqs = {}
    name = None
    with open(path) as f:
        for line in f:
            line = line.strip()
            if line.startswith(">"):
                name = line[1:]
                seqs[name] = ""
            elif line:
                seqs[name] += line
    return seqs


def tip_order(treefile):
    with open(treefile) as f:
        newick = f.read()
    return re.findall(r"[(,]([^():,;]+)(?=:)", newick)


def percent_identity(a, b):
    pairs = [(x, y) for x, y in zip(a, b) if x != "-" and y != "-"]
    return 100 * sum(x == y for x, y in pairs) / len(pairs)


def main(fasta, treefile, out):
    seqs = read_fasta(fasta)
    order = tip_order(treefile)
    assert set(order) == set(seqs), f"Tree/alignment name mismatch: {set(seqs) ^ set(order)}"
    with open(out, "w") as o:
        o.write("\t" + "\t".join(order) + "\n")
        for a in order:
            row = (f"{percent_identity(seqs[a], seqs[b]):.2f}" for b in order)
            o.write(a + "\t" + "\t".join(row) + "\n")


if __name__ == "__main__":
    if len(sys.argv) != 4:
        sys.exit(__doc__)
    main(*sys.argv[1:])
