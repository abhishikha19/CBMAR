#!/usr/bin/perl
############################### Header Information ##############################
require 'cgi.perl';
use CGI;;
$query = new CGI;
&ReadParse;
print &PrintHeader;
################################ Reads Input Data ##############################
my($name1,$name2,$name3,$name4,$name5,$name6,$name7,$name8);
$name1 = $query->param('first_name');
$name2 = $query->param('last_name');
$name3 = $query->param('email');
$name4 = $query->param('gene');
$name5 = $query->param('location');
$name6 = $query->param('resistance');
$name7 = $query->param('reference');
$name8 = $query->param('comments');
#################Validation Of Input Sequence Data (file upload) ###################################
my @all;
if($name1 ne '')
{
    $name1=~m/^.*(\\|\/)(.*)/;
    $all[0]="$name1";
  }
if($name2 ne '')
{
   $all[1]="$name2";
}
if($name3 ne '')
{
    $all[2]="$name3";
}
if($name4 ne '')
{
    $all[3]="$name4";
}
if($name5 ne '')
{
    $all[4]="$name5";
}
if($name6 ne '')
{
    $all[5]="$name6";
}
if($name7 ne '')
{
    $all[6]="$name7";
}
if($name8 ne '')
{
    $all[7]="$name8";
}
##############ACTUAL PROCESS BEGINS FROM HERE#######################
#$input= "/webservers/cgi-bin/lactamasedb";
$ran= int(rand 10000);
$dir ="/webservers/cgidocs/mkumar/temp/shikha/submit_$ran";
system "mkdir $dir";
system "chmod 777 $dir";
open (FH,">$dir/input.txt");
print FH "Firstname:$all[0]\nLastName:$all[1]\nEmail:$all[2]\nGene Information:$all[3]\nOrigin:$all[4]\nResistance:$all[5]\nRefrerence:$all[6]\nComments:$all[7]";
#print"$dir/input.txt";
close FH;
print "<html><HEAD>\n";
print "</HEAD><body bgcolor=\'\#F7E9BB\'>\n";
print "<center><h2><font color='#FF0000'><b><br>YOUR INFORMATION HAS BEEN SUBMITTED AND WOULD BE INCLUDED IN THE DATABASE AFTER VERIFICATION.......</b></h2></p></center>\n";
print "<center><h3><font color='#FF0000'><i><b>Thanks for submission!!!!</b></i></font></h3></center>\n";
print "<center><br><br><br><br><br><br><br><h3><font color='#FF0000'><i><b>Kindly visit again</b></i></font></h3></center>\n";


