#!/usr/bin/perl
#####Please provide Gene list file from command line#####
print "\nCopyright Praneet Chaturvedi\n";
print "\nGet Human Orthologs of Xenopus\n";
my $file=$ARGV[0]; #######Gene list file
chomp $file;
my %map;my %genes;my %newgene;my %hash;
print "\nReading Annotations from Joshua\n";
open(F,"Joshua_New_Map.txt");
while(my $data = <F>)
{
 chomp $data;
 my @arr=split(/\t/,$data);
 if(($arr[0] eq "")||($arr[1] eq ""))
 {}
 else
 {
  if($arr[0] =~/Xelaev/)
  {
   my $var=$arr[0]."\."."g";
   $map{$var}=$arr[1];
  }
  else
  {
   $map{$var}=$arr[1];
  }
 }
}
close F;
print "\nAnnotations ready to use\n";
print "\nReading Gene List file\n";
open(F,"$file");
while(my $data = <F>)
{
 chomp $data;
 if($data eq "")
 {}
 else
 {
  $genes{$data}=0;
 }
}
close F;
print "\nMapping genes to Joshua Annotation\n";
foreach my $m(keys %genes)
{
 if(exists $map{$m})
 {
  $newgene{$map{$m}}=0;
 }
 else
 {
  $newgene{$m}=0;
 }
}
print "\nMapping Completed\.\.\.\.\.Now Working on Orthologs\.\.\.\.\n";
foreach my $m(keys %newgene)
{
 if($m =~/Xelaev/)
 {}
 else
 {
  my @arr=split(/\./,$m);
  my $len=scalar(@arr);
  if(($len == 1)||($len == 2))
  {
   $hash{$arr[0]}=0;
  }
  if($len == 3)
  {
   my $var=$arr[0]."\.".$arr[1];
   $hash{$var}=0;
  }
 }
}
my @arrf=split(/\.txt/,$file);
my $name=$arrf[0]."\_"."orthologs";
open(OUT,">$name.txt");
foreach my $m(keys %hash)
{
 if($m eq "")
 {}
 else
 {
  print OUT "$m\n";
 }
}
close OUT;
print "\nOrthoglogs reported in $name\.txt file\n";
print "\nThanks\!\!\!\!\!\!\n";