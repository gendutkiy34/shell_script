#!/bin/bash
######################################
#     create by gendutkiy34          #
#             2020                   #
######################################
bsdir1="/nfs_data/backup_log/sdp1/mgw"
bsdir2="/nfs_data/backup_log/sdp1/sdp"
bsdir3="/nfs_data/backup_log/sdp2/mgw"
bsdir4="/nfs_data/backup_log/sdp1/sdp"
bsdir5="/drobo/logs/nfs_data/sdp1/mgw"
bsdir6="/drobo/logs/nfs_data/sdp1/sdp"
bsdir7="/drobo/logs/nfs_data/sdp2/mgw"
bsdir8="/drobo/logs/nfs_data/sdp1/sdp"

rcp="=========================================================== SMS MT - receive from CP ========================================================================="
rpr="============================================================== SMS MT - proccessing =========================================================================="
rdr="===================================================================== DR SEND to CP =========================================================================="
rmo="=============================================================== SMS MO - SEND to CP =========================================================================="
rsm="=================================================================== SDP - SMSC ==============================================================================="
ren="=============================================================================================================================================================="
rsb="================================================================ submit respon ==============================================================================="
gnd="\t\t\t\t\t\t\t\t\tgendutkiy@2019"

clear
echo $ren
echo -e "\t\t\t\t\t\t\t\t *Purpose to find SMS MT/MO log"
echo $ren
echo ""
#INPUTAN
echo " Masukkan msisdn :"
read hp
echo " Masukkan tanggal (yyyy-mm-dd) : "
read dt
echo "hour (hh) :"
echo "*please fill * for all day "
read hh
echo "Pilih koneksi :"
echo "1. Http"
echo "2. SMPP"
read con

#PROSES
IFS='-' read -r -a array <<< "$dt"

#validate file SMPPSERVER
nsp=$(ls $bsdir2/${array[0]}/${array[1]} | grep SMPPSERVER.log | grep $dt | wc -l)
if [ "$nsp" -gt "0" ];
then
  fnm1="$bsdir2/${array[0]}/${array[1]}/SMPPSERVER.log.$dt-$hh.gz"
else
  fnm1="$bsdir6/${array[0]}/${array[1]}/SMPPSERVER.log.$dt-$hh.gz"
fi

#validate SDP1 mgw.log
ns=$(ls $bsdir1/${array[0]}/${array[1]} | grep mgw.log | grep ${array[0]}${array[1]}${array[2]} | wc -l)
if [ "$ns" -gt "0" ];
then
  fnm2="$bsdir1/${array[0]}/${array[1]}/mgw.log.${array[0]}${array[1]}${array[2]}$hh.gz"
else
  fnm2="$bsdir5/${array[0]}/${array[1]}/mgw.log.${array[0]}${array[1]}${array[2]}$hh.gz"
fi

#validate SDP1 mgw_error
ne=$(ls $bsdir1/${array[0]}/${array[1]} | grep mgw_error | grep ${array[0]}${array[1]}${array[2]} | wc -l)
if [ "$ne" -gt "0" ];
then
  fnm3="$bsdir1/${array[0]}/${array[1]}/mgw_error.${array[0]}${array[1]}${array[2]}$hh.gz"
else
  fnm3="$bsdir5/${array[0]}/${array[1]}/mgw_error.${array[0]}${array[1]}${array[2]}$hh.gz"
fi

#validate SDP2 mgw.log
nh=$(ls $bsdir3/${array[0]}/${array[1]}/ | grep mgw.log | grep ${array[0]}${array[1]}${array[2]} | wc -l)
if [ "$nh" -gt "0" ];
then
  fnm4="$bsdir3/${array[0]}/${array[1]}/mgw.log.${array[0]}${array[1]}${array[2]}$hh.gz"
else
  fnm4="$bsdir7/${array[0]}/${array[1]}/mgw.log.${array[0]}${array[1]}${array[2]}$hh.gz"
fi

#validate SDP2 mgw_error
nh2=$(ls $bsdir3/${array[0]}/${array[1]}/ | grep mgw_error.log | grep ${array[0]}${array[1]}${array[2]} | wc -l)
if [ "$nh2" -gt "0" ];
then
  fnm5="$bsdir3/${array[0]}/${array[1]}/mgw_error.log.${array[0]}${array[1]}${array[2]}$hh.gz"
else
  fnm5="$bsdir7/${array[0]}/${array[1]}/mgw_error.log.${array[0]}${array[1]}${array[2]}$hh.gz"
fi

#validate SDP1 mgw.log
nh=$(ls $bsdir1/${array[0]}/${array[1]}/ | grep mgw.log | grep ${array[0]}${array[1]}${array[2]} | wc -l)
if [ "$nh" -gt "0" ];
then
  fnm7="$bsdir1/${array[0]}/${array[1]}/mgw.log.${array[0]}${array[1]}${array[2]}$hh.gz"
else
  fnm7="$bsdir5/${array[0]}/${array[1]}/mgw.log.${array[0]}${array[1]}${array[2]}$hh.gz"
fi

#validate SDP1 mgw_error
nh2=$(ls $bsdir1/${array[0]}/${array[1]}/ | grep mgw_error.log | grep ${array[0]}${array[1]}${array[2]} | wc -l)
if [ "$nh2" -gt "0" ];
then
  fnm8="$bsdir1/${array[0]}/${array[1]}/mgw_error.log.${array[0]}${array[1]}${array[2]}$hh.gz"
else
  fnm8="$bsdir5/${array[0]}/${array[1]}/mgw_error.log.${array[0]}${array[1]}${array[2]}$hh.gz"
fi

#validate SDP2 prs
np=$(ls $bsdir4/${array[0]}/${array[1]}/ | grep prs.log | grep $dt | wc -l)
if [ "$np" -gt "0" ];
then
  fnm6="$bsdir4/${array[0]}/${array[1]}/prs.log.$dt-$hh.gz"
else
  fnm6="$bsdir8/${array[0]}/${array[1]}/prs.log.$dt-$hh.gz"
fi

clear
echo ""
echo ""
echo $rcp
echo ""
if [ "$con" == "2" ];
then
 zgrep -h $hp $fnm1 | grep 'SMPP PACKET RECVX'
 echo $rsb
 zgrep -h $hp $fnm1 | grep 'responseSubmit sourceNumber:' |grep 'Command Status'
elif [ "$con" == "1" ];
then
 zgrep -h $hp $fnm4 | grep -i 'INFO Request send SMS'
 zgrep -h $hp $fnm7 | grep -i 'INFO Request send SMS'
fi
echo ""
echo $rpr
echo ""
if [ "$con" == "2" ];
then
 zgrep -h $hp $fnm1 | grep "json SM"
 zgrep -h $hp $fnm1 | grep 'json DR' | cut -d'{' -f1,7
 zgrep -h $hp $fnm1 | grep 'DeliverSmpp sourceNumber' | grep 'stat:'
elif [ "$con" == "1" ];
then 
 zgrep -h $hp $fnm5 | grep 'INFO Query Message History' | grep -v 'MO_' | grep -v ",'DR'," | cut -d'(' -f1,3
 zgrep -h $hp $fnm8 | grep 'INFO Query Message History' | grep -v 'MO_' | grep -v ",'DR'," | cut -d'(' -f1,3
 echo ""
 echo $rdr
 echo ""
 zgrep -h $hp $fnm5 | grep '&status='
 
fi
echo ""

echo $rmo
echo ""
if [ "$con" == "2" ];
then
 zgrep -h $hp $fnm1 | grep 'error MO json'
 zgrep -h $hp $fnm1 | grep 'jsonMO status' | cut -d'{' -f1,7,9,10
elif [ "$con" == "1" ];
then
 zgrep -h $hp $fnm4 | grep 'INFO Request sms_mo' | cut -d'{' -f1,6,7,8
 #zgrep $hp $fnm5 | grep 'INFO Query Message History' | grep -v 'MT_'  | grep -v 'DR'
 zgrep -h $hp $fnm5 | grep 'INFO link http' | grep -v '&status='
fi
echo ""
echo $rsm
echo ""
zgrep  -h $hp $fnm6 
echo ""
echo $ren
echo -e $gnd
