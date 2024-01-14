#!/usr/bin/perl
########################################program will convert two line fasta file into orignal format##############
open (FH, "uniclass.fasta") or die;
while ($line=<FH>)
{
    chomp ($line);
if ($line=~m/^>/)
{
    print "$line\n";
    $next=<FH>;
    chomp ($next);
    @ar=split(//,$next);
}

for ($a=0;$a<=$#ar;$a=$a+60)
{
#   print "$ar[$a]";
    $start[$y]=$a;
    $aa=substr($next,$start[$y],60);
print "$aa\n";
    $y++;
}
}
