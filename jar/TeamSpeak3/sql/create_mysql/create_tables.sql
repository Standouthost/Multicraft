CREATE TABLE channel_properties (
  server_id int unsigned,
  id     int unsigned,
  ident  varchar(255) NOT NULL,
  value  varchar(8192)
);
CREATE INDEX index_channel_properties_id ON channel_properties (id);
CREATE INDEX index_channel_properties_serverid ON channel_properties (server_id);

CREATE TABLE channels (
  channel_id         int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  channel_parent_id  int unsigned,
  server_id          int unsigned NOT NULL
);
CREATE INDEX index_channels_id ON channels (channel_id);
CREATE INDEX index_channels_serverid ON channels (server_id);

CREATE TABLE client_properties (
  server_id int unsigned,
  id     int unsigned,
  ident  varchar(100) NOT NULL,
  value  varchar(255)
);
CREATE INDEX index_client_properties_id ON client_properties (id);
CREATE INDEX index_client_properties_serverid ON client_properties (server_id);

CREATE TABLE clients (
  client_id               int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  server_id               int unsigned,
  client_unique_id        varchar(40),
  client_nickname         varchar(100),
  client_login_name       varchar(20) UNIQUE,
  client_login_password   varchar(40),
  client_lastconnected    int unsigned,
  client_totalconnections int unsigned default 0,
  client_month_upload     bigint unsigned default 0,
  client_month_download   bigint unsigned default 0,
  client_total_upload     bigint unsigned default 0,
  client_total_download   bigint unsigned default 0,
  client_lastip           varchar(20)
);
CREATE INDEX index_clients_id ON clients (client_id);
CREATE INDEX index_clients_serverid ON clients (server_id);
CREATE INDEX index_clients_lastconnectedserverid ON clients (client_lastconnected, server_id);
CREATE INDEX index_clients_uid ON clients (client_unique_id, server_id);

CREATE TABLE groups_channel (
  group_id    int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  server_id   int unsigned NOT NULL,
  name        varchar(50) NOT NULL,
  type        int NOT NULL
);
CREATE INDEX index_groups_channel_id ON groups_channel (group_id);
CREATE INDEX index_groups_channel_serverid ON groups_channel (server_id);

CREATE TABLE groups_server (
  group_id    int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  server_id   int unsigned NOT NULL,
  name        varchar(50) NOT NULL,
  type        int NOT NULL
);
CREATE INDEX index_groups_server_id ON groups_server (group_id);
CREATE INDEX index_groups_server_serverid ON groups_server (server_id);

CREATE TABLE group_server_to_client (
  group_id        int unsigned NOT NULL,
  server_id       int unsigned NOT NULL,
  id1             int unsigned NOT NULL,
  id2             int unsigned NOT NULL
);
CREATE INDEX index_group_server_to_client_id ON group_server_to_client (group_id);
CREATE INDEX index_group_server_to_client_serverid ON group_server_to_client (server_id);
CREATE INDEX index_group_server_to_client_id1 ON group_server_to_client (id1);

CREATE TABLE group_channel_to_client (
  group_id        int unsigned NOT NULL,
  server_id       int unsigned NOT NULL,
  id1             int unsigned NOT NULL,
  id2             int unsigned NOT NULL
);
CREATE INDEX index_group_channel_to_client_id ON group_channel_to_client (group_id);
CREATE INDEX index_group_channel_to_client_serverid ON group_channel_to_client (server_id);
CREATE INDEX index_group_channel_to_client_id1 ON group_channel_to_client (id1);
CREATE INDEX index_group_channel_to_client_id2 ON group_channel_to_client (id2);

CREATE TABLE perm_channel (
  server_id    int unsigned NOT NULL,
  id1          int unsigned NOT NULL,
  id2          int unsigned NOT NULL,
  perm_id      varchar(100) NOT NULL,
  perm_value   int,
  perm_negated int,
  perm_skip    int
);
CREATE INDEX index_perm_channel_serverid ON perm_channel (server_id);

CREATE TABLE perm_channel_clients (
  server_id    int unsigned NOT NULL,
  id1          int unsigned NOT NULL,
  id2          int unsigned NOT NULL,
  perm_id      varchar(100) NOT NULL,
  perm_value   int,
  perm_negated int,
  perm_skip    int
);
CREATE INDEX index_perm_channel_clients_serverid ON perm_channel_clients (server_id);

CREATE TABLE perm_channel_groups (
  server_id    int unsigned NOT NULL,
  id1          int unsigned NOT NULL,
  id2          int unsigned NOT NULL,
  perm_id      varchar(100) NOT NULL,
  perm_value   int,
  perm_negated int,
  perm_skip    int
);
CREATE INDEX index_perm_channel_groups_serverid ON perm_channel_groups (server_id);

CREATE TABLE perm_client (
  server_id    int unsigned NOT NULL,
  id1          int unsigned NOT NULL,
  id2          int unsigned NOT NULL,
  perm_id      varchar(100) NOT NULL,
  perm_value   int,
  perm_negated int,
  perm_skip    int
);
CREATE INDEX index_perm_client_serverid ON perm_client (server_id);

CREATE TABLE perm_server_group (
  server_id    int unsigned NOT NULL,
  id1          int unsigned NOT NULL,
  id2          int unsigned NOT NULL,
  perm_id      varchar(100) NOT NULL,
  perm_value   int,
  perm_negated int,
  perm_skip    int
);
CREATE INDEX index_perm_server_group_serverid ON perm_server_group (server_id);

CREATE TABLE bindings (
  binding_id int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  ip         varchar(20) NOT NULL,
  type       int
);

CREATE TABLE server_properties (
  server_id int unsigned,
  id     int unsigned,
  ident  varchar(100) NOT NULL,
  value  varchar(2048)
);
CREATE INDEX index_server_properties_id ON server_properties (id);
CREATE INDEX index_server_properties_serverid ON server_properties (server_id);

CREATE TABLE servers (
  server_id             int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  server_port           int unsigned,
  server_autostart      int unsigned,
  server_machine_id     varchar(50),
  server_month_upload   bigint unsigned default 0,
  server_month_download bigint unsigned default 0,
  server_total_upload   bigint unsigned default 0,
  server_total_download bigint unsigned default 0
);
CREATE INDEX index_servers_serverid ON servers (server_id);
CREATE INDEX index_servers_port ON servers (server_port);
  
CREATE TABLE tokens (
  server_id         int unsigned,
  token_key         varchar(50) NOT NULL,
  token_type        int,
  token_id1         int unsigned,
  token_id2         int unsigned,
  token_created     int unsigned,
  token_description varchar(255),
  token_customset   varchar(255)
 );

CREATE TABLE messages (
  message_id              int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  server_id               int unsigned,
  message_from_client_id  int unsigned,
  message_from_client_uid varchar(40),
  message_to_client_id    int unsigned,
  message_subject         varchar(255),
  message_msg             text,
  message_timestamp       int unsigned,
  message_flag_read       int default 0
);
CREATE INDEX index_messages_serverid ON messages (server_id);
CREATE INDEX index_messages_msgidtoclid_read ON messages (message_to_client_id, message_flag_read);

CREATE TABLE complains (
  server_id               int unsigned,
  complain_from_client_id int unsigned,
  complain_to_client_id   int unsigned,
  complain_message        varchar(255),
  complain_timestamp      int unsigned,
  complain_hash           varchar(255)
);
CREATE INDEX index_complains_serverid ON complains (server_id);

CREATE TABLE bans (
  ban_id                  int PRIMARY KEY AUTO_INCREMENT NOT NULL,
  server_id               int unsigned,
  ban_ip                  varchar(255),
  ban_name                varchar(2048),
  ban_uid                 varchar(255),
  ban_timestamp           int unsigned,
  ban_length              int unsigned,
  ban_invoker_client_id   int unsigned,
  ban_invoker_uid         varchar(40),
  ban_invoker_name        varchar(255),
  ban_reason              varchar(255),
  ban_enforcements        int unsigned default 0
);
CREATE INDEX index_bans_serverid ON bans (server_id);

CREATE TABLE instance_properties (
  server_id int unsigned,
  string_id varchar(255),
  id     int unsigned,
  ident  varchar(100) NOT NULL,
  value  varchar(255)
);
CREATE INDEX index_instance_properties_id ON instance_properties (id);
CREATE INDEX index_instance_properties_string_id ON instance_properties (string_id);
CREATE INDEX index_instance_properties_serverid ON instance_properties (server_id);

CREATE TABLE custom_fields (
  server_id integer unsigned,
  client_id integer unsigned,
  ident  varchar(100) NOT NULL,
  value  varchar(255)
);
CREATE INDEX index_custom_fields_serverid ON custom_fields (server_id);
CREATE INDEX index_custom_fields_client_id ON custom_fields (client_id);
CREATE INDEX index_custom_fields_ident ON custom_fields (ident);
