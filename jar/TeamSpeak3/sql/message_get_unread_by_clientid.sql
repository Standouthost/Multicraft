select count(*) as unread from messages where message_to_client_id= :message_to_client_id: and message_flag_read= 0;
