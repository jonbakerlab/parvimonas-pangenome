python3 - <<'E'
from pyfamsa import Aligner, Sequence
s=[];h=None
for l in open('16S_simple-deflines.fa'):
    l=l.strip()
    if l.startswith('>'): s.append([l[1:].encode(),''])
    elif l: s[-1][1]+=l
seqs=[Sequence(n,q.encode()) for n,q in s]
msa=Aligner(guide_tree="upgma").align(seqs)
order={n:i for i,(n,_) in enumerate(s)}
L={len(x.sequence) for x in msa};print(L,len(msa))
with open('16S_aligned.fa','w') as o:
    for x in sorted(msa,key=lambda x:order[x.id]):
        o.write('>'+x.id.decode()+'\n'+x.sequence.decode()+'\n')
E
grep -c '>' 16S_aligned.fa
