moon.net.Receive "chat", ->
    col1 = Color net.ReadUInt 8, net.ReadUInt 8, net.ReadUInt 8
    
    prefixText = net.ReadString!
    player = net.ReadEntity!
    player = IsValid player and player or LocalPlayer!

    if not IsValid player
        return
    
    if prefixText == "" or not prefixText
        prefixText = ply\Nick!
        prefixText = prefixText ~= "" and prefixText or ply\SteamName!
    
    col2 = Color net.ReadUInt 8, net.ReadUInt 8, net.ReadUInt 8

    text = net.ReadString!
    local shouldShow
    if text and text ~= "" then
        if IsValid player
            shouldShow = hook.Call "OnPlayerChat", GAMEMODE, player, text, false, not player\Alive!, prefixText, col1, col2

        if shouldShow ~= true
            chat.AddNonParsedText(col1, prefixText, col2, ": " .. text)
    else
        shouldShow = hook.Call("ChatText", GAMEMODE, "0", prefixText, prefixText, "moonlight")

        if shouldShow ~= true
            chat.AddNonParsedText(col1, prefixText)
    chat.PlaySound()