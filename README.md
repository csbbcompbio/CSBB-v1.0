CSBB is a command line based bioinformatics suite to analyze biological data acquired through varied avenues of biological experiments. CSBB is implemented in Perl, while it also leverages the use of R and python in background for specific modules. Major focus of CSBB is to allow users from biology and bioinformatics community, to get benefited by performing down-stream analysis tasks while eliminating the need to write programming code.  CSBB is currently available on Linux, UNIX and Windows platforms.

Currently CSBB provides 13 modules focused on analytical tasks like performing upper-quantile normalization on expression data or convert genome wide gene expression to z-scores when comparing expression data from different platforms.                                                        

Modules
1)	UpperQuantile: Upper quantile normalization is used to normalize two or more distributions in absence of a reference distribution. Given a matrix of size M x N, where M is the number of rows and N is the number of columns, UpperQuantile will determine the 75th quantile value for ith column and normalize it across ith column. Upper quantile normalization is regularly used to remove variation from global gene expression data from microarrays and next generation sequencing data.

2)	BasicStats: This module is designed for some basic and quick statistical calculations on gene expression data across samples. BasicStats calculates mean, median, median adjusted deviation, standard deviation, variance, minimum and maximum for each gene based on expression across samples. Assume, you have m*n matrix where m are rows (genes) and n are columns (samples). BasicStats will calculated above mentioned statistics for each row (gene).

3)	ExpressionToZscore: This module converts expression values to z-scores. This module is helpful when a user wants to compare expression data from different sources (labs or platforms). This module converts expression value of a gene in each sample to z-score based on expression across the samples. Let’s say there is a m*n expression matrix then each value in the matrix will be converted to z-score based on values for each row across columns.

4)	ExtractGeneInfo: This module helps to extract information/expression for a list of genes from a large matrix of genes and their expression/information across samples/columns. Let’s say you have m*n matrix and a list of ‘a’ items where a <= m then this module helps user to extract information for ‘a’ items from m*n matrix.

5)	InteractiveHeatmap: It plots the expression values of genes across samples in an interactive heat map fashion. This module uses R package d3heatmap (https://cran.r-project.org/web/packages/d3heatmap/d3heatmap.pdf). User can choose from different clustering and coloring options. Let’s say you have a m*n matrix where m is number of rows and n is number of columns then values of m vs n are plotted. For Clustering only Row, only columns or both Row and Columns are available. Four different color palettes are available 
  I) YellowGreenOrange II). BlueWhiteRed III). YellowBlackBlue IV). GreenWhitePurple

6)	CorrelationProfiles: Use this module to determine positively and negatively correlated features for gene expression data. Also, it creates an interactive heat map when user just wants to obtain positively and negatively among specific number of features out of large number of genes. Let’s say you have m*n matrix, where m are number of rows and represent genes and n are number of columns representing samples. Users can provide a threshold of correlation to filter out features. An interactive heat map will be generated when only correlation profiles of u genes are required where u << m.

7)	Biogrid-Gene-Protein-Search: This module grabs gene protein interactions from BioGrid database (http://thebiogrid.org/). The search currently works for only human and mouse. User just needs a list of genes and tell module species of interest and then rest is taken care by the module. This module reports both i) interactions among genes in the list and ii) interactions of genes known to all proteins in the database.

8)	DifferentialExpression: This module helps user to perform differential gene expression analysis. This module uses latest R package RUVSEQ (Risso et. al, Nature Biotechnology, 2014) (https://www.bioconductor.org/packages/3.3/bioc/vignettes/RUVSeq/inst/doc/RUVSeq.pdf). This package has edge over others like DESEQ2, EDGER and EBSEQ as it removes unwanted variations occurred from sequencing. Differential Expression modules uses RUVg (normalization based on empirical genes i.e. least DE genes) normalization from the package RUVSEQ.

9)	PCA: This module helps user to perform principal component analysis. This module uses python to generate to perform PCA on both genes and samples separately. PCA basically gives users a way to see how the genes and samples are clustering between 1st and 2nd principal components. Assume, an m*n matrix, where m are number of genes and n number of samples. Now this module helps user to perform PCA on both m and n separately.

10)	NMF: This module helps user to perform Non-negative matrix factorization on samples. This modules uses R package NMF (https://cran.r-project.org/web/packages/NMF/index.html) to perform NMF on the user given dataset. Let’s say you have m*n matrix, where m are number of genes and n are number of samples. Now this module helps user to perform NMF on n. This module is very helpful if you user wants to understand the relationship among the samples in the dataset.

11)	FetchSRA: This module helps user to fetch SRA datasets. This module uses R package SRAdb (https://www.bioconductor.org/packages/3.3/bioc/manuals/SRAdb/man/SRAdb.pdf) to download SRA datasets. User can download samples, experiment or a project dataset by just providing the SRA/SRS/SRP/SRR id.

12)	 FetchGEO: This module helps user to fetch GEO datasets. This module uses R package GEOquery (https://www.bioconductor.org/packages/3.3/bioc/manuals/GEOquery/man/GEOquery.pdf) to download GEO datasets. User can download samples, dataset or a series by just providing the GSM/GDS/GSE id. This modules writes for user three files 
i)	Metadata 
ii)	 Phenodata 
iii)	Expression data.

13)	InteractiveScatterPlot: This module creates interactive scatter plots. This module uses R package plotly (https://plot.ly/r/) and ggplot2 (https://cran.r-project.org/web/packages/ggplot2/index.html) for generating interactive scatter plot. User needs to provide x axis values column, y -axis values column and column for color factorization which if not required can be set to ‘No’. This module aids in visualization of data in form of a scatter plot thereby allowing user to pinpoint features of interest.
