function NPCDoktor(x, y, z, doktorModel)
    dokter = CreatePed(4, doktorModel, GetEntityCoords(player), spawnHeading, true, false)  
    RequestAnimDict("mini@cpr@char_a@cpr_str")
    while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
	Citizen.Wait(1000)
    end
    TaskPlayAnim(dokter, "mini@cpr@char_a@cpr_str","cpr_pumpchest",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
    BeginBehandeling(dokter)
end

function BeginBehandeling(dokter)
    QBCore.Functions.Notify(Lang:t('info.getting_treatment'), "primary", Config.NotifyShowTime)
    Citizen.Wait(20000)
    ClearPedTasks(dokter)
    Behandeling(dokter)
end

function Behandeling(dokter)
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

function SendMail(mail_sender, mail_subject, mail_message)
    TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender  = mail_sender,
	subject = mail_subject,
	message = mail_message,
	button  = {}
    })
end

function GetStreetName()
    local ped       = GetPlayerPed(-1);
    local veh       = GetVehiclePedIsIn(ped, false);
    local coords    = GetEntityCoords(PlayerPedId());
    local zone      = GetNameOfZone(coords.x, coords.y, coords.z);
    local zoneLabel = GetLabelText(zone);
    local var1, var2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
    hash1 = GetStreetNameFromHashKey(var1);
    hash2 = GetStreetNameFromHashKey(var2);
    local street;
    if (hash2 == '') then
	street = zoneLabel;
    else
	street = hash2..', '..zoneLabel;
    end
    return street;
end
