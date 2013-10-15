update perm_channel set perm_id = "i_icon_id" where perm_id = "i_group_icon_id";
update perm_channel set perm_id = "i_needed_modify_power_icon_id" where perm_id = "i_needed_modify_power_group_icon_id";
update perm_channel set perm_id = "i_max_icon_filesize" where perm_id = "i_group_max_icon_filesize";
update perm_channel set perm_id = "i_needed_modify_power_max_icon_filesize" where perm_id = "i_needed_modify_power_group_max_icon_filesize";
update perm_channel set perm_id = "b_icon_manage" where perm_id = "b_group_icon_manage";
update perm_channel set perm_id = "i_needed_modify_power_icon_manage" where perm_id = "i_needed_modify_power_group_icon_manage";

update perm_channel_clients set perm_id = "i_icon_id" where perm_id = "i_group_icon_id";
update perm_channel_clients set perm_id = "i_needed_modify_power_icon_id" where perm_id = "i_needed_modify_power_group_icon_id";
update perm_channel_clients set perm_id = "i_max_icon_filesize" where perm_id = "i_group_max_icon_filesize";
update perm_channel_clients set perm_id = "i_needed_modify_power_max_icon_filesize" where perm_id = "i_needed_modify_power_group_max_icon_filesize";
update perm_channel_clients set perm_id = "b_icon_manage" where perm_id = "b_group_icon_manage";
update perm_channel_clients set perm_id = "i_needed_modify_power_icon_manage" where perm_id = "i_needed_modify_power_group_icon_manage";

update perm_channel_groups set perm_id = "i_icon_id" where perm_id = "i_group_icon_id";
update perm_channel_groups set perm_id = "i_needed_modify_power_icon_id" where perm_id = "i_needed_modify_power_group_icon_id";
update perm_channel_groups set perm_id = "i_max_icon_filesize" where perm_id = "i_group_max_icon_filesize";
update perm_channel_groups set perm_id = "i_needed_modify_power_max_icon_filesize" where perm_id = "i_needed_modify_power_group_max_icon_filesize";
update perm_channel_groups set perm_id = "b_icon_manage" where perm_id = "b_group_icon_manage";
update perm_channel_groups set perm_id = "i_needed_modify_power_icon_manage" where perm_id = "i_needed_modify_power_group_icon_manage";

update perm_client set perm_id = "i_icon_id" where perm_id = "i_group_icon_id";
update perm_client set perm_id = "i_needed_modify_power_icon_id" where perm_id = "i_needed_modify_power_group_icon_id";
update perm_client set perm_id = "i_max_icon_filesize" where perm_id = "i_group_max_icon_filesize";
update perm_client set perm_id = "i_needed_modify_power_max_icon_filesize" where perm_id = "i_needed_modify_power_group_max_icon_filesize";
update perm_client set perm_id = "b_icon_manage" where perm_id = "b_group_icon_manage";
update perm_client set perm_id = "i_needed_modify_power_icon_manage" where perm_id = "i_needed_modify_power_group_icon_manage";

update perm_server_group set perm_id = "i_icon_id" where perm_id = "i_group_icon_id";
update perm_server_group set perm_id = "i_needed_modify_power_icon_id" where perm_id = "i_needed_modify_power_group_icon_id";
update perm_server_group set perm_id = "i_max_icon_filesize" where perm_id = "i_group_max_icon_filesize";
update perm_server_group set perm_id = "i_needed_modify_power_max_icon_filesize" where perm_id = "i_needed_modify_power_group_max_icon_filesize";
update perm_server_group set perm_id = "b_icon_manage" where perm_id = "b_group_icon_manage";
update perm_server_group set perm_id = "i_needed_modify_power_icon_manage" where perm_id = "i_needed_modify_power_group_icon_manage";
