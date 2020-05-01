moon.ChangeTeam = (player, team) ->
    TEAM = moon.teams[team]
    if not TEAM
        false
        
    moon.UpdateJob player, TEAM.name
    player\SetNWInt "salary", TEAM.salary
    player\SetTeam team
    
    true

moon.UpdateJob = (player, job) ->
    player\SetNWString "job", job
    
    timer.Create "#{player\SteamID64!}_jobtimer", moon.config.payDayDelay, 0, ->
        if not IsValid player
            return
        moon.PayDay player