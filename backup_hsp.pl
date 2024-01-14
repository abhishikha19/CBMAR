#!/usr/bin/perl
############################### Header Information ##############################
require 'cgi.perl';
use CGI;;
$query =  new CGI;
&ReadParse;
print &PrintHeader;
################################ Reads Input Data ##############################                                                       
$ran = int(rand 10000);
$dir ="/webservers/cgidocs/mkumar/temp/shikha/cragdb_hsp$ran";
system "mkdir $dir";
system "chmod 777 $dir";
##############ACTUAL PROCESS BEGINS FROM HERE#######################
$name = $query->param('name');
#$type = $query->param('type');
################
my @fields =();
@field_no = qw(ID Class_r Family Order_r Phylum Organism Protein_name Accession GI Length_r Molecular_weight PI_r Function_r COGID);
##############ACTUAL PROCESS BEGINS FROM HERE#######################                                                                                               
use DBI;
$database="heatshock";
$host="localhost";
$user="abhishikha";
$pw="shikha123";
$dsn ="DBI:mysql:$database:$host";
$connect= DBI->connect("DBI:mysql:$database:$host",$user,$pw);
$query="select ID,Class_r, Family,Order_r,Phylum ,Organism, Protein_name, Accession,GI,Length_r, Molecular_weight,PI_r,Function_r,COGID  from chaperone where Class_r ='$name' or Family ='$name' or Order_r ='$name' or Phylum ='$name'";
$query_handle = $connect->prepare($query) or die "Here $!";
$rv=$query_handle->execute || die "$!";
@row=$query_handle->fetchrow_array();
print"<p><iframe align='center' width='1600'height='800'style='border: #FFF2E6' src='../../mkumar/temp/shikha/cragdb_hsp$ran/result.html'</iframe></p>";
open(FH, ">>$dir/result.html");
print FH"<table border='1' width=100% table-layout:fixed align='center',cellspacing='2'cellpadding='5'bordercolor='#c86260'bgcolor='#FFF8DC'>\n";
   if ($field_no[0]=~/ID/)
    {
     print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>ID</th>\n";
    }
    if($field_no[1]=~/Class_r/)
    {
        print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Class</th>\n";
    }
    if ($field_no[2]=~/Family/)
    {
	print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Family</th>\n";
    }
    if($field_no[3]=~/Order_r/)
    {
	print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Order</th>\n";
    }
    if ($field_no[4]=~/Phylum/)
    {
	print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Phylum</th>\n";
    }
    if($field_no[5]=~/Organism/)
    {
	print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Organism</th>\n";
    }
    
    if ($field_no[6]=~/Protein_name/)
    {
	print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Protein name</th>\n";
    }
    if($field_no[7]=~/Accession/)
    {
	print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Accession</th>\n";
    }
   if ($field_no[8]=~/GI/)
    {
	print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>GI</th>\n";
    }
    if($field_no[9]=~/Length_r/)
    {
	print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>Length</th>\n";
    }
    if ($field_no[10]=~/Molecular_weight/)
    {
	print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Molecular weight</th>\n";
    }
    if($field_no[11]=~/PI_r/)
    {
	print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>PI</th>\n";
    }
    if ($field_no[12]=~ m/Function_r/)
    {
	print FH "<th col width ='25px'bgcolor='#E1D3B1'><font color='#0066FF'>Function</th>\n";
    }
    if($field_no[13] eq 'COGID')
    {
	print FH "<th  bgcolor='#E1D3B1'><font color='#0066FF'>COGID</th>\n";
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


