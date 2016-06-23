#!/usr/bin/perl
use List::Util qw(sum);
my %hash;my $header;my $countfpkmfilter;my $expression;my $length;my $percensam;
my $file=$ARGV[0];#expression file
chomp $file;
open(F,"$file");
while(my $data =<F>)
{
 $data =~ s/^\s+|\s+$//g;
 chomp $data;
 if($data =~/GENE<transcript>/)
 {
  $header=$data;
 }
 else
 {
  my @arr=split(/\t/,$data,2);
  my @arr1=split(/\</,$arr[0]);
  my $var=$arr1[1]."\t".$arr[1];
  $hash{$arr1[0]}{$var}=0;
  my @len=split(/\t/,$arr[1]);
  $length=scalar(@len);
 }
}
close F;
$percensam=int(0.9*$length);
my @arrf=split(/\.txt/,$file);
my $name=$arrf[0]."\_"."summed"."\_"."expression"."\_"."filtered"."\_"."90percent"."\_"."2tpm";
open(OUT1,">$name.txt");
print OUT1 "$header\n";
foreach my $m(keys %hash)
{
 if($m eq "NA")
 {}
 else
 {
  $expression="";
  for(my $i=0;$i<=($length-1);$i++)
  {
   $value=0;
   foreach my $n(keys %{$hash{$m}})
   {
    my @arr=split(/\t/,$n);
    shift(@arr);
    $value=$value+$arr[$i];
   }
   my $newval=$value;
   $expression=$expression."\t".$newval;
  }
  my @arrexp=split(/\t/,$expression);
  shift(@arrexp);
  my $sumofexp=sum(@arrexp);
  $countfpkmfilter=0;
  foreach my $a(@arrexp)
  {
   if($a eq "")
   {}
   else
   {
    if($a > 2)
    {
     $countfpkmfilter++;
    }
   }
  }
  if($sumofexp > 0)
  {
   if($countfpkmfilter >= $percensam)
   {
    print "$m$expression\n";
    print OUT1 "$m$expression\n";
   }
  }
 }
}
close OUT1;