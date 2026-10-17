python3 - <<'E'
import re
seen=set()
with open('16S_alignment-complete-only.txt') as i, open('16S_simple-deflines.fa','w') as o:
    for l in i:
        if l.startswith('>'):
            b=re.search(r'bin_id:([^|]+)',l)[1];g=re.search(r'gene_callers_id:[^|]*_(\d+)\|',l)[1]
            n=f"{b}_{g}";assert n not in seen;seen.add(n);o.write('>'+n+'\n')
        else:o.write(l)
E
grep '>' 16S_simple-deflines.fa | head -4; grep -c '>' 16S_simple-deflines.fa
