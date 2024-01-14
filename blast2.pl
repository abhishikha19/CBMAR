#!/usr/bin/perl -w
############################### Header Information ##############################
require 'cgi.perl';
use CGI;;
$query = new CGI;
&ReadParse;
print &PrintHeader;
################################ Reads Inoput Data ##############################
my ($file,$atom,$seqfi,$evalue,$database);
$atom = $query->param('atom');
$file = $query->param('file');
$evalue=$query->param('expect');
$database=$query->param('blastyp');
#################Validation Of Input Sequence Data (file upload) ###################################
if($file ne '' && $atom eq '')
{
    $file=~m/^.*(\\|\/)(.*)/; 
    while(<$file>) 
    {
	$seqfi .= $_;
    }
}
elsif($atom ne '' && $file eq '')
{
    $seqfi= "$atom";
}
##############ACTUAL PROCESS BEGINS FROM HERE#######################
#$input= "/webservers/cgi-bin/lactamasedb";
$ran= int(rand 10000);
$dir ="/webservers/cgidocs/mkumar/temp/shikha/lact_blast$ran";
system "mkdir $dir";
system "chmod 777 $dir";
open (FH,">$dir/input.fasta");
print FH "$seqfi\n";
close FH;
print "<html><HEAD>\n";
print "</HEAD><body bgcolor=\'\#F7E9BB\'>\n";
print "<h2 ALIGN = \'CENTER\'><font color='#071910'>CBLAR Blast Result</font></h2>\n";
#print "$evalue";
if($database eq 'protein')
{
    system "/usr/local/bin/blast-2.2.18/bin/blastall  -p blastp -d /webservers/cgi-bin/lactamasedb/CBMAR_NEW/blaprotein/protein.fasta  -i $dir/input.fasta -e $evalue -T T -o $dir/final.html";
    #system "/usr/bin/perl /webservers/cgi-bin/lactamasedb/aa.pl $dir/test.html >$dir/final.html"; 
}
if($database eq 'nucleotide')
{
    system "/usr/local/bin/blast-2.2.18/bin/blastall  -p blastn -d /webservers/cgi-bin/lactamasedb/CBMAR_NEW/blanuc/nuc.fasta  -i $dir/input.fasta  -e $evalue  -T T -o $dir/final.html";
}
if($database eq 'PDB')
{
    system "/usr/local/bin/blast-2.2.18/bin/blastall  -p blastp -d /webservers/cgi-bin/lactamasedb/CBMAR_NEW/blapdb/pdb.fasta  -i $dir/input.fasta  -e $evalue -T T -o $dir/final.html";
}
#system "/usr/bin/perl /webservers/cgi-bin/lactamasedb/aa.pl $dir/test.html >$dir/final.html";
print"<iframe align='center'width='1300'height='660' src='../../mkumar/temp/shikha/lact_blast$ran/final.html'</iframe>\n";
