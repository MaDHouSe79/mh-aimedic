local  QBCore = exports['qb-core']:GetCoreObject()

local function SocietyAccount(job)
    if Config.UseSocietyAccount then 
        TriggerEvent('qb-bossmenu:server:addAccountMoney', job, Config.treatCost)
    end
    TriggerClientEvent('hospital:client:SendBillEmail', job, Config.treatCost)
end

QBCore.Functions.CreateCallback('qb-aimedic:server:GetOnlineEMS', function(source, cb, job)
    local result = QBCore.Functions.GetDutyCount(job)
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
