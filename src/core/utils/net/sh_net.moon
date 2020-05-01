moon.net = 
    AddNetworkString: (name) ->
        networkString = 'moon.' .. name
        util.AddNetworkString networkString
    Receive: (name, callback) ->
        networkString = 'moon.' .. name
        net.Receive networkString, callback
    Start: (name) ->
        networkString = 'moon.' .. name
        net.Start networkString
    SendToServer: ->
        net.SendToServer!
    WriteSteamId: do 
        steamIdInformationStart = #'STEAM_' + 1
        (steamId) ->
            if steamId == 'BOT'
                net.WriteBool(true)
            else
                net.WriteBool(false)
                steamIdInformation = string.sub(steamId, steamIdInformationStart)
                {universe, id, accountNumber} = string.Explode(':', steamIdInformation)
                net.WriteUInt(tonumber(universe), 3)
                net.WriteBool(id == '1')
                net.WriteUInt(tonumber(accountNumber), 32)

    ReadSteamId: () ->
        isBot = net.ReadBool()
        if isBot
            return 'BOT'
        else
            universe = net.ReadUInt(3)
            id = net.ReadBit()
            accountNumber = net.ReadUInt(32)
            return "STEAM_#{universe}:#{id}:#{accountNumber}"