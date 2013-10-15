CREATE INDEX index_servers_port ON servers (server_port);
CREATE INDEX index_messages_msgidtoclid_read ON messages (message_to_client_id, message_flag_read);
