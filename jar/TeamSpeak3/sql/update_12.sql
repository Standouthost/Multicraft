CREATE TABLE custom_fields (
  server_id integer unsigned,
  client_id integer unsigned,
  ident  varchar(100) NOT NULL,
  value  varchar(255)
);
CREATE INDEX index_custom_fields_serverid ON custom_fields (server_id);
CREATE INDEX index_custom_fields_client_id ON custom_fields (client_id);
CREATE INDEX index_custom_fields_ident ON custom_fields (ident);

ALTER TABLE tokens ADD COLUMN token_created integer unsigned;
ALTER TABLE tokens ADD COLUMN token_description varchar(255);
ALTER TABLE tokens ADD COLUMN token_customset varchar(255);
