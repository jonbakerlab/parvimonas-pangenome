python3 - <<'E'
import re

r={
    l.split('\t')[0]: l.split('\t')[1]
    for l in open(
        '16S_representatives.tsv'
    ).read().splitlines()[1:]
}

s={}

for l in open('16S_aligned.fa'):
    l=l.strip()

    if l.startswith('>'):
        n=l[1:]
        s[n]=''
    else:
        s[n]+=l

keep={k:s[v] for k,v in r.items()}

cols=[
    i
    for i in range(
        len(next(iter(keep.values())))
    )
    if any(q[i] != '-' for q in keep.values())
]

with open(
    '16S_representatives_aligned.fa',
    'w'
) as o:

    for k,q in keep.items():

        o.write(
            f">{k}\n"
            f"{''.join(q[i] for i in cols)}\n"
        )
E
Phylogenetic Inference
The final genome-level 16S alignment was used for maximum-likelihood tree reconstruction using IQ-TREE.

For IQ-TREE 2:

iqtree2 \
    -s 16S_representatives_aligned.fa \
    -m MFP \
    -bb 1000 \
    -nt AUTO
For IQ-TREE 1:

iqtree \
    -s 16S_representatives_aligned.fa \
    -m TEST \
    -b 1000 \
    -nt 10
