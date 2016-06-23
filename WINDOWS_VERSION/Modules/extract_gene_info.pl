 #!/usr/bin/perl
 my $file1=$ARGV[0];my $file2=$ARGV[1];
 my $counter=0;my $header;my %hash;my %hash1;my $path;my $counter_path;
 my @filepath=split(/\//,$file2);
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
 print "\nReading Expression\/Information file\n";
 open(F,"$file1");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  $counter++;
  if($counter == 1)
  {
   $header = $data;
  }
  else
  {
   my @array=split(/\t/,$data,2);
   $hash{$array[0]}{$array[1]}=0;
  }
 }
 close F;
 print "\nReading Gene List file\n";
 open(F,"$file2");
 while(my $data = <F>)
 {
  $data =~ s/^\s+|\s+$//g;
  chomp $data;
  if($data eq "")
  {}
  else
  {
   $hash1{$data}=0;
  }
 }
 close F;
 print "\nExtracting Expression\/Information of genes of interest\n";
 my $outfile = "Expression"."\_".$filename;
 open(OUT,">$path/$outfile");
 print OUT "$header\n";
 foreach my $m(keys %hash1)
 {
  if(exists $hash{$m})
  {
   foreach my $n(keys %{$hash{$m}})
   {
    print OUT "$m\t$n\n";
   }
  }
 }
 close OUT;