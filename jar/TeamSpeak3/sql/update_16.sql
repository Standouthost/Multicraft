ALTER TABLE instance_properties ADD COLUMN string_id varchar(255);
CREATE INDEX index_instance_properties_string_id ON instance_properties (string_id);
update instance_properties set string_id = ""