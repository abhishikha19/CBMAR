#!/usr/bin/perl -w
############################### Header Information ##############################
require 'cgi.perl';
use CGI;;
$query = new CGI;
&ReadParse;
print &PrintHeader;
################################ Reads Inoput Data ##############################
 my ($file,$atom,$seqfi);
 my $atom = $query->param('atom');
 my $file = $query->param('file');
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
my $infut="/webservers/cgi-bin/lactfp";
my $memefile="/webservers/cgi-bin/lactfp/memeresult";
my $ran= int(rand 10000);
my $dir ="/webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran";
system "mkdir $dir";
system "chmod 777 $dir";
system "mkdir $dir/result";
system "chmod 777 $dir $dir/result";
system "mkdir $dir/txt";
system "chmod 777 $dir  $dir/txt";
open(FH,">$dir/input.fasta");
print FH "$seqfi\n";
close FH;
system "/usr/bin/perl $infut/splitfasta.pl $dir/input.fasta";
system "mv $infut/*.fa $dir"; 
##############################for indivisual file prosessing######################################
opendir(DIR,$memefile)||die "can't open directory: $!" ;
my @memefiles =grep /\.txt$/i,  readdir(DIR);
closedir(DIR);
opendir(DIR1,$dir)||die "can't open directory: $!" ;
my @files =grep /\.fa$/i, readdir(DIR1);
closedir(DIR1);
foreach my $file(@files)
{
  foreach  my $S(@memefiles)
   {
      my  $in=substr($S,0,5);
      my  $m=substr($file,0,10);
      system"/usr/local/bin/meme/bin/mast $memefile/$S  $dir/$file -oc $dir/result/mast$m$in";
    }
   $S++;
 }
$file++;
########Extract a perticular file(example.txt)from subdirectories and directories#####################
my $result="/webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/result";
opendir (DIR, $result)||die "Cannot open directory: $!";
my @direct = grep {!/^\.{1,2}$/ } readdir (DIR);
close(DIR);
foreach my $subdirect(@direct)
{
    #$m=substr($subdirect,0,10);
    opendir(DH,"$result/$subdirect")||die "Cannot open directory: $!";
    my @files = grep {/\.txt$/i && !/^\.{1,2}$/ } readdir (DH);
    close(DH);
    foreach my $file(@files)
    {
	$m=substr($subdirect,0,20);
	#print "$m.$file\n";
	system "cp $result/$subdirect/$file $m.$file";
	system "mv $m.$file  $dir/txt";
    }
}
############perl script to move files from txt directory to there named folder split_mast_data########
my  $test="/webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt";
opendir(DIR,$test)||die "Cannot open directory: $!";
my @direct = grep {!/^\.{1,2}$/ } readdir (DIR);
close(DIR);
foreach my $file(@direct)
{
   #print "$file\n";
    $m=substr($file,7,6);
   #print "$m\n";
   if($file=~/$m/i)
   {
       system"mkdir /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/$m";
       system"chmod 777 /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/$m";
      #system"cp $test/$file $test1/$m";
      #print "$m.$file\n";
       system"mv $test/$file /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/$m";
   }
}
#################Perl script to extract column field from text file#########################
my $result="/webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/";
opendir (DIR, $result)||die "Cannot open directory: $!";
my @direct = grep {!/^\.{1,2}$/ } readdir (DIR);
close(DIR);
foreach my $subdirect(@direct)
{
    opendir(DH,"$result/$subdirect")||die "Cannot open directory: $!";
    my @files = grep {/\.txt$/i && !/^\.{1,2}$/ } readdir (DH);
    close(DH);
          foreach $f(@files)
	  {
	      $s=substr($f,7,6);
               if ($f=~/$s/i)
	       {
		   #system"cat /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/$s.txt";
		   open my $out,">>", "/webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/$s.txt" or die $!;
		   open(FH,"$result/$subdirect/$f")||die "can't open file: $!" ;  
                 while($line=<FH>)
		 {
		     chomp ($line);
		     last if $line =~/^SECTION II\s*/;
                    if($line =~m/^\s+1/)
                    {
			@val=split(/\s+/,$line);
			print $out "$val[3]\t";
                    }
                     if(($line =~m/^tr/)||($line =~m/^sp/))
                     {
			 $line=~ s/\h +/ /;
			 my @column=split(" ",$line);
			print  $out  "$column[0]\t$column[1]\n";
		     }
		 }
	       }
             
	      close(FH);
     
	  }
}
#########sort multiple file in  directories#####################
my $test="/webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/";
opendir (DIR, $test)||die "Cannot open directory: $!";
my @files = grep {/\.txt$/i && !/^\.{1,2}$/ } readdir (DIR);
close(DIR);
foreach my $file(@files)
{
    $m=substr($file,0,6);
      if ($file=~/$m/i)
      {
       system "sort +2 -3 /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/$file >> /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/new_$m.txt";
      }
   }     
#########extract first line from every column-sort-file #####################
my $test="/webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/";
opendir (DIR, $test)||die "Cannot open directory: $!";
my @files = grep {/\.txt$/i && !/^\.{1,2}$/ } readdir (DIR);
close(DIR);
 foreach my $file(@files)
{
     if ($file=~m/^new/)
     {
        system "head -1  /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/$file  >> /webservers/cgidocs/mkumar/temp/shikha/lact_meme$ran/txt/final.txt";
     }
}
################################final html work###############################################################
print  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">\n";
print  "<html><HEAD>\n";
print  "<TITLE>LactFP::Prediction Result</TITLE>\n";
print  "</HEAD><body bgcolor=\"\#FFF8F0\">\n";
print  "<h2 ALIGN = \"CENTER\"> LactFp Prediction Result</h2>\n";
print  "<HR ALIGN =\"CENTER\"> </HR>\n";
print  "<p align=\"center\"><font size=4 color=black><b>The submitted protein/proteins belongs to <font color='red'></p>";
print "<table border='1'bgcolor='#D3D3A9'bordercolor='#000000'cellspacing='1' width='400' align='center'><tr><th>Fingerprint</th><th>Protein ID</th><th>Evalue</th></tr></table>";
open(RESULT,"$dir/txt/final.txt") or die "$!";
while($S=<RESULT>)
{
    chomp($S);
    @pred=split(/\t/,$S);
    print "<table border='1'bgcolor='#F1F1EB'bordercolor='#000000'width='400'align='center'cellspacing='1'><tr><td>$pred[0]</td><td>$pred[1]<td>$pred[2]</td></tr></table>";
}
print "</font></b></font></p>\n";
print  "<p align=\"center\"><font size=3 color=black><b>Thanks for using LactFP Server</b></font></p>\n";
print  "<p align=\"center\"><font size=3 color=black><b>If you have any problem or suggestions please contact <a href='mailto:manish@south.du.ac.in'>Dr. Manish Kumar</a></b></font>. Please mention your job number in any communication.</p></br>\n";
print  "<meta http-equiv=\"refresh\" content=\"60;url=http://10.154.4.31/cgi-bin/lactfp/chkres?c=$ran\"></center>\n";
print  "<p ALIGN=\"CENTER\"><b>Your job number is <font color=\"red\">$ran</b></font></p>\n";
print  "</body>\n";
print  "</html>\n";
