moon.hook.Add "PlayerInitialSpawn", "player_spawn", (player) -> 
    moon.RestorePlayerData player
    
    moon.UpdateJob player, team.GetName moon.defaultTeam
    player\SetNWInt "salary", moon.RetrieveSalary player

    player\SetTeam moon.defaultTeam