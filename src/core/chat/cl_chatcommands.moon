moon.hook.Add "OnPlayerChat", "playerChat", (player, text) ->
	moon.net.Start "executeCallback"
	net.WriteString text
	moon.net.SendToServer!