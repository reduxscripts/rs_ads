fx_version 'cerulean'

lua54 'yes'

game 'gta5'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'

ui_page('index.html')

files({
    'index.html',
    'app.js',
})