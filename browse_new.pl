#!/usr/bin/perl
############################### Header Information ##############################
require 'cgi.perl';
use CGI;;
$query =  new CGI;
&ReadParse;
print &PrintHeader;
################################ Reads Input Data ##############################                                                       
$ran = int(rand 10000);
$dir ="/webservers/cgidocs/mkumar/temp/shikha/lactamase_browse$ran";
system "mkdir $dir";
system "chmod 777 $dir";
##############ACTUAL PROCESS BEGINS FROM HERE#######################
$name = $query->param('name');
#$type = $query->param('type');
################
my @fields =();
@field_no = qw( ID Protein_ID Status Protein_name Gene_name Organism PubMed_ID Protein_family Taxonomic_lineage Protein_existence GO_term Function_r);
##############ACTUAL PROCESS BEGINS FROM HERE#######################                                                                                               
use DBI;
$database="betalactamasedb";
$host="localhost";
$user="abhishikha";
$pw="shikha123";
$dsn ="DBI:mysql:$database:$host";
$connect= DBI->connect("DBI:mysql:$database:$host",$user,$pw);

#$query="select ID, Protein_ID, Status, Protein_name, Gene_name, Organism, PubMed_ID, Protein_family, Taxonomic_lineage, Protein_existence, GO_term function_r  from lactamase  where Protein_ID ='$name' or Status ='$name' or Protein_name ='$name' or Gene_name ='$name' or Organism ='$name'or PubMed_ID ='$name'or Protein_family ='$name'or Taxonomic_lineage ='$name' or Protein_existence ='$name' or GO_term ='$name'or function_r='$name' ";

#$query="select ID,Protein_ID, Status, Protein_name, Gene_name, Organism, PubMed_ID ,Protein_family, Taxonomic_lineage, Protein_existence, GO_term, Function_r from lactamase";
$query="Protein_ID, Protein_family, Status, Protein_name, Gene_name, Organism, PubMed_ID ,, Taxonomic_lineage, Protein_existence, GO_term, Function_r from lactamase";
#print "$query";

$query_handle = $connect->prepare($query) or die "Here $!";
$rv=$query_handle->execute || die "$!";
@row=$query_handle->fetchrow_array();
print"<p><iframe align='center' width='1600'height='800'style='border: #FFF2E6' src='../../mkumar/temp/shikha/lactamase_browse$ran/result.html'</iframe></p>";
open(FH, ">>$dir/result.html");
print FH"<table border='1' width=100% table-layout:fixed align='center',cellspacing='2'cellpadding='5'bordercolor='#c86260'bgcolor='#FFF8DC'>\n";
   if ($field_no[0]=~/ID/)
{
    print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>ID</th>\n";
}
if($field_no[1]=~/Protein_ID/)
{
    print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Protein_ID</th>\n";
}
if($field_no[2]=~/Status/)
{
    print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Status</th>\n";
}
if ($field_no[3]=~/Protein_name/)
{
    print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Protein_name</th>\n";
}
if($field_no[4]=~/Gene_name/)
{
	print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Gene_name</th>\n";
}
if ($field_no[5]=~/Organism/)
{
    print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Organism</th>\n";
}
if($field_no[6]=~/PubMed_ID/)
{
    print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>PubMed_ID</th>\n";
}
if ($field_no[7]=~/Protein_family/)
{
	print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Protein_family</th>\n";
}
if($field_no[8]=~/Taxonomic_lineage/)
{
    print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Taxonomic_lineage</th>\n";
}
if ($field_no[9]=~/Protein_existence/)
{
    print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Protein_existence</th>\n";
}
if($field_no[10]=~/GO_term/)
{
    print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>GO_term</th>\n";
}
if($field_no[11]=~/Function_r/)
{
    print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Function_r</th>\n";
}

while(my(@row)=$query_handle->fetchrow_array)
{
   print FH"<tr>\n";
   foreach my $val(@row)
   {
       print FH"<td>$val</td>\n";
   }
   print FH "</tr>\n";
}
print FH "</table>\n";
close(FH);
$rc = $query_handle->finish;
exit(0);


