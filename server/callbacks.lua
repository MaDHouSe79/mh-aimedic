QBCore.Functions.CreateCallback('qb-aimedic:server:GetOnlineEMS', function(source, cb, job)
    local result = QBCore.Functions.GetDutyCount('ambulance')
    if result ~= nil or result >= 0 then
	cb({
	    status = true,
	    online = result
	})
    else
	cb({
	    status = false,
	    online = 0
	})
    end
end)

QBCore.Functions.CreateCallback('qb-aimedic:server:PayJob', function(source, cb, job)
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.Functions.RemoveMoney("cash", Config.treatCost, "revived-player") then
	TriggerClientEvent('hospital:client:Revive', source)
	SocietyAccount(job)
	cb({
		status = true, 
		message = Lang:t('info.getting_treatment') 
	})
    else
	if Player.Functions.RemoveMoney("bank", Config.treatCost, "revived-player") then
	    TriggerClientEvent('hospital:client:Revive', source)
	    SocietyAccount(job)
	    cb({
		status = true, 
		message = Lang:t('info.getting_treatment')
	    })
	else
	    cb({
		status = false, 
		message = Lang:t('error.not_enough_money')
	    })
	end
    end
end)
