function SocietyAccount(job)
    if Config.UseSocietyAccount then 
	    TriggerEvent('qb-bossmenu:server:addAccountMoney', job, Config.treatCost)
    end
    TriggerClientEvent('hospital:client:SendBillEmail', job, Config.treatCost)
end