insert into clients
( server_id,
  client_unique_id,
  client_nickname,
  client_lastconnected)
VALUES 
( :server_id:,
  :client_unique_id:,
  :client_nickname:,
  :client_lastconnected:);
