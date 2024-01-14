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
if($name1 ne '')
{
    $name1=~m/^.*(\\|\/)(.*)/;
    while(<$name1>)
    {
        $seqfi .= $_;
    }
}
if($name2 ne '')
{
   $seqfi="$name2";
}

##############ACTUAL PROCESS BEGINS FROM HERE#######################
#$input= "/webservers/cgi-bin/lactamasedb";
$ran= int(rand 10000);
$dir ="/webservers/cgidocs/mkumar/temp/shikha/submit_$ran";
system "mkdir $dir";
system "chmod 777 $dir";
open (FH,">$dir/input.txt");
print FH "$seqfi\n";
print"$dir/input.txt";
close FH;
print "<html><HEAD>\n";
print "</HEAD><body bgcolor=\'\#F7E9BB\'>\n";
print "<center><h2><font color='#FF0000'><b><br>YOUR INFORMATION HAS BEEN SUBMITTED AND WOULD BE INCLUDED IN THE DATABASE AFTER VERIFICATION.......</b></h2></p></center>\n";
print "<center><h3><font color='#FF0000'><i><b>Thanks for submission!!!!</b></i></font></h3></center>\n";
print "<center><br><br><br><br><br><br><br><h3><font color='#FF0000'><i><b>Kindly visit again</b></i></font></h3></center>\n";


