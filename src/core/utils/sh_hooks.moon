moon.hook = 
    Add: (name, cname, func) ->
        hook.Add name, "moon.#{cname}", func
    Call: (name, gtable, args) ->
        hook.Call "moon.#{name}", gtable, args