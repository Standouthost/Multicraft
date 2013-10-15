update clients set 
 client_month_upload= client_month_upload + :upload:,
 client_month_download= client_month_download + :download:,
 client_total_upload= client_total_upload + :upload:,
 client_total_download= client_total_download + :download:
 where client_id=:client_id:;