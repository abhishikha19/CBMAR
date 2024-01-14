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
if($name1 ne '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name1>) 
    {
	$seqfi .= $_;
    }
}
if($name2 ne '' && $name1 eq ''  && $name3 eq ''  && $name4 eq ''  && $name5 eq ''  && $name6 eq ''  && $name7 eq ''  && $name8 eq '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name2>) 
    {
	$seqfi .= $_;
    }
}
if($name3 ne '' && $name2 eq ''  && $name1 eq ''  && $name4 eq ''  && $name5 eq ''  && $name6 eq ''  && $name7 eq ''  && $name8 eq '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name3>) 
    {
	$seqfi .= $_;
    }
}
if($name4 ne '' && $name2 eq ''  && $name3 eq ''  && $name1 eq ''  && $name5 eq ''  && $name6 eq ''  && $name7 eq ''  && $name8 eq '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name4>) 
    {
	$seqfi .= $_;
    }
}
if($name5 ne '' && $name2 eq ''  && $name3 eq ''  && $name4 eq ''  && $name1 eq ''  && $name6 eq ''  && $name7 eq ''  && $name8 eq '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name5>) 
    {
	$seqfi .= $_;
    }
}
if($name6 ne '' && $name2 eq ''  && $name3 eq ''  && $name4 eq ''  && $name5 eq ''  && $name1 eq ''  && $name7 eq ''  && $name8 eq '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name6>) 
    {
	$seqfi .= $_;
    }
}
if($name7 ne '' && $name2 eq ''  && $name3 eq ''  && $name4 eq ''  && $name5 eq ''  && $name6 eq ''  && $name1 eq ''  && $name8 eq '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name7>) 
    {
	$seqfi .= $_;
    }
}
if($name8 ne '' && $name2 eq ''  && $name3 eq ''  && $name4 eq ''  && $name5 eq ''  && $name6 eq ''  && $name7 eq ''  && $name1 eq '' )
{
    $name1=~m/^.*(\\|\/)(.*)/; 
    while(<$name8>) 
    {
	$seqfi .= $_;
    }
}

##############ACTUAL PROCESS BEGINS FROM HERE#######################
#$input= "/webservers/cgi-bin/lactamasedb";
$ran= int(rand 10000);
$dir ="/webservers/cgidocs/mkumar/temp/shikha/submit_$ran";
system "mkdir $dir";
system "chmod 777 $dir";
open (FH,">$dir/input.txt");
print FH "$seqfi\n";
close FH;
print "<html><HEAD>\n";
print "</HEAD><body bgcolor=\'\#F7E9BB\'>\n";
print "<center><h2><font color='#FF0000'><b><br>YOUR INFORMATION HAS BEEN SUBMITTED AND WOULD BE INCLUDED IN THE DATABASE AFTER VERIFICATION.......</b></h2></p></center>\n";
print "<center><h3><font color='#FF0000'><i><b>Thanks for submission!!!!</b></i></font></h3></center>\n";
print "<center><br><br><br><br><br><br><br><h3><font color='#FF0000'><i><b>Kindly visit again</b></i></font></h3></center>\n";


