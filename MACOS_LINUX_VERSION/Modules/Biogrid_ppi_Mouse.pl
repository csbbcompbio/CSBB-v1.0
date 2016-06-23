#!/usr/bin/perl
use Cwd;
my $cwd = getcwd;
my $newcwd=$cwd."\/"."Modules";
my $path=$ARGV[0]; chomp $path; ##### path
my $file=$ARGV[1]; chomp $file;  ####  Gene List File
my %hash;my %res;my @a;my @b;my @c;my @d;my $var;my $count;my $var1;my $count1;my %temphash;
print "\nReading the Biogrid file\n";
open(OUT,">$newcwd/interaction_proteins.txt");
open(F,"$newcwd/BIOGRID-ORGANISM-Mus_musculus-3.4.134.tab2.txt");
while(my $data = <F>)
{
 chomp $data;
 my @arr=split(/\t/,$data);
 if(($arr[7] eq "")||($arr[8] eq ""))
 {}
 else
 {
  print OUT "$arr[7]\t$arr[8]\t$arr[9]\t$arr[10]\n";
 }
}
print "\nGenerated interactions file\n";
close F;
close OUT;
open(F,"$path/$file");
while(my $data = <F>)
{
 chomp $data;
 if($data eq "")
 {}
 else
 {
  $hash{$data}=0;
 }
}
print "\nRead Genes file\n";
close F;
open(R,"$newcwd/interaction_proteins.txt");
while(my $data = <R>)
{
 chomp $data;
 my @arr=split(/\t/,$data);
 push(@a,$arr[0]);
 push(@b,$arr[1]);
 push(@c,$arr[2]);
 push(@d,$arr[3]);
}
close R;
my $tempinteraction=$newcwd."\/"."interaction_proteins.txt";
unlink $tempinteraction;
print "\nWriting interactions of genes to all known proteins in temporary data structure\n";
foreach my $m(keys %hash)
{
 my $nam=uc($m);
 for($i=0;$i<=@a;$i++)
 {
  my $nam1=uc($a[$i]);my $nam2=uc($b[$i]);
  if($nam eq $nam1)
  {
   $temphash{$m}{$b[$i]}=0;
  }
  else
  {
   if($c[$i] eq "")
   {}
   else
   {
    my @arr=split(/\|/,$c[$i]);
	foreach my $u(@arr)
	{
	 my $nam3=uc($u);
	 if($nam eq $nam3)
	 {
	  $temphash{$m}{$b[$i]}=0;
	 }
	}
   }
  }
  if($nam eq $nam2)
  {
   $temphash{$m}{$a[$i]}=0;
  }
  else
  {
   if($d[$i] eq "")
   {}
   else
   {
    my @arr=split(/\|/,$d[$i]);
	foreach my $o(@arr)
	{
	 my $nam4=uc($o);
	 if($nam eq $nam4)
	 {
	  $temphash{$m}{$a[$i]}=0;
	 }
	}
   }
  }
 }
}
foreach my $q(keys %temphash)
{
 if($q eq "")
 {}
 else
 {
  foreach my $w(keys %{$temphash{$q}})
  {
   if($w eq "")
   {}
   else
   {
    foreach my $u(keys %hash)
	{
	 if(uc($w) eq uc($u))
	 {
	  $res{$q}{$w}=0;
	 }
	}
   }
  }
 }
}
my @arrf=split(/\.txt/,$file);
my $name1=$arrf[0]."\_"."interactions_all_proteins_using_BIOGRID";
my $name2=$arrf[0]."\_"."interactions_all_proteins_using_BIOGRID_in_table_format";
open(OUT,">$path/$name1.txt");
open(OUT1,">$path/$name2.txt");
print OUT "Gene\tProtein\n";
print OUT1 "Gene\tDegree\tProteins\_Interacting\n";
print "\nwriting interatcions of genes to all known proteins found in biogrid\n";
foreach my $m(keys %temphash)
{
 if($m eq "")
 {}
 else
 {
  foreach my $n(keys %{$temphash{$m}})
  {
   if($n eq "")
   {}
   else
   {
    if($n eq $m)
	{}
	else
	{
    if(exists $temphash{$n}{$m})
	{
	 delete $temphash{$n}{$m};
	}
   }
  }
 }
}
}
foreach my $a(keys %temphash)
{
 if($a eq "")
 {}
 else
 {
  $var="";$count=0;
  foreach my $b(keys %{$temphash{$a}})
  {
   if($b eq "")
   {}
   else
   {
    $var=$var."\|".$b;
    $count++;
	print OUT "$a\t$b\n";
   }
  }
  if($count > 0)
  {
   print OUT1 "$a\t$count\t$var\n";
  }
 }
}
close OUT;
close OUT1;
foreach my $m(keys %res)
{
 if($m eq "")
 {}
 else
 {
  foreach my $n(keys %{$res{$m}})
  {
   if($n eq "")
   {}
   else
   {
    if($n eq $m)
	{}
	else
	{
    if(exists $res{$n}{$m})
	{
	 delete $res{$n}{$m};
	}
   }
  }
 }
}
}
my $name3=$arrf[0]."\_"."interactions_among_proteins_using_BIOGRID";
my $name4=$arrf[0]."\_"."interactions_among_proteins_using_BIOGRID_in_table_format";
open(OUT,">$path/$name3.txt");
open(OUT1,">$path/$name4.txt");
print OUT "Gene\tProtein\n";
print OUT1 "Gene\tDegree\tProteins\_Interacting\n";
print "\nwriting interatcions of genes among them found in biogrid\n";
foreach my $a(keys %res)
{
 if($a eq "")
 {}
 else
 {
  $var1="";$count1=0;
  foreach my $b(keys %{$res{$a}})
  {
   if($b eq "")
   {}
   else
   {
    $var1=$var1."\|".$b;
    $count1++;
	print OUT "$a\t$b\n";
   }
  }
  if($count1 > 0)
  {
   print OUT1 "$a\t$count1\t$var1\n";
  }
 }
}
close OUT;
close OUT1;
print "\nThanks\n";