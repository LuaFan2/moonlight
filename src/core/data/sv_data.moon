hook.Add "Initialize", "initialize_data", ->
    moon.InitDatabase!

moon.InitDatabase = ->
    sql.Begin()
    sql.Query([[
        CREATE TABLE IF NOT EXISTS moon_players(
            uid BIGINT NOT NULL PRIMARY KEY,
            rpname VARCHAR(45),
            wallet BIGINT NOT NULL
        );
    ]])
    sql.Commit()

moon.StoreRPName = (player, name) ->
    if not name or string.len name < 2
        return
    
    player\SetNWString "name", name
    sql.Query "UPDATE moon_players SET rpname = #{SQLStr(name)} WHERE uid = #{player\SteamID64!}"
    sql.Commit!

moon.StoreMoney = (player, money) ->
    if not isnumber amount or amount < 0 or amount >= 1 / 0
        return
    
    sql.Query "UPDATE moon_players SET wallet = #{money} WHERE uid = #{player\SteamID64!}"

moon.StoreSalary = (player, amount) ->
    player\SetNWInt "salary", math.floor(amount)
    amount
    
moon.RetrieveSalary = (player) ->
    val = moon.GetJobTable(player) and moon.GetJobTable(player).salary or moon.config.minimumSalary
    math.floor val

moon.RetrievePlayerData = (player) ->
    sql.QueryRow "SELECT * FROM moon_players WHERE uid = #{player\SteamID64!}"

moon.CreatePlayerData = (player, rpname, wallet) ->
    sql.Query "INSERT INTO moon_players(uid, rpname, wallet) VALUES(#{player\SteamID64!}, #{SQLStr(rpname)}, #{wallet})"
    sql.Commit()

moon.RestorePlayerData = (player) ->
    data = moon.RetrievePlayerData player
    
    info = data and data[1] or {}
    if not info.rpname or info.rpname == "NULL"
        info.rpname = string.gsub player\Name!, "\\\"", "\""
    
    info.wallet = info.wallet or moon.config.startingMoney
    info.salary = moon.RetrieveSalary player
    
    player\SetNWInt "money", info.wallet
    player\SetNWString "rpname", info.rpname
    
    player\SetNWInt "salary", info.salary
    if not data
        moon.CreatePlayerData player, info.rpname, info.wallet