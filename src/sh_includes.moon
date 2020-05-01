moon.IncludeSharedFile = (file) ->
    AddCSLuaFile(file) if SERVER
    return include(file)

moon.IncludeClientFile = (file) ->
    AddCSLuaFile(file) if SERVER
    return include(file) if CLIENT

moon.IncludeServerFile = (file) ->
    return include(file) if SERVER

moon.IncludeModule = (name) ->
    initFilePath = "core/#{name}/sh_init.lua"
    moon.IncludeSharedFile(initFilePath)

moon.IncludeFiles = (files) ->
    moon.IncludeSharedFile(fileName) for fileName in *files.shared
    moon.IncludeServerFile(fileName) for fileName in *files.server
    moon.IncludeClientFile(fileName) for fileName in *files.client