moon.hook.Add "PlayerInitialSpawn", "player_spawn", (player) -> 
    moon.RestorePlayerData player
    
    moon.UpdateJob player, team.GetName moon.defaultTeam
    player\SetNWInt "salary", moon.RetrieveSalary player

    player\SetTeam moon.defaultTeam

moon.hook.Add "PlayerCanHearPlayersVoice", "can_hear", (listener, player) ->
    if not player\IsValid! and listener\IsValid!
        false
    
    radius = moon.config.talkRadius
	distToSqr = player\GetPos!\DistToSqr listener:GetPos!

    if player\Alive! and distToSqr <= radius and not player\isUnconscious!
        true

    false