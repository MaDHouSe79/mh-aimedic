RegisterCommand('aimedic', function(source) 
    local src = source    
    if waiting then
        local Player = QBCore.Functions.GetPlayerData(src)    
        if Player.PlayerData.metadata['isdead'] then
            QBCore.Functions.TriggerCallback('qb-aimedic:server:GetOnlineEMS', function(cb)
                if cb.status then
                    if cb.online <= Config.MinOnLineDoktors then
                        QBCore.Functions.TriggerCallback("qb-aimedic:server:PayJob", function(cb)
                            if cb.status then
                                TriggerEvent("qb-aimedic:client:loadDockter")
                                waiting = false
                                QBCore.Functions.Notify(cb.message, "primary", Config.NotifyShowTime)
                            else
                                QBCore.Functions.Notify(cb.message, "error", Config.NotifyShowTime)
                            end
                        end, 'ambulance')
                    end
                    if cb.online > Config.MinOnLineDoktors then
                        QBCore.Functions.Notify(Lang:t('error.to_many_medics'), "error", Config.NotifyShowTime)
                    end
                else
                    QBCore.Functions.Notify(Lang:t('error.unknow_error'), "error", Config.NotifyShowTime)
                end
            end, 'ambulance')
        else
             QBCore.Functions.Notify("You are not dead...", "error", Config.NotifyShowTime)
        end
    end
end, false)
