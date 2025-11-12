fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author '3mk Automation'
description 'Gang computer interaction with qb-target eye system'

shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    'server.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}
