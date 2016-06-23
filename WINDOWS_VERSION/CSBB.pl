#!/usr/bin/perl
use English qw' -no_match_vars ';
print "\nOperating System is $OSNAME\n";
##### COMMAND_LINE_SUITE_FOR_BIOINFORMATICIANS & BIOLOGISTS ########
print "\n\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\n";
print "\nCOMMAND LINE SUITE FOR BIOINFORMATICIANS \& BIOLOGISTS\n";
print "\nWritten by Praneet Chaturvedi Kashish Chetal Sithara Raju Simarjot Pabla \=\=\=\= \=\=\=\=\= \=\=\=\=\=\n";
print "Version\_1\n";
print "\nUse \-\-help for information on running COMMAND LINE SUITE FOR BIOINFORMATICIANS \& BIOLOGISTS\n";
print "\nPlease See README and White-Paper for getting detailed instructions on running the script \.\.\.\n";
print "\nRequirements for Windows version \: Please install R version R\, python 2.7+ and pandoc\n";
print "\n\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\=\n";
###write perl Command_Line_Suite.pl -help for options###

###Asking user input###
print "\n\n\=\=\=\=\=Happy to see you \.\.\. Lets get started and do some magic with your files \=\=\=\=\=\n";


my $user_input=$ARGV[0]; ###user input through command line ##


#######################################################################
#######################################################################
############ CALLING MODULES BASED ON USER INPUT ###########


if($user_input eq "--help")
{
 &help;
}
if($user_input eq "UpperQuantile")
{
 my $file=$ARGV[1];
 &upperquantile($file);
}
if($user_input eq "ExpressionToZscore")
{
 my $file=$ARGV[1];
 &expressiontozscore($file);
}
if($user_input eq "BasicStats")
{
 my $file=$ARGV[1];
 &basicstats($file);
}
if($user_input eq "ExtractGeneInfo")
{
 my $file=$ARGV[1];
 my $file1=$ARGV[2];
 &extractgeneinfo($file,$file1);
}
if($user_input eq "InteractiveHeatmap")
{
 my $file=$ARGV[1];
 my $clustering_type=$ARGV[2];
 my $color_theme=$ARGV[3];
 &interactiveheatmap($file,$clustering_type,$color_theme);
}
if($user_input eq "CorrelationProfiles")
{
 my $file=$ARGV[1];
 my $threshold=$ARGV[2];
 my $genesofinterest=$ARGV[3];
 &correlationprofile($file,$threshold,$genesofinterest);
}
if($user_input eq "Biogrid-Gene-Protein-Search")
{
 my $organism=$ARGV[1];
 my $file=$ARGV[2];
 &biogrid($organism,$file);
}
if($user_input eq "DifferentialExpression")
{
 my $file=$ARGV[1];
 my $numbercontrol=$ARGV[2];
 my $numbertreatment=$ARGV[3];
 my $countsthreshold=$ARGV[4];
 my $numbersamples=$ARGV[5];
 &de($file,$numbercontrol,$numbertreatment,$countsthreshold,$numbersamples);
}
if($user_input eq "PCA")
{
 my $file=$ARGV[1];
 my $object=$ARGV[2];
 &pca($file,$object);
}
if($user_input eq "NMF")
{
 my $file=$ARGV[1];
 &nmf($file);
}
if($user_input eq "FetchSRA")
{
 my $path=$ARGV[1];
 my $SRAid=$ARGV[2];
 &fetchsra($path,$SRAid);
}
if($user_input eq "FetchGEO")
{
 my $path=$ARGV[1];
 my $GEOid=$ARGV[2];
 &fetchgeo($path,$GEOid);
}
if($user_input eq "InteractiveScatterPlot")
{
 $file=$ARGV[1];
 $colx=$ARGV[2];
 $coly=$ARGV[3];
 $colenrichment=$ARGV[4];
 &interactivesp($file,$colx,$coly,$colenrichment);
}


#########################################################################
#########################################################################
##### MODULES CODE DOWN HERE ##########

#####################  HELP MODULE ####################
sub help
{
 print "\nPlease use options below to run the COMMAND LINE SUITE FOR BIOINFORMATICIANS \& BIOLOGISTS\n";
 print "\nOptions\:\:\n";
 print "\nUpperQuantile                  \-\-\-\> for performing upper quantile normalization\n\n";
 print "\nBasicStats                     \-\-\-\> for obtaining stats like mean\, median\, standard deviation\, variance\, Sum\, min and max for each Gene Expression profile\n\n";
 print "\nExpressionToZscore             \-\-\-\> for obtaining z-scores for Gene Expression in samples\n\n";
 print "\nExtractGeneInfo                \-\-\-\> for obtaining info\/expression of list genes from a huge matrix gene info\/expression\n\n";
 print "\nInteractiveHeatmap             \-\-\-\> for generating interactive heatmaps for expression data\. User has three options on clustering type and four choices on color theme\. Please read README for descriptions and run command\.\n\n";
 print "\nCorrelationProfiles            \-\-\-\> for obtaining genes correlation profile termed as positively and negatively correlated based on User threshold\. One can obtain profile for all genes or just genes of interest \(For genes of interest user needs to provide the path to gene list file\)\. Heatmap will only be displayed for genes of interest\n\n";
 print "\nBiogrid\-Gene\-Protein\-Search    \-\-\-\> for obtaining gene\-protein interactions for Human and Mouse for genes of interest\n\n";
 print "\nDifferentialExpression         \-\-\-\> for obtaining DE genes in RNA-SEQ expriments\. Uses RUVSeq package in R\n\n";
 print "\nPCA                            \-\-\-\> for performing Principal Component Analysis on Genes and Samples\. User needs to provide path to the file and specify Genes or Samples based on which PCA is needed to be performed\n";
 print "\nNMF                            \-\-\-\> for performing Nonnegative Matrix Factorization on Samples in Expression dataset\n";
 print "\nFetchSRA                       \-\-\-\> for downloading Raw SRA data from NCBI SRA for example user can Download all the samples under SRA project id or just a single sample based on requirement\. Just requires path to the folder where you want to download the data and SRA ID\n";
 print "\nFetchGEO                       \-\-\-\> for downloading GEO expression data for example user can fetch expression of GSE Id\, GSM Id\, GDS Id\. Just requires path to the folder where you want to download the data and GSE\/GSM\/GSD ID\n";
 print "\nInteractiveScatterPlot         \-\-\-\> for generating Interactive Scatter plot based on user preference\. User needs to provide path to the file\, Column number for x\-axis values\, Column number for y\-axis values and Column number which user needs for color factorization \(If users provides No color factorization will not be done\) Please see README for extensive explanation\n";
}
##################### MODULE END #####################


########################### UPPERQUANTILE MODULE ##################
sub upperquantile
{
 use Cwd;
 my $cwd = getcwd;
 print "\nUpper Quantile Normalization module loaded\n";
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $header;my $path;
 my $counter=0;
 my $counter1=0;my $counter_path=0;
 open(F,$file);
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter++;
  if($counter==1)
  {
   ####print "$data\n";
   $header=$data;
  }
 }
 close F;
 print "\nStored Header Info\n";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."quantile_normalization.r";
 system("Rscript.bat","script","$dirtoR","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 print "\nR Run complete \.\.\. Now writing header with perl\n";
 my $Rfile = $path."\/"."temporaryfile"."\."."txt";
 my $outfile = "Quantile"."\_"."Normalized"."\_".$filename;
 open(OUT,">$path/$outfile");
 my $newhead=$header;
 print OUT "$header\n";
 open(F,"$Rfile");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
   $counter1++;
   if($counter1==1)
   {}
   else
   {
    print OUT "$data\n";
   }
  }
  close F;
  close OUT;
  unlink $Rfile;
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "\nPlease see file $outfile for results\n";
}
############################ MODULE END ############################


########################### EXPRESSIONTOZSCORE MODULE ##################
sub expressiontozscore
{
 print "\nExpressionToZscore module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $header;my $path;
 my $counter=0;
 my $counter1=0;my $counter_path=0;
 open(F,$file);
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter++;
  if($counter==1)
  {
   $header=$data;
  }
 }
 close F;
 print "\nStored Header Info\n";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."Zscore_Calculator.r";
 system("Rscript.bat","script","$dirtoR","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 print "\nR Run complete \.\.\. Now writing header with perl\n";
 my $Rfile = $path."\/"."temporaryfile"."\."."txt";
 my $outfile = "Zscores"."\_".$filename;
 open(OUT,">$path/$outfile");
 my $newhead=$header;
 print OUT "$header\n";
 open(F,"$Rfile");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter1++;
  if($counter1==1)
  {}
  else
  {
   print OUT "$data\n";
  }
 }
 close F;
 close OUT;
 unlink $Rfile;
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nPlease see file $outfile for results\n";
}
################################## MODULE END #############################


################################# BASICSTATS MODULE ########################
sub basicstats
{
 print "\nBasicStats module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $path;
 my $counter1=0;my $counter_path=0;
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."BasicStats.r";
 system("Rscript.bat","script","$dirtoR","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 print "\nR Run complete \.\.\. Now writing header with perl\n";
 my $Rfile = $path."\/"."temporaryfile"."\."."txt";
 my $outfile = "BasicStats"."\_".$filename;
 open(OUT,">$path/$outfile");
 print OUT "Gene\tMean\tMedian\tMedian Adjusted Deviation\tStandard Deviation\tVariance\tMinimum\tMaximum\n";
 open(F,"$Rfile");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter1++;
  if($counter1==1)
  {}
  else
  {
   print OUT "$data\n";
  }
 }
 close F;
 close OUT;
 unlink $Rfile;
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nPlease see file $outfile for results\n";
}
###################################### MODULE END ################################


############################### EXTRACTGENEINFO MODULE ##########################
sub extractgeneinfo
{
 use Cwd;
 my $cwd = getcwd;
 print "\nExtractGeneInfo module loaded\n";
 my $file1=@_[0];chomp $file1;
 my $file2=@_[1];chomp $file2;
 if($file1 eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to the Expression\/Information file \.\. You can drag and drop the file from folder window\n";
  $file1=<stdin>;chomp $file1;
 }
 if($file2 eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to the Gene List file \.\. You can drag and drop the file from folder window\n";
  $file2=<stdin>;chomp $file2;
 }
 $file1 =~ s/\\/\//g;
 $file2 =~ s/\\/\//g;
 my $start_time=time();
 my $dirtoperl=$cwd."\/"."Modules"."\/"."extract_gene_info.pl";
 system("perl","$dirtoperl","$file1","$file2") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nPlease see file $outfile for results\n";
}
##################################### MODULE END ##################################


#################################### INTERACTIVE HEATMAP MODULE ###################
sub interactiveheatmap
{
 print "\nInteractive Heatmap module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];chomp $file;my $clustering_type=@_[1];chomp $clustering_type;my $color_theme=@_[2];chomp $color_theme;
 if($file eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to the Expression file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 if($clustering_type eq "")
 {
  print "\nYou have forgot to give clustering type from command line\n";
  print "\nPlease provide Clustering type\. Options are 1\. Row\_Clust for only row clustering 2\. Col\_Clust for Column CLustering 3\. Row\_Col\_Clust for both way clustering\n";
  $clustering_type=<stdin>;chomp $clustering_type;
 }
 if($color_theme eq "")
 {
  print "\nYou have forgot to give color theme from command line\n";
  print "\nPlease provide Color theme\. Options are 1\. YellowGreenOrange 2\. BlueWhiteRed 3\. YellowBlackBlue 4\. GreenWhitePurple\n";
  $color_theme=<stdin>;chomp $color_theme;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $path;my $counter_path;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 print "\nRunning R in Background\n";
 print "\n$file\n";
 if($clustering_type eq "Row_Clust")
 {
  print "runing\n";
  my $dirtoR=$cwd."\/"."Modules"."\/"."Row_Clust.r";
  system("Rscript.bat","script","$dirtoR","$path","$filename","$color_theme") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR Run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nBoth Interactive and Static Heatmaps are saved in the folder $path\n";
 }
 if($clustering_type eq "Col_Clust")
 {
  my $dirtoR=$cwd."\/"."Modules"."\/"."Col_Clust.r";
  system("Rscript.bat","script","$dirtoR","$path","$filename","$color_theme") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR Run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nBoth Interactive and Static Heatmaps are saved in the folder $path\n";
 }
 if($clustering_type eq "Row_Col_Clust")
 {
  my $dirtoR=$cwd."\/"."Modules"."\/"."Row_Col_Clust.r";
  system("Rscript.bat","script","$dirtoR","$path","$filename","$color_theme") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR Run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nBoth Interactive and Static Heatmaps are saved in the folder $path\n";
 }
}
############################# MODULE END ######################################


############################# CORRELATION PROFILES ############################
sub correlationprofile
{
 print "\nCorrelationProfiles module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];my $threshold=@_[1];my $genesofinterest=@_[2];chomp $file;chomp $threshold;chomp $genesofinterest;my $negativethreshold=-1*$threshold;
 if($file eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to Gene Expression file \.\. You can drag and drop from folder window\n";
  $file = <stdin>;chomp $file;
 }
 if($threshold eq "")
 {
  print "\nYou have forgot to provide correlation threshold\n";
  print "\nPlease provide correlation threshold \.\. Threshold range is -1 to 1\n";
  $threshold = <stdin>;chomp $threshold;
 }
 if($genesofinterest eq "")
 {
  print "\nYou have forgot to provide genes of interest\n";
  print "\nPlease provide genes of interest\. Options are all or Path to gene list file \.\. You can drag and drop the file from folder window \n";
  $genesofinterest = <stdin>;chomp $genesofinterest;
 }
 $file =~ s/\\/\//g;
 $genesofinterest =~ s/\\/\//g;
 my $start_time=time();
 my $path;my $counter_path=0;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 if($genesofinterest eq "all")
 {
  print "\nRunning R in background to perform correlations \.\.\. please be patient\.\.\.\n";
  my $dirtoR=$cwd."\/"."Modules"."\/"."Correlation_for_Matrix.r";
  system("Rscript.bat","script","$dirtoR","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR Run complete \.\.\. Now Filtering Correlation based on user threshold with perl\n";
  my $Rfile = $path."\/"."temporaryfile"."\."."txt";
  my $dirtoperl=$cwd."\/"."Modules"."\/"."obtain_positive_negative_correlation_set.pl";
  system("perl","$dirtoperl","$path","$filename","$Rfile","$threshold") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  unlink $Rfile;
  print "\nPositive and Negative correlation profiles obtained\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nCorrelation files are saved in $path\n";
 }
 if($genesofinterest =~/.txt/)
 {
  &extractgeneinfo($file,$genesofinterest);
  my @filepath_new=split(/\//,$genesofinterest);
  my $filename_new=pop(@filepath_new);
  my $path_new;my $counter_path_new=0;
  foreach my $m(@filepath_new)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path_new++;
   if($counter_path_new == 1)
   {
    $path_new=$path_new.$m;
   }
   else
   {
    $path_new=$path_new."\/".$m;
   }
  }
 }
  my $extractinfo_result="Expression"."\_".$filename_new;
  my $temp=$path_new."\/".$extractinfo_result;
  print "\nRunning R in background to perform correlations \.\.\. please be patient\.\.\.\n";
  my $dirtoR=$cwd."\/"."Modules"."\/"."Correlation_for_Matrix.r";
  system("Rscript.bat","script","$dirtoR","$path_new","$extractinfo_result") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  unlink $temp;
  print "\nR Run complete \.\.\. Now writing header with perl\n";
  my $Rfile = $path_new."\/"."temporaryfile"."\."."txt";
  my $counter=0;my $header;my $counter1=0;
  open(F,"$Rfile");
  while(my $data = <F>)
  {
   chomp $data;
   $counter++;
   if($counter==1)
   {
    $header=$data;
   }
  }
  close F;
  my $mainhead="Gene"."\t".$header;
  my $correlation_file_R=$path."\/"."Correlation"."\_"."Output"."\_".$filename_new;
  open(OUT,">$correlation_file_R");
  open(F,"$Rfile");
  print OUT "$mainhead\n";
  while(my $data = <F>)
  {
   chomp $data;
   $counter1++;
   if($counter1==1)
   {}
   else
   {
    print OUT "$data\n";
   }
  }
  close OUT;
  close F;
  unlink $Rfile;
  my $dirtoR1=$cwd."\/"."Modules"."\/"."Row_Col_Clust_Correlation_input.r";
  print "\nInteractive Heatmap Module loaded\n";
  print "\nRunning R for generating heatmap using Correlation values\n";
  system("Rscript.bat","script","$dirtoR1","$path_new","$correlation_file_R") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR run complete \.\.\.\. Heatmap generated now finding positively and negatively correlated gene sets using perl\n";
  my $dirtoperl=$cwd."\/"."Modules"."\/"."obtain_positive_negative_correlation_set.pl";
  system("perl","$dirtoperl","$path_new","$filename_new","$correlation_file_R","$threshold") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nCorrelation files are saved in $path_new\n";
 }
}
####################################### MODULE END ####################################


###################################### BIOGRID MODULE START ##########################
sub biogrid
{
 print "\nBiogrid\-Gene\-Protein\-Search Module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $organism=@_[0];chomp $organism;my $file=@_[1]; chomp $file;
 if($organism eq "")
 {
  print "\nYou have forgot to provide organism of interest\n";
  print "\nPlease provide Oraganism of interest\.Options are 1\. Human 2\. Mouse\n";
  $organism=<stdin>;chomp $organism;
 }
 if($file eq "")
 {
  print "\nYou have forgot to provide path to genes of interest file\n";
  print "\nPlease provide path to genes of interest file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $path;my $counter_path=0;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 if($organism eq "Human")
 {
  my $dirtoperl=$cwd."\/"."Modules"."\/"."Biogrid_ppi_Human.pl";
  system("perl","$dirtoperl","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nGene Protein interaction results are saved in $path\n";
 }
 if($organism eq "Mouse")
 {
  my $dirtoperl=$cwd."\/"."Modules"."\/"."Biogrid_ppi_Mouse.pl";
  system("perl","$dirtoperl","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds\n";
  print "\nGene Protein interaction results are saved in $path\n";
 }
}
################################### MODULE END ##########################


################################## DIFFERENTIAL EXPRESSION MODULE ###############
sub de
{
 print "\nDifferentialExpression Module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];my $numbercontrol=@_[1];my $numbertreatment=@_[2];my $countsthreshold=@_[3];my $numbersamples=@_[4];
 chomp $file;chomp $numbercontrol;chomp $numbertreatment;chomp $countsthreshold;chomp $numbersamples;
 if($file eq "")
 {
  print "\nYou have forgot to provide the path to file\n";
  print "\nIn the counts file please place the all control samples first and then all treatment samples\n";
  print "\nPlease provide the path to the Counts file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 if($numbercontrol eq "")
 {
  print "\nYou have forgot to provide the number of control samples\n";
  print "\nPlease provide the Number of Control Samples\n";
  $numbercontrol=<stdin>;chomp $numbercontrol;
 }
 if($numbertreatment eq "")
 {
  print "\nYou have forgot to provide the number of treatment samples\n";
  print "\nPlease provide the Number of Treatment Samples\n";
  $numbertreatment=<stdin>;chomp $numbertreatment;
 }
 if($countsthreshold eq "")
 {
  print "\nYou have forgot to provide the Counts threshold\n";
  print "\nPlease provide the Counts threshold \n";
  $countsthreshold=<stdin>;chomp $countsthreshold;
 }
 if($numbersamples eq "")
 {
  print "\nYou have forgot to provide the number of samples you want to apply counts filtering\n";
  print "\nPlease provide the number of samples you want to apply counts filtering\n";
  $numbersamples=<stdin>;chomp $numbersamples;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $path;my $counter_path=0;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."RUVseq.r";
 print "\nRunning R in background to perform DE using RUVSeq \.\.\. \(please be patient\)\n";
 system("Rscript.bat","script","$dirtoR","$path","$filename","$numbercontrol","$numbertreatment","$countsthreshold","$numbersamples") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 print "\nR Run complete \.\.\. Now writing header with perl\n";
 my $Rfile = $path."\/"."temporaryfile"."\."."txt";
 my $outfile = "DifferentialExpression"."\_".$filename;
 open(OUT,">$path/$outfile");
 print OUT "Gene\tlogFC\tlogCPM\tLR\tPvalue\tFDR\n";
 open(F,"$Rfile");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter1++;
  if($counter1==1)
  {}
  else
  {
   print OUT "$data\n";
  }
 }
 close F;
 close OUT;
 unlink $Rfile;
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nPlease see file $outfile in $path for results\n";
}
##################################### MODULE END #################################


##################################### MODULE PCA START ###########################
sub pca
{
 print "\nPCA Module loaded\n";
 use Cwd;
 my $cwd = getcwd;
 my $file=@_[0];my $object=@_[1];chomp $file;chomp $object;
 if($file eq "")
 {
  print "\nYou have forgot to provide path to the file\n";
  print "\nPlease provide path to the file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 if($object eq "")
 {
  print "\nYou have forgot to provide the object on which PCA is needed to be performed\n";
  print "\nPlease provide object Options are Genes or Samples\n";
  $object=<stdin>;chomp $object;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 if($object eq "Genes")
 {
  my $dirtoPythonpip=$cwd."\/"."Modules"."\/"."get_pip.py";
  print "\nInstalling pip on the system\n";
  system("sudo","python","$dirtoPythonpip");
  print "\nUpgrading Numpy\n";
  system("sudo","easy_install","--upgrade","numpy");
  print "\nUpgrading Scipy\n";
  system("sudo","easy_install","--upgrade","scipy");
  print "\nInstalling Pandas\n";
  system("sudo","pip","install","pandas");
  print "\nInstalling Scikit\-Learn\n";
  system("sudo","pip","install","scikit-learn");
  my $dirtoPython=$cwd."\/"."Modules"."\/"."PCA_Gene.py";
  system("python","-W","ignore","$dirtoPython","$file") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nPython run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "\nPCA results are saved in the directory where expression is\n";
 }
 if($object eq "Samples")
 {
  my $dirtoPythonpip=$cwd."\/"."Modules"."\/"."get_pip.py";
  print "\nInstalling pip on the system\n";
  system("sudo","python","$dirtoPythonpip");
  print "\nUpgrading Numpy\n";
  system("sudo","easy_install","--upgrade","numpy");
  print "\nUpgrading Scipy\n";
  system("sudo","easy_install","--upgrade","scipy");
  print "\nInstalling Pandas\n";
  system("sudo","pip","install","pandas");
  print "\nInstalling Scikit\-Learn\n";
  system("sudo","pip","install","scikit-learn");
  my $dirtoPython=$cwd."\/"."Modules"."\/"."PCA_Samples.py";
  system("python","-W","ignore","$dirtoPython","$file") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nPython run Complete\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\.\n";
  print "\nPCA results are saved in the directory where expression is\n";
 }
}
######################################### MODULE END ###############################


####################################### NMF CLUST MODULE START #####################
sub nmf
{
 use Cwd;
 my $cwd = getcwd;
 print "\nNMF Clustering module loaded\n";
 my $file=@_[0];chomp $file;
 if($file eq "")
 {
  print "\nYou have forgot to give path to file from command line\n";
  print "\nPlease provide the path to the file \.\. You can drag and drop the file from folder window\n";
  $file=<stdin>;chomp $file;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $path;my $counter_path=0;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."NMF.r";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 print "\nIf more than 1000 genes and 14 samples \.\.\. estimated running time is 5 to 10 mins or more\n";
 system("Rscript.bat","script","$dirtoR","$path","$filename") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 print "\nR Run Complete\.\.\.\.\.\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nNMF ConsensusMap saved in $path\n";
}
#################################### MODULE END ####################################


#################################### FETCH SRA MODULE START ########################
sub fetchsra
{
 use Cwd;
 my $cwd = getcwd;
 print "\nFetchSRA module loaded\n";
 my $path=@_[0];chomp $path;my $SRAid=@_[1];chomp $SRAid;
 if($path eq "")
 {
  print "\nYou have forgot to give path where SRA files have to be donloaded\n";
  print "\nPlease provide the path \.\. You can drag and drop the folder from folder window\n";
  $path=<stdin>;chomp $path;
 }
 if($SRAid eq "")
 {
  print "\nYou have forgot to provide SRA ID\n";
  print "\nPlease provide the SRA ID\n";
  $SRAid=<stdin>;chomp $SRAid;
 }
 $path =~ s/\\/\//g;
 my $start_time=time();
 my $dirtoR=$cwd."\/"."Modules"."\/"."SRA_DATA_BULK_DOWNLOAD.r";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 print "\nDownloading time depends on Internet Connection speed \.\.\. 	If downloading huge data files connect to a fast internet connection\n";
 system("Rscript.bat","script","$dirtoR","$path","$SRAid") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 print "\nR Run Complete\.\.\.\.\. SRA FILES ARE DOWNLOADED\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\. Please see $path for files\n";
}
################################### MODULE END ######################################


################################## FETCH GEO MODULE START ###########################
sub fetchgeo
{
 use Cwd;
 my $cwd = getcwd;
 print "\nFetchGEO module loaded\n";
 my $path=@_[0];chomp $path;my $GEOid=@_[1];chomp $GEOid;
 if($path eq "")
 {
  print "\nYou have forgot to give path where GEO files have to be donloaded\n";
  print "\nPlease provide the path \.\. You can drag and drop the folder from folder window\n";
  $path=<stdin>;chomp $path;
 }
 if($GEOid eq "")
 {
  print "\nYou have forgot to provide GEO ID\n";
  print "\nPlease provide the GEO ID\n";
  $GEOid=<stdin>;chomp $GEOid;
 }
 $path =~ s/\\/\//g;
 if($GEOid =~/GSM/)
 {
  my $value="GSM";
  my $start_time=time();
  my $dirtoR=$cwd."\/"."Modules"."\/"."GEO_DATA_DOWNLOAD.r";
  print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
  system("Rscript.bat","script","$dirtoR","$path","$GEOid","$value") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR Run Complete\.\.\.\.\. $GEOid related MetaData and Expression files are ready\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\. Please see $path for files\n";
 }
 if($GEOid =~/GDS/)
 {
  my $value="GDS";
  my $start_time=time();
  my $dirtoR=$cwd."\/"."Modules"."\/"."GEO_DATA_DOWNLOAD.r";
  print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
  system("Rscript.bat","script","$dirtoR","$path","$GEOid","$value") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR Run Complete\.\.\.\.\. $GEOid related MetaData and Expression files are ready\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\. Please see $path for files\n";
 }
 if($GEOid =~/GSE/)
 {
  my $value="GSE";
  my $start_time=time();
  my $dirtoR=$cwd."\/"."Modules"."\/"."GEO_DATA_DOWNLOAD.r";
  print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
  system("Rscript.bat","script","$dirtoR","$path","$GEOid","$value") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
  print "\nR Run Complete\.\.\.\.\. $GEOid related MetaData and Expression files are ready\n";
  my $end_time=time();
  my $total_time=$end_time-$start_time;
  print "\nRun Complete in $total_time seconds \.\.\. Please see $path for files\n";
 }
}
########################################### MODULE END ########################


####################################### INTERACTIVE SCATTER PLOT MODULE START ################
sub interactivesp
{
 use Cwd;
 my $cwd = getcwd;
 print "\nInteractiveScatterPlot module loaded\n";
 my $file=@_[0];my $colx=@_[1];my $coly=@_[2];my $colenrichment=@_[3];
 chomp $file;chomp $colx;chomp $coly;chomp $colenrichment;
 if($file eq "")
 {
  print "\nYou have forgot to provide path to the file\n";
  print "\nPlease provide path to the file \.\. You can drag and drop the file from the folder window\n";
  $file=<stdin>;chomp $file;
 }
 if($colx eq "")
 {
  print "\nYou have forgot to provide column number for x\-axis values\n";
  print "\nPlease provide column number for x\-axis values\n";
  $colx=<stdin>;chomp $colx;
 }
 if($coly eq "")
 {
  print "\nYou have forgot to provide column number for y\-axis values\n";
  print "\nPlease provide column number for y\-axis values\n";
  $coly=<stdin>;chomp $coly;
 }
 if($colenrichment eq "")
 {
  print "\nYou have forgot to provide column number for color factorization\. You can also say No for no color factorization\n";
  print "\nPlease provide column number for color factorization\n";
  $colenrichment=<stdin>;chomp $colenrichment;
 }
 $file =~ s/\\/\//g;
 my $start_time=time();
 my $path;my $counter_path=0;
 my @filepath=split(/\//,$file);
 my $filename=pop(@filepath);
 foreach my $m(@filepath)
 {
  if($m eq "")
  {}
  else
  {
   $counter_path++;
   if($counter_path == 1)
   {
    $path=$path.$m;
   }
   else
   {
    $path=$path."\/".$m;
   }
  }
 }
 my $dirtoR=$cwd."\/"."Modules"."\/"."Interactive_ScatterPlot.r";
 print "\nRunning R in Background \(please be patient\)\.\.\.\.\.\n";
 system("Rscript.bat","script","$dirtoR","$path","$filename","$colx","$coly","$colenrichment") ==0 or die "\nExcecution Stopped because of errors \.\.\. Please See Possible Errors Section of README or Contact CSBB for bugs and issues\n";
 print "\nR Run Complete\.\.\.\.\.\n";
 my $end_time=time();
 my $total_time=$end_time-$start_time;
 print "\nRun Complete in $total_time seconds \.\.\.\n";
 print "\nBoth Interactive and Static ScatterPlots are saved in $path\n";
}
######################################## MODULE END ###########################