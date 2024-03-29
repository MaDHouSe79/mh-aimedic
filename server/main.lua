local  QBCore = exports['qb-core']:GetCoreObject()

local function SocietyAccount(job)
    if Config.UseSocietyAccount then 
        TriggerEvent('qb-bossmenu:server:addAccountMoney', job, Config.treatCost)
    end
    TriggerClientEvent('hospital:client:SendBillEmail', job, Config.treatCost)
end

QBCore.Functions.CreateCallback('mh-aimedic:server:GetOnlineEMS', function(source, cb, job)
    cb(QBCore.Functions.GetDutyCount(job))
end)

QBCore.Functions.CreateCallback('mh-aimedic:server:PayJob', function(source, cb, job)
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
