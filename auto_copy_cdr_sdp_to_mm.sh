#!/bin/bash
######################################
#     create by gendutkiy34          #
#             2018                   #
######################################
dtl=$(date +%Y-%m-%d -d "1 hour ago")
dt=$(date +%Y%m%d%H -d "1 hour ago")
hrl=$(date +%H:%m -d "1 hour ago")
hr=$(date +%H -d "1 hour ago")
fnmgw="cdr_"$dt
fncgw="cdr_webcharging_"$dt
cdr="/nfs_data/project_sdp/cdr"
cdmgw="/home/insa/sdp/cdr/mgw"
cdcgw="/home/insa/sdp/cdr/cgw"

scp /nfs_data/project_sdp/cdr/mo_mt/$fnmgw hariono@10.158.234.75:$cdmgw/$fnmgw.txt
scp /nfs_data/project_sdp/cdr/cdr_payment_webcharging/$fncgw hariono@10.158.234.75:$cdcgw/$fncgw.txt

cat $cdr/mo_mt/$fnmgw
#cat $cdr/cdr_payment_webcharging/$fncgw

