delete from channels where channel_id=:channel_id:;
delete from channel_properties where id=:channel_id:;
delete from group_channel_to_client where server_id=:server_id: and id2=:channel_id:;
delete from perm_channel where server_id=:server_id: and id1=:channel_id:;
delete from perm_channel_clients where server_id=:server_id: and id1=:channel_id:;
delete from tokens where token_type=1 and token_id2=:channel_id:;