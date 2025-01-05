fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'king_bridge'
author 'gadget2'
description 'A bridge that helps with fivem resource compatibility'
version '0.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'core/shared.lua'
}

client_scripts {
    'core/**/client.lua'
}

server_scripts {
    'core/**/server.lua'
}

files {
    'locales/*.json',
    'modules/**',
    'api.lua'
}

dependency 'ox_lib'
ox_lib 'locale'