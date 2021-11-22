#!/bin/bash
######################################
#     create by gendutkiy34          #
#             2018                   #
######################################
bsdir="/nfs_data/backup_log/sdp2/webCharging"
bsdir2="/drobo/logs/nfs_data/sdp2/webCharging"
bsdir1="/project_sdp/log"
fl="charging.log."

grs="================================================================================================================================================================"
hdr="\t\t\t\t\t\t\t\t\t\t\tTOKEN"
hdr1="\t\t\t\t\t\t\t\t\t\t\tCP Request                                "
hdr2="\t\t\t\t\t\t\t\t\t\t\tSDP Response   "
hdr3="\t\t\t\t\t\t\t\t\t\t\tLogin Token "
gnd="\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t@gendutkiy34"

echo "Masukkan session ID / no HP:"
read fltr
echo "Silahkan Masukkan date nya (yyyy-mm-dd) :"
read dt
IFS='-' read -r -a ar <<< "$dt"
echo "Masukkan Jam (HH) :"
echo "Ketik * untuk 1 hari "
read hr
clear
fnm="$fl${ar[0]}${ar[1]}${ar[2]}$hr.gz"
fnm1="token.log.${ar[0]}${ar[1]}${ar[2]}.gz"
if [ -f $bsdir/${ar[0]}/${ar[1]}/$fnm ];
then
   echo $grs
   echo -e $hdr
   echo $grs
   echo ""
   echo " "
   echo $grs
   echo -e $hdr3
   echo $grs
   echo ""
   zgrep $fltr $bsdir/${ar[0]}/${ar[1]}/$fnm | grep 'INFO Request LOGIN token'
   echo " "
   echo " "
   echo $grs
   echo -e $hdr1
   echo $grs
   echo ""
   zgrep $fltr $bsdir/${ar[0]}/${ar[1]}/$fnm  | grep 'INFO Request PAYMENT'
   echo ""
   echo ""
   echo $grs
   echo -e $hdr2
   echo $grs
   echo ""
   zgrep $fltr $bsdir/${ar[0]}/${ar[1]}/$fnm | grep 'INFO Response POST'
   echo ""
   echo $grs
   echo -e $gnd
else
   echo $grs
   echo -e $hdr
   echo $grs
   echo ""
   echo " "
   echo $grs
   echo -e $hdr3
   echo $grs
   echo ""
   zgrep $fltr $bsdir2/${ar[0]}/${ar[1]}/$fnm | grep 'INFO Request LOGIN token'
   echo " "
   echo " "
   echo $grs
   echo -e $hdr1
   echo $grs
   echo ""
   zgrep $fltr $bsdir2/${ar[0]}/${ar[1]}/$fnm | grep 'INFO Request PAYMENT'
   echo ""
   echo ""
   echo $grs
   echo -e $hdr2
   echo $grs
   echo ""
   zgrep $fltr $bsdir2/${ar[0]}/${ar[1]}/$fnm | grep 'INFO Response POST'
   echo ""
   echo $grs
   echo -e $gnd
fi
