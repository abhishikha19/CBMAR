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
$text=$query->param('T1');
#$Phylogenetic_Group_1= $query->param('Phylogenetic_group');
#$Representative_Enzyme_1= $query->param('Enzyme');
$Type_bacteria_1 = $query->param('Gram_phenotype');
$Type_bacteria_2 = $query->param('Gram_phenotype_1');
$Origin_of_name_1= $query->param('Taxonomy');
$Origin_of_name_2= $query->param('Taxonomy_1');
$Genus_1= $query->param('Organisam');
$Genus_2= $query->param('Organisam_1');
$Gene_location_1=$query->param('Gene_location');
$Gene_location_2=$query->param('Gene_location_1');
$PDB_code_1 =$query->param('PDB_structure');
$PDB_code_2 =$query->param('PDB_structure_1');
$Inhibitors_Resistance_1=$query->param('Inhibitor_Resistance');
$Inhibitors_Resistance_2=$query->param('Inhibitor_Resistance_1');
$Number_of_variants_1=$query->param('Variant');
$Number_of_variants_2=$query->param('Variant_1');
$Hydrolyzing_profile_1=$query->param('Hydrolysis_profile');
$Hydrolyzing_profile_2=$query->param('Hydrolysis_profile_1');

$ALL =$query->param('ALL');
$ALL_1 =$query->param('ALL_1');
my @fields =();
#$search_fields='ID like'."'%$text%'";
#$fields[0]='ID';
#$search_fields='Ambler_Class like'." '%$text%'";
#$fields[1]='Ambler_Class';
#$search_fields='Representative_Subclass like'." '%$text%'";
#$fields[2]='Representative_Subclass';
#print "$type";
if($type eq 'exact')
  {
     $search_fields='ID like ='."'$text'";
     $fields[0]='ID';
     $search_fields='Ambler_Class ='." '$text'";
     $fields[1]='Ambler_Class';
     $search_fields='Representative_Subclass ='." '$text'";
     $fields[2]='Representative_Subclass';
     if($ALL eq 'ON')
          {
            $search_fields="$search_fields".'or Origin_of_Name or Genus or Gene_Location or PDB_code  or Inhibitors_Resistance  or Gram_Phenotype or Variants or Hydrolyzing_profile ='." '$text'";
            if($ALL_1 eq 'ON')
            { 
              push @fields,"Origin_of_Name","Genus","Gene_Location","PDB_code","Inhibitors_Resistance","Gram_Phenotype","Variants","Hydrolyzing_profile";
             }
           }
    else
     {
      if( $Type_bacteria_1 eq 'ON')
       {
	 $search_fields="$search_fields".' or  Gram_Phenotype  ='." '$text'";
         if( $Type_bacteria_2 eq 'ON')
           {
	     push @fields, "Gram_Phenotype";
            } 
         } 
    if($Origin_of_name_1 eq 'ON')
       {
	$search_fields="$search_fields".' or Origin_of_name ='." '$text'";
        if($Origin_of_name_2 eq 'ON')
	 {
          push @fields, "Origin_of_Name";
         }
       }
    if($Genus_1 eq 'ON')
       {
	$search_fields="$search_fields".' or Genus ='." '$text'";
        if($Genus_2 eq 'ON')
	  {
            push @fields,"Genus";
          }
       }
    if($Gene_location_1 eq 'ON')
       {
	$search_fields="$search_fields".' or Gene_Location ='." '$text'";
        if($Gene_location_2 eq 'ON')
        {
         push @fields, "Gene_Location";
         }
       }
    if($PDB_code_1 eq 'ON')
        {
	 $search_fields="$search_fields".' or PDB_code ='." '$text'";
	 if($PDB_code_2 eq 'ON')
           {
             push @fields, "PDB_code";
           }
	 }
    if($Inhibitors_Resistance_1 eq 'ON')
         { 
          $search_fields="$search_fields".' or Inhibitors_Resistance ='." '$text'";
           if($Inhibitors_Resistance_2 eq 'ON')
            {
              push @fields,"Inhibitors_Resistance";
             }
           }
    if($Number_of_variants_1 eq 'ON')
        {
          $search_fields="$search_fields".' or  Variants ='." '$text'";
          if($Number_of_variants_2 eq 'ON')
           {
            push @fields, "Variants";
           }   
         }
    if($Hydrolyzing_profile_1 eq 'ON')
       {
	$search_fields="$search_fields".' or Hydrolyzing_profile ='." '$text'";
         if($Hydrolyzing_profile_2 eq 'ON')
	 {
          push @fields, "Hydrolyzing_profile";  
          }
       }
 }
  }
if($type  eq 'any')
  {
   $search_fields='ID like'."'%$text%'";
   $fields[0]='ID';
   $search_fields='Ambler_Class like'." '%$text%'";
   $fields[1]='Ambler_Class';
   $search_fields='Representative_Subclass like'." '%$text%'";
   $fields[2]='Representative_Subclass';
   
   if($ALL eq 'ON')
    {
      $search_fields="$search_fields".'or Origin_of_Name or Genus or Gene_Location or PDB_code  or Inhibitors_Resistance  or Gram_Phenotype or Variants or Hydrolyzing_profile like'." '%$text%'";
       if($ALL_1 eq 'ON')
        {
          push @fields,"Origin_of_Name","Genus","Gene_Location","PDB_code","Inhibitors_Resistance","Gram_Phenotype","Variants","Hydrolyzing_profile"; 
        }
    }
else
    {
      if( $Type_bacteria_1 eq 'ON')
       {
	$search_fields="$search_fields".' or  Gram_Phenotype  like'." '%$text%'";
         if( $Type_bacteria_2 eq 'ON')
         { 
           push @fields, "Gram_Phenotype";
           }
         }  
      if($Origin_of_name_1 eq 'ON')
        {
	  $search_fields="$search_fields".' or Origin_of_name like'." '%$text%'";
           if($Origin_of_name_2 eq 'ON')
           {
            push @fields, "Origin_of_Name";
            }
	}
       if($Genus_1 eq 'ON')
         {
	   $search_fields="$search_fields".' or Genus like'." '%$text%'";
           if($Genus_2 eq 'ON')
           {
             push @fields,"Genus";
            }
	 }
        if($Gene_location_2 eq 'ON')
         {
	    $search_fields="$search_fields".' or Gene_Location like'." '%$text%'";
            if($Gene_location_2 eq 'ON')
            {
              push @fields, "Gene_Location";  
             }
	  }
    if($PDB_code_1 eq 'ON')
    {
      $search_fields="$search_fields".' or PDB_code like'." '%$text%'";
      if($PDB_code_2 eq 'ON')
       {
         push @fields, "PDB_code";  
         }
      }
    if($Inhibitors_Resistance_1 eq 'ON')
       { 
	$search_fields="$search_fields".' or Inhibitors_Resistance like'." '%$text%'";
        if($Inhibitors_Resistance_2 eq 'ON')
	  {
           push @fields,"Inhibitors_Resistance"; 
          }
       }
    if($Number_of_variants_1 eq 'ON')
    {
	$search_fields="$search_fields".' or  Variants like'." '%$text%'";
         if($Number_of_variants_1 eq 'ON')
          {
            push @fields, "Variants"; 
           }
        }
    if($Hydrolyzing_profile_1 eq 'ON')
       {
	$search_fields="$search_fields".' or Hydrolyzing_profile like'." '%$text%'";
       if($Hydrolyzing_profile_1 eq 'ON')
       {
        push @fields, "Hydrolyzing_profile"; 
        }
      }
 }
  }
my $all_fields= join(",",@fields);
use DBI;
$database="betalactamasedb";
$host="localhost";
$user ="abhishikha";
$pw = "shikha123";
$dsn ="DBI:mysql:$database:$host";
$connect = DBI->connect("DBI:mysql:$database:$host",$user, $pw);
$query="Select $all_fields from betalactamase where $search_fields ";
print "$query";
$query_handle = $connect->prepare($query) or die "Here $!";
$rv=$query_handle->execute || die "$!";
@row= $query_handle->fetchrow_array();

print"<body bgcolor='#FFF2E6'body>\n";
print"<p><iframe align='center' width='1600'height='800'style='border: #FFF2E6' src='../../mkumar/temp/shikha/lact$ran/result.html'</iframe></p>";
#print "../../mkumar/temp/shikha/lact$ran/result.html";
open(FH, ">>$dir/result.html");
print FH"<table border='1' width=100% table-layout:fixed align='center',cellspacing='2'cellpadding='5'bordercolor='#c86260'bgcolor='#FFF8DC'>\n";

foreach $field_no(@fields)
  {
    if ($field_no=~/Ambler_Class/)
    {
	print FH "<th title= 'beta-lactamase class wise classification' col width ='25px'bgcolor='#EDC9AF'><font color='#0066FF'>Ambler class</th>\n";
    }
    if($field_no=~/Gene_Location/)
    { 
	print FH "<th title= ' bla Gene location(Chromosomal/Plasmid)' bgcolor='#EDC9AF'><font color='#0066FF'>Gene Location</th>\n";
    }
    if($field_no eq 'ID')
    {
	print FH "<th bgcolor='#EDC9AF' width='50px'><font color='#0066FF'>ID</th>\n";
    }
    if($field_no=~/Inhibitors_Resistance/)
    {
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Inhibitors Resistance</th>\n";
    }
    if($field_no=~/Genus/)
    {
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Genus</th>\n";
    }
    if($field_no=~/Variants/)
    {
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Variants</th>\n";
    }
    if($field_no=~/Hydrolyzing_profile/)
    {
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Hydrolyzing profile</th>\n";
    }
    if($field_no=~/Representative_Subclass/)
       {
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Representative Families</th>\n";
	print FH "<th bgcolor='#EDC9AF' width='125'><font color='#0066FF'>Fingerprint</th>\n";
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Active-Site</th>\n";
    }
    if($field_no=~/Gram_Phenotype/)
    {
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Gram Phenotype</th>\n";
    }
    if($field_no=~/Origin_of_Name/)
    {
	# print FH "<th bgcolor='#EDC9AF' width='125'><font color='#0066FF'>Fingerprint</th>\n";
	#print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Active-Site</th>\n";
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>Origin of Name</th>\n"; 
    }
    if($field_no=~/PDB_code/)
    {
	print FH "<th bgcolor='#EDC9AF'><font color='#0066FF'>PDB-ID</th>\n";
    }
  }
while(my(@row)=$query_handle->fetchrow_array)
{
    print FH"<tr>\n";
    foreach my $val(@row)
    {
	$count++;
	if($count == 3)      
	   {
	    #print FH "<td><a target='_top' href ='../../../lactamasedb/classification_sql.html#$val' >$val</a></td>\n";       
	    print FH "<td><a target='_blank' href ='../../../lactamasedb/detail/$val.html'>$val</a></td>\n";
	    $grep_word='name='."$val".':';
	    $fingerprint=`grep -i "^$grep_word" graphical_all_new`;
	    @k = split ('#',$fingerprint);
	    print FH"$k[1]$k[2]";
            #print FH "<td><a target='_blank' href ='http://www.rcsb.org/pdb/explore/explore.do?structureId=$val'>$val</a></td>\n"; 
	   }   
            if($count == 7) 
              {
	        print FH "<td>";
                if($val !~/Unknown/)
                {
                  @temp_val1=split(',',$val);
		}
                  foreach $temp_count1(@temp_val1)
                  {
                   print FH "<a target='_blank' href ='http://www.rcsb.org/pdb/explore/explore.do?structureId=$temp_count1'>$temp_count1 <br></a>";
                    }

                 if($val=~ m/Unknown/)
                  {  
		    print FH "$val <br>";
		   }
                 print FH "</td>";  
                 undef @temp_val1;
                }

            if($count == 5)
               {
                print FH "<td>";
                @temp_val3=split(',',$val);
                foreach $temp_count3(@temp_val3)
                     {
		      print FH "<a title='Click to get Species Specific Information' target='_blank' href ='../../../lactamasedb/genus/$val.html#$temp_count3'><i>$temp_count3</i> <br></a>";
		      #print FH "<i>$temp_count3</i> <br>";
                      #print FH "<a title=YES target='_blank' href ='http://en.wikipedia.org/wiki/$temp_count3'><i>$temp_count3 </i><br></a>";
		      }
                   print FH "</td>";
                   undef @temp_val3;
	       }
           if (($val=~ m/,/)&&($count  != 7)&&($count !=5)) 
	      {
	       #print FH "<TD> $count++";
	       print FH "<TD>";
	       @temp_val=split(',',$val);
	       foreach $temp_count(@temp_val)
	       {
	         print FH "$temp_count <br>";
	        }
	       print FH "</TD>";
	       undef @temp_val;
	      }
	  
          if(($count  != 3)&&($count  != 7)&&($count !=5)&&($val !~ m/,/))
	   {
	    #print FH"<td style='WORD-BREAK:BREAK-ALL;'>$val</td>\n";
	    #print FH"<td>$val $count +++ </td>\n";
	    print FH"<td>$val</td>\n";
	}
    } 
    $count=0;
    #print FH "<td><a>align='center'width='1160'height='300'style='border: #FFF2E6' ../../mkumar/lactamas >$val</a></td>\n";
    print FH "</tr>\n";
}
print FH "</table>\n";
close(FH);
#print"</iframe></p>";
#print"<p><p><iframe align='center'width='1160'height='150'style='border:1px solid #008080' src='../../mkumar/lactamasedb/graphical_class.html' ></iframe></p></p>";
#print"</iframe></p>";
#print"<p><p><iframe name='I1'style='border:1px solid #008080' align='center'width='1160'height='300'style='border: #FFF2E6' src='../../mkumar/lactamasedb/graphical_all.html'></iframe></p></p>";
$rc = $query_handle->finish;
exit(0);


