update servers set 
 server_month_upload= server_month_upload + :upload:,
 server_month_download= server_month_download + :download:,
 server_total_upload= server_total_upload + :upload:,
 server_total_download= server_total_download + :download:
 where server_id=:server_id:;