import pandas as pd, numpy as np
from Bio import Phylo
import matplotlib; matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap, Normalize

d='ani-output/'
df=pd.read_csv(d+'ANIb_percentage_identity.txt',sep='\t',index_col=0)
tree=Phylo.read(d+'ANIb_full_percentage_identity.newick','newick')
tree.root_with_outgroup('Finegoldia_magna')
order=[t.name for t in tree.get_terminals()][::-1]
assert set(order)==set(df.index)==set(df.columns), (set(order)^set(df.index))
df=df.loc[order,order]
# symmetrize (ANIb is directional)
M=(df.values+df.values.T)/2

lo,hi=0.94,0.96
cmap=LinearSegmentedColormap.from_list('ani',[(0,'white'),(0.0,'white'),(0.0001,'#ffff66'),(1/3,'orange'),(1,'red')])
# map: <0.94 white; 0.94-0.96 yellow->orange; 0.96-1.0 orange->red
vmin,vmax=0.94,1.0
cmap=LinearSegmentedColormap.from_list('ani',[(0,'yellow'),(1/3,'orange'),(1,'red')])
cmap.set_under('white')
Mp=np.where(M<lo,np.nan,M)

n=len(order)
ypos={t:i+0.5 for i,t in enumerate(order)}
def layout(c):
    if c.is_terminal(): return ypos[c.name],0
    ys=[layout(k)[0] for k in c.clades]
    c._y=(min(ys)+max(ys))/2
    return c._y,1
def depth(c):
    return 0 if c.is_terminal() else 1+max(depth(k) for k in c.clades)
D=depth(tree.root)
def xy(c):
    return (0 if c.is_terminal() else depth(c))
def draw(ax,c):
    y=ypos[c.name] if c.is_terminal() else c._y
    for k in c.clades:
        ky=ypos[k.name] if k.is_terminal() else k._y
        ax.plot([-xy(c),-xy(c)],[y,ky],'k',lw=.6)
        ax.plot([-xy(c),-xy(k)],[ky,ky],'k',lw=.6)
        draw(ax,k)
layout(tree.root)

fig=plt.figure(figsize=(18,16))
axt=fig.add_axes([0.02,0.2,0.12,0.72])
axh=fig.add_axes([0.14,0.2,0.72,0.72])
cax=fig.add_axes([0.02,0.95,0.15,0.012])
draw(axt,tree.root); axt.set_ylim(n,0); axt.set_xlim(-D-.2,0.1); axt.axis('off')
im=axh.imshow(np.ma.masked_invalid(Mp),cmap=cmap.with_extremes(bad='white'),vmin=vmin,vmax=vmax,aspect='auto',extent=(0,n,n,0),interpolation='nearest')
axh.set_xticks(np.arange(n)+.5); axh.set_xticklabels(order,rotation=90,fontsize=5)
axh.set_yticks(np.arange(n)+.5); axh.set_yticklabels(order,fontsize=5); axh.yaxis.tick_right()
axh.tick_params(length=1.5)
for s in axh.spines.values(): s.set_linewidth(.5)
cb=fig.colorbar(im,cax=cax,ticks=[0.94,0.96,0.98,1.0],orientation='horizontal'); cb.set_label('ANI (<0.94 white)')
fig.savefig('parvimonas_ANI_clustermap.pdf')
print(n,np.nanmin(M),np.nanmax(M),(M<lo).mean())
