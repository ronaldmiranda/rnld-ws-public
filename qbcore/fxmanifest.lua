fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
games { 'rdr3', 'gta5' }
lua54 'yes'

author 'sistema logs RNLD STORE'
description 'RNLD API'
version '2.0.0'


escrow_ignore {
  'config.lua',
}

shared_scripts {
  '@ox_lib/init.lua'
}

server_scripts {
  "server.lua",
  "server.js"
}
