fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

name 'king_bridge'
author 'gadget2'
description 'A bridge that helps with framework compatibility'
version '0.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'core/shared.lua'
}

server_scripts {
    'code/core/**/server.lua'
}

files {
    'locales/*.json',
    'config/**',
    'code/modules/**'
}

dependency 'ox_lib'
ox_lib 'locale'