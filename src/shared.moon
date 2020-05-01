export moon

moon = {}

AddCSLuaFile('sh_includes.lua')
include('sh_includes.lua')

moon.config = {}
moon.IncludeSharedFile('config/config.lua')

modules = {
    core: {
        'utils',
        'data',
        'money',
        'jobs',
        'base',
        'chat'
    }
}

for module in *modules.core
    moon.IncludeModule(module)
    
root = GM.FolderName .. "/gamemode/customs/"
files, _ = file.Find root .. "*", "LUA"

for file in *files
    AddCSLuaFile root .. file
    include root .. file
