moon.hook = 
    Add: (name, cname, func) ->
        hook.Add(name, "moon.#{cname}", func)