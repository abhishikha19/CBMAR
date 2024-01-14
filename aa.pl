#!/usr/bin/perl
#################################program to add hyperlink in text fasta file################################
open (FH,"$ARGV[0]") or die "$!";
#open(FH,"test.txt")or die"$!";
while ($line=<FH>)
{
    chomp($line);
     #print"$line\n";
    if(($line!~m/^sp/)&&($line!~m/^tr/)&&($line!~m/^gi/)&&($line!~m/^>/))
     {
      print"$line\n";
      }
  if(($line=~m/^sp/i)||($line=~m/^tr/i)||($line=~m/^>/i))

   {
     @id=split(/\|/,$line);
    # print"$id[0]|<a href='http://www.uniprot.org/uniprot/$id[1]'>$id[1]</a>|$id[2]|<a href='#$id[1]'>$id[3]</a>|\n";
     print"$id[0]|<a href='http://www.uniprot.org/uniprot/$id[1]'>$id[1]</a>|$id[2]|$id[3]\n";   
    }
   elsif(($line=~m/^gi/i)||($line=~m/^>/i))
  

   {
    @id=split(/\|/,$line);
    # print"$id[0]|<a href='http://www.uniprot.org/uniprot/$id[1]'>$id[1]</a>|$id[2]|<a href='#$id[1]'>$id[3]</a>|\n";                                                                        
      print"$id[0]|<a href='http://www.ncbi.nlm.nih.gov/nuccore/$id[1]'>$id[1]</a>|$id[2]|$id[3]|$id[4]|$id[5]\n";
}





}
close FH;
