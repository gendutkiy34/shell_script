#!/bin/bash
##############################################
#            create by gendutkiy34           #
#                  2020                      #
#desc   : testing SMS MT for SDO             #
#create : 2020-08-24                         #
#update : 2021-03-15                         #
##############################################
dt=$(date +"%Y%m%d%H%M")
logou="/home/hariono/log/test_http_$dt.txt"

clear
grs="=========================================================================="
echo $grs
echo  "\t\tFor testing SMS MT, multiple SDC in one time push"
echo $grs
echo "Please fil username :"
read us
echo "Please fill password :"
read pw
echo "please fill MSISDN :"
echo "(if you want test for multiple MSISDN, use <space> for separate)"
read hp
echo "please fill path SDC :"
read sd
echo "Please fill message :"
read msg

for msisdn in $hp
do
 echo  "testing for $msisdn ..."
 for sdc in $(cat $sd)
 do
   echo "send with sdc $sdc ..."
   #wget -q -S -O "http://10.70.29.136:9003/PUSH?USERNAME=$us&PASSWORD=$pw&REG_DELIVERY=1&ORIGIN_ADDR=$sdc&MOBILENO=$msisdn&TYPE=0&MESSAGE=$msg $sdc&UDH=0" 2>&1 1>/home/hariono/log/test_http_$dt.txt
   #echo "http://10.70.29.136:9003/PUSH?USERNAME=$us&PASSWORD=$pw&REG_DELIVERY=1&ORIGIN_ADDR=$sdc&MOBILENO=$msisdn&TYPE=0&MESSAGE=$msg $sdc&UDH=0"
   wget -q "http://10.70.29.136:9003/PUSH?USERNAME=$us&PASSWORD=$pw&REG_DELIVERY=1&ORIGIN_ADDR=$sdc&MOBILENO=$msisdn&TYPE=0&MESSAGE=$msg $sdc&UDH=0"  >> $logou
 done
 clear
done

clear
echo $grs
