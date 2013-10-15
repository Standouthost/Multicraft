update perm_channel set perm_id = :new_perm_name: where perm_id = :old_perm_name:;
update perm_channel_clients set perm_id = :new_perm_name: where perm_id = :old_perm_name:;
update perm_channel_groups set perm_id = :new_perm_name: where perm_id = :old_perm_name:;
update perm_client set perm_id = :new_perm_name: where perm_id = :old_perm_name:;
update perm_server_group set perm_id = :new_perm_name: where perm_id = :old_perm_name:;