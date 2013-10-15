select * from clients where clients.server_id = :server_id: and 
(client_unique_id like(:client_unique_id:) or 
client_nickname like(:client_nickname:)) limit 50