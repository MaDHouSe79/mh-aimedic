local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = {}
local waiting = true
local player, dokter = nil

local function GetStreetName()
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local coords = GetEntityCoords(PlayerPedId())
    local zone = GetNameOfZone(coords.x, coords.y, coords.z)
    local zoneLabel = GetLabelText(zone)
    local var = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    local hash = GetStreetNameFromHashKey(var)
    local street
    if (hash == '') then street = zoneLabel else street = hash..', '..zoneLabel end
    return street;
end

local function SendMail(mail_sender, mail_subject, mail_message)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
        sender  = mail_sender,
        subject = mail_subject,
        message = mail_message,
        button  = {}
    })
end

local function Treatment(dokter)
    Citizen.Wait(500)
    TriggerEvent('hospital:client:Revive', -1)
    TriggerEvent("hospital:client:HealInjuries", -1, "full")
    QBCore.Functions.Notify(Lang:t('success.treatment_done',{value = Config.MoneyFormat..Config.treatCost}), "success", Config.NotifyShowTime)
    RemovePedElegantly(dokter)
    waiting = true
    SendMail(
        Lang:t('mail.sender', {docter = Config.Ped['ambulance'].name}), 
        Lang:t('mail.subject'), 
        Lang:t('mail.message', {streetName = GetStreetName(), username = PlayerData.username, company = Config.Ped['ambulance'].company})
    )
end

local function StartTreatment(dokter)
    QBCore.Functions.Notify(Lang:t('info.getting_treatment'), "primary", Config.NotifyShowTime)
    Citizen.Wait(20000)
    ClearPedTasks(dokter)
    Treatment(dokter)
end

local function NPCDoktor(x, y, z, doktorModel)
    dokter = CreatePed(4, doktorModel, GetEntityCoords(player), spawnHeading, true, false)  
    RequestAnimDict("mini@cpr@char_a@cpr_str")
    while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do Citizen.Wait(1000) end
    TaskPlayAnim(dokter, "mini@cpr@char_a@cpr_str","cpr_pumpchest",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
    StartTreatment(dokter)
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()	
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(data)
    PlayerData = data
end)

AddEventHandler("mh-aimedic:client:loadDockter", function()
    player = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local dokter = GetHashKey(Config.Ped['ambulance'].model)
    RequestModel(dokter)
    while not HasModelLoaded(dokter) and RequestModel(dokter) do
        RequestModel(dokterscode)
        Citizen.Wait(0)
    end
    if DoesEntityExist(dokter) then
	    NPCDoktor(playerPos.x, playerPos.y, playerPos.x, dokter)
    else
	    NPCDoktor(playerPos.x, playerPos.y, playerPos.x, dokter)
    end
    ClearPedTasksImmediately(player)
end)

RegisterCommand('aimedic', function() 
    if waiting then
        PlayerData = QBCore.Functions.GetPlayerData()
        if PlayerData.metadata['isdead'] --[[ or PlayerData.metadata['inlaststand'] ]] then
            QBCore.Functions.TriggerCallback('mh-aimedic:server:GetOnlineEMS', function(cb)
                if cb.status then
                    if cb.online <= Config.MinOnLineDoktors then
                        QBCore.Functions.TriggerCallback("mh-aimedic:server:PayJob", function(cb)
                            if cb.status then
                                TriggerEvent("mh-aimedic:client:loadDockter")
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
