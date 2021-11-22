#!/bin/bash
######################################
#     create by gendutkiy34          #
#             2018                   #
######################################
echo "============================================================================================================================================================="
echo "                                                                                  SDP CONFIGURATION INFO                                                    "
echo "============================================================================================================================================================="
echo " "
echo "1. CP INFO                  5. SDC base on CPID                       9. MO keyword base on CPID        13. CP License expired (this year)"
echo "2. CP LOW BALANCE           6. MASKING AND CP ID                     10. MO keyword base on SDC         14. CP Expired (this year)"
echo "3. CP SERVICE TYPE          7. ALL CP BASE ON MASKING                11. MO URL base on CPID            15. CP Service Expired (this Year)"        
echo "4. CP CONNECTION CONF INFO  8. ALL MASKING BASE ON DATE CREATION     12. DR URL base on CPID            16. CP Info Detail" 
echo "============================================================================================================================================================="
echo "Please choose one: "
read op

case $op in
1)
 clear
 /usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT tcp_name,tcp_cp_code,CASE WHEN tcp_status='1' then 'Active' else 'Not Active' END as STATUS FROM sdp2.tbl_content_provider WHERE tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999') ORDER BY tcp_cp_code;"
;;
2)
clear
 /usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name,a.tcp_cp_code ,b.tb_value as quota FROM sdp2.tbl_content_provider a LEFT JOIN sdp2.tbl_balance b ON b.tb_cp_id=a.tcp_id WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999','030') AND b.tb_value < 1000000000 ORDER BY a.tcp_cp_code;"
;;
3)
echo "Please input CP CODE : "
read cpid
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name,a.tcp_cp_code ,case when b.ts_service_type='1' then 'On Demand' when b.ts_service_type='2' then 'Subscription' when b.ts_service_type='3' then 'Bulk' when b.ts_service_type='4' then 'Digital Service' else 'Bundling' end as SERVICE_TYPE ,CASE WHEN a.tcp_status='1' then 'Active' else 'Not Active' END as STATUS FROM tbl_content_provider a LEFT JOIN tbl_service b ON b.ts_cp_id=a.tcp_id WHERE a.tcp_cp_code='$cpid';"
;;
5)
echo "Please input CP CODE : "
read cpid
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_ID,d.tcc_name as CONNECTION_NAME,d.tcc_system_id as USERNAME,d.tcc_password as PASSWORD ,CASE WHEN e.tsk_direction='1' then 'MO' else 'MT' END as TYPE ,e.tsk_msisdn as PREFIX_MSISDN,e.tsk_sdc as MASKING,e.tsk_sdc_prefix_add as MASKING_AFTER_CUT,f.tt_value as tarif,DATE_FORMAT(e.first_update,'%Y-%m-%d') as DATE_CREATION FROM tbl_content_provider a LEFT JOIN tbl_service c ON c.ts_cp_id =a.tcp_id LEFT JOIN tbl_cp_connection d ON d.tcc_cp_id =a.tcp_id AND d.tcc_service_id=c.ts_id LEFT JOIN tbl_sdc_keyword e ON e.tsk_service=c.ts_id LEFT JOIN
tbl_tarif f ON f.tt_id=e.tsk_tarif WHERE a.tcp_cp_code='$cpid' AND c.ts_service_type='3';"
;;
6)
clear
/usr/local/mysql/bin/ mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name,a.tcp_cp_code FROM tbl_content_provider a LEFT JOIN tbl_service c ON c.ts_cp_id =a.tcp_id WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999') AND c.ts_service_type='3' ORDER BY a.tcp_cp_code;"
echo "Please input CP CODE : "
read cpid
echo "Please input masking keyword : "
echo "(use ',' fo delimeter each masking)"
read ms
ms1=$(echo $ms | sed -e 's/\,/","/g')
msk='"'$ms1'"'
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_ID,c.ts_service_name as SERVICE_NAME,d.tcc_name as CONNECTION_NAME,d.tcc_system_id as USERNAME,d.tcc_password as PASSWORD ,CASE WHEN e.tsk_direction='1' then 'MO' else 'MT' END as TYPE ,e.tsk_msisdn as PREFIX_MSISDN,e.tsk_sdc as MASKING,e.tsk_sdc_prefix_add as MASKING_AFTER_CUT,DATE_FORMAT(e.first_update,'%Y-%m-%d') as DATE_CREATION FROM tbl_content_provider a LEFT JOIN tbl_service c ON c.ts_cp_id =a.tcp_id LEFT JOIN tbl_cp_connection d ON d.tcc_cp_id =a.tcp_id AND d.tcc_service_id=c.ts_id LEFT JOIN tbl_sdc_keyword e ON e.tsk_service=c.ts_id WHERE a.tcp_cp_code='$cpid' AND e.tsk_sdc in ($msk) AND c.ts_service_type='3';"
;;
7)
echo "please type masking : "
read msk
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_ID,c.ts_service_name as SERVICE_NAME,d.tcc_name as CONNECTION_NAME,d.tcc_system_id as USERNAME,d.tcc_password as PASSWORD ,CASE WHEN e.tsk_direction='1' then 'MO' else 'MT' END as TYPE ,e.tsk_msisdn as PREFIX_MSISDN,e.tsk_sdc as MASKING,e.tsk_sdc_prefix_add as MASKING_AFTER_CUT,f.tt_value as tarif,DATE_FORMAT(e.first_update,'%Y-%m-%d') as DATE_CREATION FROM tbl_content_provider a LEFT JOIN tbl_service c ON c.ts_cp_id =a.tcp_id LEFT JOIN tbl_cp_connection d ON d.tcc_cp_id =a.tcp_id AND d.tcc_service_id=c.ts_id LEFT JOIN tbl_sdc_keyword e ON e.tsk_service=c.ts_id LEFT JOIN
tbl_tarif f ON f.tt_id=e.tsk_tarif WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999') AND e.tsk_sdc like '%$msk%' AND c.ts_service_type='3';";;     
8)
echo "please type date_creation (yyyy-mm-dd) : "
read dt
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_ID,c.ts_service_name as SERVICE_NAME,d.tcc_name as CONNECTION_NAME,d.tcc_system_id as USERNAME,d.tcc_password as PASSWORD ,CASE WHEN e.tsk_direction='1' then 'MO' else 'MT' END as TYPE ,e.tsk_msisdn as PREFIX_MSISDN,e.tsk_sdc as MASKING,e.tsk_sdc_prefix_add as MASKING_AFTER_CUT,DATE_FORMAT(e.first_update,'%Y-%m-%d') as DATE_CREATION FROM tbl_content_provider a LEFT JOIN tbl_service c ON c.ts_cp_id =a.tcp_id LEFT JOIN tbl_cp_connection d ON d.tcc_cp_id =a.tcp_id AND d.tcc_service_id=c.ts_id LEFT JOIN tbl_sdc_keyword e ON e.tsk_service=c.ts_id WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999') AND c.ts_service_type='3' AND  DATE_FORMAT(e.first_update,'%Y-%m-%d') ='$dt';"
;;
9)
echo "Please input CP CODE : "
read cpid
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,c.ts_service_name as SERVICE_NAME,d.tcc_name as CONNECTION_NAME,d.tcc_system_id as USERNAME,d.tcc_password as PASSWORD 
,CASE WHEN e.tsk_direction='1' then 'MO' else 'MT' END as TYPE ,e.tsk_msisdn as SDC,e.tsk_keyword as KEYWORD FROM tbl_content_provider a LEFT JOIN tbl_service c ON c.ts_cp_id =a.tcp_id LEFT JOIN tbl_cp_connection d ON d.tcc_cp_id =a.tcp_id AND d.tcc_service_id=c.ts_id LEFT JOIN tbl_sdc_keyword e ON e.tsk_service=c.ts_id WHERE e.tsk_direction='1' AND a.tcp_cp_code='$cpid';"
;;
10)
echo "Please input SDC : "
read sdc
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT DISTINCT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,c.ts_service_name as SERVICE_NAME,d.tcc_name as CONNECTION_NAME,d.tcc_system_id as USERNAME,d.tcc_password as PASSWORD 
,CASE WHEN e.tsk_direction='1' then 'MO' else 'MT' END as TYPE ,e.tsk_msisdn as SDC,e.tsk_keyword as KEYWORD FROM tbl_content_provider a LEFT JOIN tbl_service c ON c.ts_cp_id =a.tcp_id LEFT JOIN tbl_cp_connection d ON d.tcc_cp_id =a.tcp_id AND d.tcc_service_id=c.ts_id LEFT JOIN tbl_sdc_keyword e ON e.tsk_service=c.ts_id WHERE e.tsk_direction='1' AND e.tsk_msisdn='$sdc';"
;;
4)
echo "Please input CP CODE : "
read cpid
clear
#mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,b.ts_service_name as SERVICE_NAME,c.tcc_name as CONNECTION_NAME,c.tcc_system_id as USERNAME ,case when c.tcc_status='1' then 'active' else 'not active' end as CONN_STATUS ,c.tcc_password as PASSWORD, c.tcc_max_concurrent as CONCURRENT, c.tcc_throttle as TRHOTTLE, c.tcc_max_buffer as BUFFER ,c.tcc_MO_URL1 as MO_URL_1,c.tcc_MO_URL2 as MO_URL_2,c.tcc_DR_URL1 as DR_URL_1,c.tcc_DR_URL2 as DR_URL_2 FROM tbl_content_provider a LEFT JOIN tbl_service b ON b.ts_cp_id=a.tcp_id LEFT JOIN tbl_cp_connection c ON c.tcc_cp_id=a.tcp_id AND c.tcc_service_id=b.ts_id WHERE a.tcp_cp_code='$cpid';"
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,b.ts_service_name as SERVICE_NAME,c.tcc_name as CONNECTION_NAME,c.tcc_system_id as USERNAME ,case when c.tcc_status='1' then 'active' else 'not active' end as CONN_STATUS ,c.tcc_password as PASSWORD, c.tcc_max_concurrent as CONCURRENT, c.tcc_throttle as TRHOTTLE, c.tcc_max_buffer as BUFFER,c.tcc_port as PORT ,case when c.tcc_bind_type='0' then 'TRANSMITTER' when c.tcc_bind_type='1' then 'RECEIVER' else 'TRANCEIVER' end as BINDING_TYPE, c.tcc_id as CONNECTION_ID FROM tbl_content_provider a LEFT JOIN tbl_service b ON b.ts_cp_id=a.tcp_id LEFT JOIN tbl_cp_connection c ON c.tcc_cp_id=a.tcp_id AND c.tcc_service_id=b.ts_id WHERE a.tcp_cp_code='$cpid';"
;;
11)
echo "Please input CP CODE : "
read cpid
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,b.ts_service_name as SERVICE_NAME, c.tcc_MO_URL1 as MO_URL_1,c.tcc_MO_URL2 as MO_URL_2 FROM tbl_content_provider a LEFT JOIN tbl_service b ON b.ts_cp_id=a.tcp_id LEFT JOIN tbl_cp_connection c ON c.tcc_cp_id=a.tcp_id AND c.tcc_service_id=b.ts_id WHERE a.tcp_cp_code='$cpid';"
;;
12)
echo "Please input CP CODE : "
read cpid
clear
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,b.ts_service_name as SERVICE_NAME,c.tcc_name as CONNECTION_NAME,c.tcc_DR_URL1 as DR_URL_1,c.tcc_DR_URL2 as DR_URL_2 FROM tbl_content_provider a LEFT JOIN tbl_service b ON b.ts_cp_id=a.tcp_id LEFT JOIN tbl_cp_connection c ON c.tcc_cp_id=a.tcp_id AND c.tcc_service_id=b.ts_id WHERE a.tcp_cp_code='$cpid';"
;;
13)
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_ID,DATE_FORMAT(b.tb_expired,'%Y-%m-%d') as QUOTA_EXPIRED FROM sdp2.tbl_content_provider a LEFT JOIN sdp2.tbl_balance b ON b.tb_cp_id=a.tcp_id WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999','030') AND DATE_FORMAT(b.tb_expired,'%Y') <= DATE_FORMAT(NOW(),'%Y') AND DATE_FORMAT(b.last_update,'%Y') < DATE_FORMAT(NOW(),'%Y') order by b.tb_expired;"
;;
14)
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,a.tcp_end_date as CP_EXPIRED FROM tbl_content_provider a WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999','030') AND a.tcp_flag_delete='0' AND DATE_FORMAT(a.tcp_end_date,'%Y') <= DATE_FORMAT(NOW(),'%Y');";;
15)
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name as CP_NAME,a.tcp_cp_code as CP_CODE,b.ts_service_name as SERVICE_NAME
,case when b.ts_service_type='1' then 'On Demand' when b.ts_service_type='2' then 'Subscription' when b.ts_service_type='3' then 'Bulk' when b.ts_service_type='4' then 'Digital Service' else 'Bundling' end as SERVICE_TYPE,b.ts_end_date as SERVICE_EXPIRED FROM tbl_content_provider a LEFT JOIN tbl_service b ON b.ts_cp_id=a.tcp_id WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999','030') AND b.ts_flag_delete_service='0' AND a.tcp_flag_delete='0' AND DATE_FORMAT(b.ts_end_date,'%Y') <= DATE_FORMAT(NOW(),'%Y');" ;;
16)
/usr/local/mysql/bin/mysql -u hariono -ph4r10no -h 10.70.29.137 -D sdp2 -e "SELECT a.tcp_name,a.tcp_cp_code,CASE WHEN a.tcp_status='1' then 'Active' else 'Not Active' END as STATUS ,a.tcp_end_date as CP_EXPIRED ,b.ts_service_name as SERVICE_NAME, b.ts_end_date as SERVICE_EXPIRED FROM sdp2.tbl_content_provider a LEFT JOIN tbl_service b ON b.ts_cp_id=a.tcp_id WHERE a.tcp_cp_code not in ('123456789','789456123','190590','900058','999','9180','8080','1234','1235','1236','321','9111','9321','1111','99911','567','987','3333','6666','222','9191','654','7878','987654','tes','367','876','543','765','789','30','123','234','icode999') AND b.ts_service_type not in ('1','2') AND b.ts_flag_delete_service='0' AND a.tcp_flag_delete='0' ORDER BY a.tcp_cp_code;"
;;
*)
echo " WRONG INPUT !!!!!!!! "
clear
sh script/bin/check_cp_sdp.sh
;;
esac
