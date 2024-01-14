#!/usr/bin/perl
############################### Header Information ##############################
require 'cgi.perl';
use CGI;
my $query = CGI->new;
&ReadParse;
print &PrintHeader;
################################ Reads Input Data ##############################
$ran = int(rand 10000);
$dir ="/webservers/cgidocs/mkumar/temp/shikha/lact$ran";
system "mkdir $dir";
system "chmod 777 $dir";
$type=$query->param('type');
$text=$query->param('Query');

$keyword= $query->param('Query');
#print "-5- $keyword\n";

$Representative_Enzyme_search= $query->param('Enzyme');
$Representative_Enzyme_display= $query->param('Enzyme_1');

$Type_bacteria_search = $query->param('Gram_phenotype');
$Type_bacteria_display = $query->param('Gram_phenotype_1');

$Origin_of_name_search= $query->param('Taxonomy');
$Origin_of_name_display= $query->param('Taxonomy_1');

$Genus_search= $query->param('Organisam');
$Genus_display= $query->param('Organisam_1');

$Gene_location_search=$query->param('Gene_location');
$Gene_location_display=$query->param('Gene_location_1');

$PDB_code_search =$query->param('PDB_structure');
$PDB_code_display =$query->param('PDB_structure_1');

$Inhibitors_Resistance_search=$query->param('Inhibitor_Resistance');
$Inhibitors_Resistance_display=$query->param('Inhibitor_Resistance_1');

$Hydrolyzing_profile_search=$query->param('Hydrolysis_profile');
$Hydrolyzing_profile_display=$query->param('Hydrolysis_profile_1');

$ALL_search=$query->param('ALL');
$ALL_display=$query->param('ALL_1');

#print "=== $ALL_display ===";

my @search_fields =();
my @display_fields =();

if($ALL_search eq 'ON')
{
    #print "All_search opted =\n";
    @search_fields=("Variants","Gram_Phenotype","Origin_of_Name","Genus","Gene_Location","PDB_code","Inhibitors_Resistance","Hydrolyzing_profile");
}
elsif($ALL_search ne 'ON')
{
    if($Representative_Enzyme_search eq 'ON')
    {
	$search_fields[$a]='Representative_Subclass';
	$a++;
    }
    if($Type_bacteria_search eq 'ON')
    {
	$search_fields[$a]='Gram_Phenotype';
	$a++;
    }
    if($Origin_of_name_search eq 'ON')
    {
	$search_fields[$a]='Origin_of_Name';
	$a++;
    }
    if($Genus_search eq 'ON')
    {
	$search_fields[$a]='Genus';
	$a++;
    }
    if($Gene_location_search eq 'ON')
    {
	$search_fields[$a]='Gene_Location';
	$a++;
    }
    if($PDB_code_search eq 'ON')
    {
	$search_fields[$a]='PDB_code';
	$a++;
    }
    if($Inhibitors_Resistance_search eq 'ON')
    {
	$search_fields[$a]='Inhibitors_Resistance';
	$a++;
    }
    if($Hydrolyzing_profile_search eq 'ON')
    {
	$search_fields[$a]='Hydrolyzing_profile';
	$a++;
    }
}



$display_fields[0]='ID'.',Ambler_Class,Representative_Subclass';
$b=1;
if($ALL_display eq "ON")
{
    #print "All_display opted =\n";
    @display_fields=("$display_fields[0]","Variants","Gram_Phenotype","Origin_of_Name","Genus","Gene_Location","PDB_code","Inhibitors_Resistance","Hydrolyzing_profile");
}
if($ALL_display eq '')
{
    if($Representative_Enzyme eq 'ON')
    {
	$display_fields[$b]='Variants';
	#print "+ $display_fields[$b] + ";
	$b++;

    }
    if($Type_bacteria_display eq 'ON')
    {
	$display_fields[$b]='Gram_Phenotype';
	$b++;
    }
    if($Origin_of_name_display eq 'ON')
    {
	$display_fields[$b]='Origin_of_Name';
	$b++;
    }
    if($Genus_display eq 'ON')
    {
	$display_fields[$b]='Genus';
	$b++;
    }
    if($Gene_location_display eq 'ON')
    {
	$display_fields[$b]='Gene_Location';
	$b++;
    }
    if($PDB_code_display eq 'ON')
    {
	$display_fields[$b]='PDB_code';
	$b++;
    }
    if($Inhibitors_Resistance_display eq 'ON')
    {
	$display_fields[$b]='Inhibitors_Resistance';
	$b++;
    }
    if($Hydrolyzing_profile_display eq 'ON')
    {
	$display_fields[$b]='Hydrolyzing_profile';
	$b++;
    }
}

#print "-1- @search_fields\n";
#print "-2- @display_fields\n";

my $query_search_fields= join(",",@search_fields);
my $query_display_fields= join(",",@display_fields);
#print "-3- $query_search_fields\n";
#print "-4- $query_display_fields\n";

$search_query="Select $query_display_fields from betalactamase where $search_fields[0] LIKE \'%$keyword%\'";
for($c=1;$c<=$#search_fields;$c++)
{
    $search_query="$search_query"." or $search_fields[$c] LIKE \'%$keyword%\'";
}
#print "-6- $search_query\n";


system "cat 1.html >>$dir/result.html";
open(OUT, ">>$dir/result.html");


print OUT "<div align='center'><table width='1200'><tr bgcolor='#D2D3D1'>\n";
print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>ID</font></td>\n";
print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Ambler Class</font></td>\n";
print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Family</font></td>\n";


foreach $field_no(@display_fields)
{
    if($field_no=~/Representative_Subclass/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Fingerprint</font></td>\n";
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Active-site</font></td>\n";

    }
    if($field_no=~/Gram_Phenotype/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Gram Phenotype</font></td>\n";
    }
    if($field_no=~/Origin_of_Name/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Origin of Name</font></td>\n";
    }
    if($field_no=~/Gene_Location/)
    { 
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Gene Location (P=plasmid, C=chromosomal)</font></td>\n";
    }
    if($field_no=~/Inhibitors_Resistance/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Inhibitor Resistance</font></td>\n";
    }
    if($field_no=~/Genus/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Genera in which Family is Reported</font></td>\n";
    }
    if($field_no=~/Hydrolyzing_profile/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Hydrolyzing Profile</font></td>\n";
    }
    if($field_no=~/Variants/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>Variants</font></td>\n";
    }
    if($field_no=~/PDB_code/)
    {
	print OUT"<td align='center'  height='34'><font size='2' color='#0066FF' face='Times New Roman'>PDB-ID</font></td>\n";
    }
}


use DBI;
use DBD::mysql;
$database="betalactamasedb";
$host="localhost";
$user ="abhishikha";
$pw = "shikha123";
$dsn ="DBI:mysql:$database:$host";
$connect = DBI->connect("DBI:mysql:$database:$host",$user, $pw);

$query_handle = $connect->prepare($search_query) or die "Here $!";
$rv=$query_handle->execute || die "$!";
$count=0;
while(my(@row)=$query_handle->fetchrow_array)
{
    #print "-7- @row\n";
    $count++;
    
    if($count%2==1)
    {
	print OUT"<tr bgcolor='#F3F3E9'>";
    }
    elsif($count%2==0)
    {
	print OUT"<tr bgcolor='#EBEBEB'>";
    }

    for($z=0;$z<=$#row;$z++)
    {
	$row[$z]=~ s/,/, /g;
	$row[$z]=~ s/Chromosomal/C/g;
	$row[$z]=~ s/Plasmid/P/g;


	if($z == 1)
	{
	    if($row[$z]=~ m/B[1-3]/)
	    {
		$row[$z]='B/'."$row[$z]";
	    }
	}
	if($z == 2)
	{
	    $detail_name="$row[$z]".'_detail_new.html';
	    print OUT"<td align='center'><a href=\"$detail_name\" target=\"_blank\"><font size='2'>$row[$z]</font></a></td>";

	    print OUT"<td align='center'>";
	    $fam_name='name='."$row[$z]".':#';

	    $fp=`grep -i "$fam_name" /webservers/cgi-bin/lactamasedb/fingerprint_active_info`;
	    @fp_ac=split('#',$fp);
	    chomp($fp_ac[4]);
	    if(-e "/webservers/cgidocs/mkumar/lactamasedb/graphical_all/$fp_ac[4]")
	    {
		print OUT"<a href=\"../../../lactamasedb/$fp_ac[3]\"><img border='0' src=\"../../../lactamasedb/graphical_all/$fp_ac[4]\" width=\"80\" height=\"40\"\"</a></td>";
	    }
	    elsif(!(-e "/webservers/cgidocs/mkumar/lactamasedb/graphical_all/$fp_ac[4]"))
	    {
		print OUT "None</td>";
	    }
	    print OUT"<td><a href=\"../../../lactamasedb/$fp_ac[1]\"><img border='0' src=\"../../../lactamasedb/graphical_all/$fp_ac[2]\" width=\"80\" height=\"20\"\"</a></td>";
	} 
	else
	{
	    print OUT"<td align='center'><font size='2'>$row[$z]</font></td>";
	}
   }
    print OUT"</tr>";
}
print OUT"</table>";
print OUT"<div id='footer'><p>CBMAR is maintained by Department of Biophysics, University of Delhi South Campus. We acknowledge your comments or contribution to this resources. Please send your sugestions to Dr. Manish Kumar <font color='#0066CC'>(Email:manish at south dot du dot ac dot in)</font></p></div>\n";
print OUT"</body></html>";
close OUT;
$rc = $query_handle->finish;


print "<html>\n";
print "<head>\n";
print "<title>CBMAR:: Search Result</title>\n";
print "<meta http-equiv=\"refresh\" content=\"0;URL=http://10.154.4.31/mkumar/temp/shikha/lact$ran/result.html\">\n";
print "</head><body></body></html>\n";

exit;

