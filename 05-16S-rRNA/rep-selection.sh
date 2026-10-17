python3 - <<'E'
import collections
s={}
for l in open('16S_aligned.fa'):
    l=l.strip()
    if l.startswith('>'): n=l[1:];s[n]=''
    else: s[n]+=l
g=lambda n:n.rsplit('_',1)[0]
d=lambda a,b:sum(x!=y for x,y in zip(a,b) if x!='-' and y!='-')
by=collections.defaultdict(list)
for n in s: by[g(n)].append(n)
with open('16S_representatives.fa','w') as o, open('16S_representatives.tsv','w') as m:
    m.write('genome\tkept\tn_copies\tmax_mismatch_within\n')
    for k,v in by.items():
        rep=min(v,key=lambda a:(sum(d(s[a],s[b]) for b in v),a))
        o.write(f">{k}\n{s[rep].replace('-','')}\n")
        m.write(f"{k}\t{rep}\t{len(v)}\t{max(d(s[a],s[b]) for a in v for b in v)}\n")
E
