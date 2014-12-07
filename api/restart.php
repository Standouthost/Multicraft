<?php

require('MulticraftAPI.php');
$api = new MulticraftAPI('http://panel.example.com/api.php', 'python', '3b08e8672bf');
print_r($api->restartServer($argv[1]));
