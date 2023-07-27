fx_version 'adamant'
game 'gta5'

author 'cynio'
description 'Prop looting system for FIVEM ESX LEGACY (Supporting ESX)'
version '1.7.1'

shared_scripts {
    'config.lua',
	'@es_extended/imports.lua'
}
server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}
