delete from :tablegroup: where group_id = :group_id:;
delete from :tableperms: where id1 = :group_id:;
delete from :tablemembers: where group_id = :group_id:;