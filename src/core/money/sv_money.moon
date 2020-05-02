moon.AddMoney = (player, amount) ->
    if not amount
        return false
    
    total = player\GetNWInt "money" + math.floor amount
    player\SetNWInt "money", total
    
    moon.StoreMoney(player, total)

moon.TransferMoney = (initiator, target, money) ->
    moon.AddMoney(initiator, -money)
    moon.AddMoney(targer, money)

moon.PayDay = (player) ->
    amount = moon.RetrieveSalary player
    
    if amount == 0 or not amount
        print "No pay day for u"
    else
        moon.AddMoney(player, amount)
        