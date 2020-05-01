moon.teams = {}

jobCount = 0

moon.GetJobTable = (player) ->
    moon.teams[player\Team!]

moon.CreateJob = (name, cteam) ->
    cteam.name = name
    cteam.salary = math.floor cteam.salary
    
    jobCount += 1
    
    cteam.team = jobCount
    table.insert moon.teams, cteam
    
    team.SetUp #moon.teams, name, cteam.color
    
    if istable cteam.model
        for model in *cteam.model
            util.PrecacheModel model
    else
        util.PrecacheModel cteam.model
    
    #moon.teams