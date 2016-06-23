print '\n''Importing Libraries''\n'
import pip
def install(package):
    pip.main(['install', package])
    uninstall(numpy)
    uninstall(scipy)
    install(numpy)
    install(scipy)
    install(--upgrade,numpy)
    install(--upgrade,scipy)
    install(pandas)
    install(--upgrade,pandas)
    install(scikit-learn)
    install(--upgrade ,scikit-learn)
import os
import sys
import pylab
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

print '\n'"Reading File"'\n'
file1 = sys.argv[1]
data = pd.read_csv(file1,index_col = 0,  sep = '\t')

print '\n'"Creating Indexes" '\n'
data.index.names = ['gene']
data.columns.names = ['samples']
data = pd.DataFrame.transpose(data)

print '\n'"Performing Principal Component Analysis on Samples"'\n'
from sklearn.decomposition import PCA
pca = PCA(n_components=3)
pca.fit(data)
data1 = pca.transform(data)
data2 = pd.DataFrame(data1)
ratio = pca.explained_variance_ratio_

outfile1 = os.path.splitext(file1)[0]+'_PC_variance'+'.txt'
print '\n' "Writing variance of each Principal Component" + ' ' + 'in' + ' '+  outfile1 + '\n'
with open(os.path.splitext(file1)[0]+'_PC_variance'+'.txt', 'w') as OUT:
	for  f in range(0,3):
		a = ratio[f]*100
		string = "PC"+str(f+1)
		b = str(string) + ' '+"variance is"+' '+str(a)
		OUT.write("%s\n" % str(b))


data2.index = data.index
data2.columns = ['PC1', 'PC2', 'PC3']
data2.head()

outfile2 = os.path.splitext(file1)[0]+'_PCA_Loading_values'+'.txt'
print '\n' "Writing Loading values of Samples in each Principal Component" + ' '+ 'in' + ' '+outfile2 + '\n'
with open(os.path.splitext(file1)[0]+'_PCA_Loading_values'+'.txt', 'w') as OUT1:
	OUT1.write('{0}' .format(data2))

print '\n' "Generating PC1 vs PC2 scatter plot" '\n'
ax = data2.plot(kind='scatter', x='PC1', y='PC2', c='c', s=100)
for i, Gene in enumerate(data.index):
    ax.annotate(Gene, (data2.iloc[i].PC1, data2.iloc[i].PC2))
a = os.path.splitext(file1)
pylab.savefig(os.path.splitext(file1)[0] + '_PCA_on_Samples' +'.pdf')
