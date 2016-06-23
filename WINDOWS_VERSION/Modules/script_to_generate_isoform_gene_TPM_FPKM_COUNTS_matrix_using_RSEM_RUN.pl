#!/usr/bin/perl
my @samples;my %genes;my %main;my %map;my %result;my $val;my $valm;my $header;my $countfpkmfilter;my %map1;
open(F,"hg19_map.txt");
while(my $data = <F>)
{
 $data =~ s/^\s+|\s+$//g;
 chomp $data;
 my @arr=split(/\t/,$data);
 if(($arr[0] eq "")||($arr[4] eq ""))
 {}
 else
 {
  $map1{$arr[0]}{$arr[4]}=0;
 }
}
close F;
my $dir=$ARGV[0];
chomp $dir;
opendir(F,"$dir");
foreach my $f(readdir(F))
{
 if($f =~/.genes.results/)
 {
  my @arrf=split(/\.genes.results/,$f);
  my @arrf1=split(/\_/,$arrf[0]);
  push(@samples,$arrf1[3]);
  open(R,"$dir/$f");
  while(my $data = <R>)
  {
   $data =~ s/^\s+|\s+$//g;
   chomp $data;
   my @arr=split(/\t/,$data);
   my @arr1=split(/\,/,$arr[1]);
   if(exists $map1{$arr[0]})
   {
    foreach my $m(keys %{$map1{$arr[0]}})
    {
       my $var1=$m."\<".$arr[0]."\>";
       $genes{$var1}=0;
       my $var=$arrf1[3]."\t".$arr[5];
       $main{$var1}{$var}=0;
    }
   }
   else
   {
    my $var1="NA"."\<".$arr[0]."\>";
    $genes{$var1}=0;
    my $var=$arrf1[3]."\t".$arr[5];
    $main{$var1}{$var}=0;
   }
  }
  close R;
 }
}
closedir F;
foreach my $m(keys %genes)
{
 if(exists $main{$m})
 {
  $valm="";
  foreach my $a(@samples)
  {
   $val="";
   foreach my $n(keys %{$main{$m}})
   {
    my @arr=split(/\t/,$n);
    if($a eq $arr[0])
    {
     $val=$arr[1];
    }
   }
   if($val eq "")
   {
    $valm=$valm."\t"."NA";
   }
   else
   {
    $valm=$valm."\t".$val;
   }
  }
  $result{$m}{$valm}=0;
 }
}
foreach my $a(@samples)
{
 if($a eq "")
 {}
 else
 {
  $header=$header."\t".$a;
 }
}
my $mainhead="GENE"."\<"."transcript"."\>".$header;
open(OUT,">All_samples_genes_transcripts_tpm_matrix.txt");
print OUT "$mainhead\n";
foreach my $m(keys %result)
{
 foreach my $n(keys %{$result{$m}})
 {
  print "$m$n\n";
  print OUT "$m$n\n";
 }
}
close OUT;