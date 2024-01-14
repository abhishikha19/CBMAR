#!/usr/bin/perl
if(-e "/webservers/cgidocs/mkumar/lactamasedb/graphical_all/OXY_logo.jpg")
{
    print "File exist\n";
}
elsif(!(-e "/webservers/cgidocs/mkumar/lactamasedb/graphical_all/OXY_logo.jpg"))
{
    print "File doesn't exist\n";
}
##print "<td><a href=\"../../../lactamasedb/$fp_ac[1]\"><img border='0' src=\"../../../lactamasedb/graphical_all/$fp_ac[2]\" width=\"80\" height=\"20\"\"</a></td>";
