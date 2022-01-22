fx_version 'adamant'

game 'gta5'

description 'QBCore AI Medic Created By MaDHouSe, free to use for the community'

version '1.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    '@qb-core/shared/jobs.lua',
    'locales/*.lua',
    'config.lua',
}

client_scripts {
    'client/main.lua',
    'client/commands.lua',
    'client/functions.lua',
    'client/events.lua',
    
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/callbacks.lua',
    'server/functions.lua',
}
