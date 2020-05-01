moon.commands = {}

moon.AddCommand = (name, callback) ->
	if moon.commands[name]
		print "Callback already installed for command #{name}"
	else
		moon.commands[name] = callback

moon.net.AddNetworkString "executeCallback"
moon.net.Receive "executeCallback", (_, player) ->
	text = net.ReadString!

	args = {}
	for arg in *text\gmatch("%S+")
		if #args == 0
			command = arg
		else
			args[#args + 1] = arg


	if moon.commands[command]
		moon.commands[command](player, args)