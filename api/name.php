<?php

require('MulticraftAPI.php');
$api = new MulticraftAPI('http://panel.example.com/api.php', 'python', '3b0f569e8672bf');
print_r($api->getServer($argv[1]));
