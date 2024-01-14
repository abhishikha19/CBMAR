#!/usr/bin/perl
##############################program will convert fasta format into two line########################################
open (FH,"uniall.fasta") or die;

while ($line=<FH>)
{
    chomp ($line);
if ($line=~m/^>/)
{
    print "\n$line\n";
}
if ($line!~m/^>/)
{
    print "$line";
}
}
