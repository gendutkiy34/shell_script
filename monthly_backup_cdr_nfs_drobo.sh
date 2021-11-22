#!/bin/bash
#################################################
#      create by gendutkiy34                    #
#              2020                             #
# purpose for backup cdr from nfs_data to drobo #
#################################################i
dirn="/nfs_data/project_sdp/cdr"
dird="/drobo/logs/nfs_data/cdr"
year=$(date +%Y -d "1 month ago")
mont=$(date +%m -d "1 month ago")
dt=$(date +%Y%m%d)
logfile="/home/hariono/log/backup_cdr_nfs_drobo.log"

#backup cdr mo_mt
dir1="$dirn/mo_mt/$year"
dir2="$dird/mo_mt/$year"

echo "$(date +'%T %F') : check directory $dir2 "  >> $logfile 
if [ ! -d $dir2/$year ];
then
 
  echo "$(date +'%T %F') : $dir2 not exist"   >> $logfile
  echo "$(date +'%T %F') : create $dir2"   >> $logfile
  mkdir $dir2  
  echo "$(date +'%T %F') : create $dir2/$mont"   >> $logfile
  mkdir $dir2/$mont
  echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont starting ..."   >> $logfile
  for fl in $( ls $dir1/$mont )
  do
      cp $dir1/$mont/$fl  $dir2/$mont
      #echo $dir1/$mont/$fl
  done
  echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont finish"  >> $logfile
else
 
     echo "$(date +'%T %F') : check directory $dir2/$mont ..."   >> $logfile
     if [ ! -d $dir2/$mont ];
     then
         echo "$(date +'%T %F') : directory $dir2/$mont not exist "   >> $logfile
         echo "$(date +'%T %F') : create $dir2/$mont  " >> $logfile
         mkdir $dir2/$mont
         echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont starting ..."   >> $logfile
         for fl in $( ls $dir1/$mont )
         do
           cp $dir1/$mont/$fl  $dir2/$mont
           #echo $dir1/$mont/$fl
         done
         echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont finish"  >> $logfile
     else
         echo "$(date +'%T %F') : compare size directory $dir1/$mont & $dir2/$mont ..."   >> $logfile
         #szdir1=$(du -a $dir1/$mont | sort -rh | head -1 | awk '{print $1}')
         #szdir2=$(du -a $dir2/$mont | sort -rh | head -1 | awk '{print $1}')
         ndir1=$(ls $dir1/$mont | wc -l)
         ndir2=$(ls $dir2/$mont | wc -l)
         if [ "$ndir1" != "$ndir2" ];
         then
            echo "$(date +'%T %F') : num of file not equal"  >> $logfile
            echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont starting ..."  >> $logfile
            for fl in $( ls $dir1/$dr )
            do
              cp $dir1/$mont/$fl  $dir2/$mont
              #echo $dir1/$mont/$fl
            done
            echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont finish"  >> $logfile
         else
            echo "$(date +'%T %F') : num of file equal"  >> $logfile
         fi
     fi
 
 
fi



#backup cdr payment_webcharging
dir1="$dirn/cdr_payment_webcharging/$year"
dir2="$dird/cdr_payment_webcharging/$year"

echo "$(date +'%T %F') : check directory $dir2 "  >> $logfile
if [ ! -d $dir2/$year ];
then

  echo "$(date +'%T %F') : $dir2 not exist"   >> $logfile
  echo "$(date +'%T %F') : create $dir2"   >> $logfile
  mkdir $dir2
  echo "$(date +'%T %F') : create $dir2/$mont"   >> $logfile
  mkdir $dir2/$mont
  echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont starting ..."   >> $logfile
  for fl in $( ls $dir1/$mont )
  do
      cp $dir1/$mont/$fl  $dir2/$mont
      #echo $dir1/$mont/$fl
  done
  echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont finish"  >> $logfile
else
    
     echo "$(date +'%T %F') : check directory $dir2/$mont ..."   >> $logfile
     if [ ! -d $dir2/$mont ];
     then
         echo "$(date +'%T %F') : directory $dir2/$mont not exist "   >> $logfile
         echo "$(date +'%T %F') : create $dir2/$mont  " >> $logfile
         mkdir $dir2/$mont
         echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont starting ..."   >> $logfile
         for fl in $( ls $dir1/$mont )#
         do
            cp $dir1/$mont/$fl  $dir2/$mont
            #echo $dir1/$mont/$fl
         done
         echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont finish"  >> $logfile
     else
         echo "$(date +'%T %F') : compare size directory $dir1/$mont & $dir2/$mont ..."   >> $logfile
         #szdir1=$(du -a $dir1/$mont | sort -rh | head -1 | awk '{print $1}')
         #szdir2=$(du -a $dir2/$mont | sort -rh | head -1 | awk '{print $1}')
         ndir1=$(ls $dir1/$mont | wc -l)
         ndir2=$(ls $dir2/$mont | wc -l)
         
         if [ "$ndir1" != "$ndir2" ];
         then
            echo "$(date +'%T %F') : num of file not equal"  >> $logfile
            echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont starting ..."  >> $logfile
            for fl in $( ls $dir1/$mont )
            do
              cp $dir1/$mont/$fl  $dir2/$mont
              #echo $dir1/$mont/$fl
            done
            echo "$(date +'%T %F') : copy file from $dir1/$mont to $dir2/$mont finish"  >> $logfile
         else
            echo "$(date +'%T %F') : num of file equal"  >> $logfile
         fi
     fi

fi
