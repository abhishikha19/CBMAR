#!/usr/bin/perl -w
open (FH,"2uni.fasta") or die;
#########################################program will add a text in file###############################
while ($line=<FH>)
{
    chomp ($line);

if (($line=~m/^>/)&&(($line=~m/OXA-/i)||($line=~m/LCR-/i)))
{
    $next=<FH>;
    chomp ($next);
    @id=split(/\|/,$line);
    print "$id[0]|$id[1]|ClassD|$id[2]\n$next\n";
}
if (($line=~m/^>/)&&(($line=~m/AER-/i)||($line=~m/AST-/i)||($line=~m/BEL-/i)||($line=~m/BES-/i)||($line=~m/BLAF-/i)||($line=~m/BLAZ-/i)||($line=~m/BPS-/i)||($line=~m/BRO-/i)||($line=~m/CARB-/i)||($line=~m/CEPA-/i)||($line=~m/CFXA-/i)||($line=~m/CKO-/i)||($line=~m/ClbA-/i)||($line=~m/CME-/i)||($line=~m/CSP-/i)||($line=~m/CTX-/i)||($line=~m/CumA-/i)||($line=~m/DES-/i)||($line=~m/FAR-/i)||($line=~m/ERP-/i)||($line=~m/FONA-/i)||($line=~m/FEC-/i)||($line=~m/GES-/i)||($line=~m/HUGA-/i)||($line=~m/HERA-/i)||($line=~m/IBC-/i)||($line=~m/IMI-/i)||($line=~m/IRT-/i)||($line=~m/KLUA-/i)||($line=~m/KLUC-/i)||($line=~m/KLUG-/i)||($line=~m/KLUY-/i)||($line=~m/KPC-/i)||($line=~m/LAP-/i)||($line=~m/LEN-/i)||($line=~m/LUT-/i)||($line=~m/MAL-/i)||($line=~m/NMC-/i)||($line=~m/OHIO-/i)||($line=~m/OKP-/i)||($line=~m/ORN-/i)||($line=~m/OXY-/i)||($line=~m/PENA-/i)||($line=~m/PER-/i)||($line=~m/PLA-/i)||($line=~m/PSE-/i)||($line=~m/RAHN-/i)||($line=~m/RTG-/i)||($line=~m/ROB-/i)||($line=~m/SCO-/i)||($line=~m/SED-/i)||($line=~m/SFC-/i)||($line=~m/SFO-/i)||($line=~m/SHV-/i)||($line=~m/SMA-/i)||($line=~m/SME-/i)||($line=~m/TEM-/i)||($line=~m/TER-/i)||($line=~m/TLA-/i)||($line=~m/TOHO-/i)||($line=~m/VHH-/i)||($line=~m/VHW-/i)||($line=~m/VEB-/i)||($line=~m/ACI-/i)))
{
    $next=<FH>;
    chomp ($next);
    @id=split(/\|/,$line);
    print "$id[0]|$id[1]|ClassA|$id[2]|\n$next\n";
}

if (($line=~m/^>/)&&(($line=~m/BCII-/i)||($line=~m/Blab-/i)||($line=~m/CcrA-/i)||($line=~m/CGB-/i)||($line=~m/DIM-/i)||($line=~m/EBR-/i)||($line=~m/GIM-/i)||($line=~m/IMP-/i)||($line=~m/IND-/i)||($line=~m/JOHN-/i)||($line=~m/KHM-/i)||($line=~m/NDM-/i)||($line=~m/SFB-/i)||($line=~m/SIM-/i)||($line=~m/ImiS-/i)||($line=~m/SLB-/i)||($line=~m/SPM-/i)||($line=~m/TMB-/i)||($line=~m/TUS-/i)||($line=~m/MUS-/i)||($line=~m/VIM-/i)||($line=~m/CphA-/i)||($line=~m/AIM-/i)||($line=~m/L1-/i)||($line=~m/BJP-/i)||($line=~m/CAU-/i)||($line=~m/FEZ-/i)||($line=~m/GOB-/i)||($line=~m/LRA-/i)||($line=~m/MIBIB-/i)||($line=~m/POM-/i)||($line=~m/SMB-/i)||($line=~m/THIN-B-/i)))
{
    $next=<FH>;
    chomp ($next);
    @id=split(/\|/,$line);
    print "$id[0]|$id[1]|ClassB|$id[2]\n$next\n";
}
if (($line=~m/^>/)&&(($line=~m/ACC-/i)||($line=~m/ACT-/i)||($line=~m/BIL-/i)||($line=~m/CFE-/i)||($line=~m/CMY-/i)||($line=~m/DHA-/i)||($line=~m/EBC-/i)||($line=~m/FOX-/i)||($line=~m/LAT-/i)||($line=~m/MIR-/i)||($line=~m/MOX-/i)||($line=~m/SRT-/i)||($line=~m/SST-/i)||($line=~m/AmpC-/i)))
{
    $next=<FH>;
    chomp ($next);
    @id=split(/\|/,$line);
    print "$id[0]|$id[1]|ClassC|$id[2]\n$next\n";
}

}
