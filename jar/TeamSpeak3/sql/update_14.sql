CREATE INDEX index_group_server_to_client_id1 ON group_server_to_client (id1);
CREATE INDEX index_group_channel_to_client_id1 ON group_channel_to_client (id1);
CREATE INDEX index_group_channel_to_client_id2 ON group_channel_to_client (id2);
CREATE INDEX index_clients_lastconnectedserverid ON clients (client_lastconnected, server_id);
CREATE INDEX index_log_serverid_logid ON log (server_id, log_id);
