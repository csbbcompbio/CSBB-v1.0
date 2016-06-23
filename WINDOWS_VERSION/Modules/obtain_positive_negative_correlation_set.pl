  #!/usr/bin/perl
  my $path=$ARGV[0];my $filename=$ARGV[1];my $Rfile=$ARGV[2];my $threshold=$ARGV[3];
  chomp $path;chomp $filename;chomp $Rfile;chomp $threshold;
  my $negativethreshold=-1*$threshold;
  my $counter=0;my $counter1=0;my @genes;my %positivehash;my %negativehash;
  print "\nStoring all genes\n";
  open(F,"$Rfile");
  while(my $data = <F>)
  {
   chomp $data;
   $counter++;
   if($counter == 1)
   {}
   else
   {
    my @arr=split(/\t/,$data,2);
    push(@genes,$arr[0]);
   }
  }
  close F;
  open(F,"$Rfile");
  while(my $data = <F>)
  {
   chomp $data;
   $counter1++;
   if($counter1 ==1)
   {}
   else
   {
    my @arr=split(/\t/,$data,2);
    my @arr1=split(/\t/,$arr[1]);
    print "Obtaining Positve and Negative Correlations for $arr[0]\r";
    for(my $i=0;$i<=@arr1;$i++)
    {
     if($arr1[$i] eq "")
     {}
     else
     {
      if($arr1[$i] eq "NA")
      {}
      if($arr1[$i] >= $threshold)
      {
       $positivehash{$arr[0]}{$genes[$i]}=0;
      }
      if($arr1[$i] <= $negativethreshold)
      {
       $negativehash{$arr[0]}{$genes[$i]}=0;
      }
     }
    }
   }
  }
  close F;
  my $var;my $countgenes;
  my $outfile1="PostivelyCorrelated"."\_".$filename;
  my $outfile2="NegativelyCorrelated"."\_".$filename;
  open(OUT1,">$path/$outfile1");
  open(OUT2,">$path/$outfile2");
  print OUT1 "Gene\tDegree\tPostivelyCorrelated Genes\n";
  print OUT2 "Gene\tDegree\tNegativelyCorrelated Genes\n";
  foreach my $m(keys %positivehash)
  {
   if($m eq "")
   {}
   else
   {
    $var="";$countgenes=0;
    foreach my $n(keys %{$positivehash{$m}})
    {
     $countgenes++;
     $var=$var."\|".$n;
    }
    print OUT1 "$m\t$countgenes\t$var\n";
   }
  }
  foreach my $m(keys %negativehash)
  {
   if($m eq "")
   {}
   else
   {
    $var="";$countgenes=0;
    foreach my $n(keys %{$negativehash{$m}})
    {
     $countgenes++;
     $var=$var."\|".$n;
    }
    print OUT2 "$m\t$countgenes\t$var\n";
   }
  }
  close OUT1;
  close OUT2;