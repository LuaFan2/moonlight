moon.commands = {}

moon.net.AddNetworkString "chat"

moon.AddCommand = (name, callback) ->
	if moon.commands[name]
		print "Callback already installed for command #{name}"
	else
		moon.commands[name] = callback

moon.rangeChat = (player, name, text, radius) ->
    ents = ents.FindInSphere player\EyePos!, radius
    col = team.GetColor player\Team!
    filter = {}

    for ent in *ents
        if ent\IsPlayer! and not ent\IsBot!
            table.insert(filter, v)
    
    if name == player\Nick!
        name = ""
    
    moon.net.Start "chat"
        net.WriteUInt col.r, 8
        net.WriteUInt col.g, 8
        net.WriteUInt col.b, 8
        net.WriteString name
        net.WriteEntity player
        net.WriteUInt 255, 8
        net.WriteUInt 255, 8
        net.WriteUInt 255, 8
        net.WriteString text
    moon.net.Send filter

moon.hook.Add "PlayerSay", "chat_handler", (player, text) ->
	args = {}
	local command
	
	for arg in *text\gmatch("%S+")
		if #args == 0
			command = arg\gsub '/', ''
		else
			args[#args + 1] = arg
    
    if command
	    if moon.commands[command]
		    moon.commands[command](player, args)
		else
		    moon.rangeChat(player, player\Nick!, text, moon.config.talkRadius)
    
    true