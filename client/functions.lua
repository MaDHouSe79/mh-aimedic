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
    QBCore.Functions.Notify(Lang:t('info.getting_treatment'), "primary", 5000)
    Citizen.Wait(20000)
    ClearPedTasks(dokter)
    Behandeling(dokter)
end

function Behandeling(dokter)
    Citizen.Wait(500)
    TriggerEvent('hospital:client:Revive', -1)
    TriggerEvent("hospital:client:HealInjuries", -1, "full")
    QBCore.Functions.Notify(Lang:t('success.treatment_done',{value = Config.MoneyFormat..Config.treatCost}), "success", 5000)
    RemovePedElegantly(dokter)
    waiting = true
end


function SendMail()
    TriggerServerEvent('qb-phone:server:sendNewMail', {
	sender  = Config.Ped['ambulance'].name,
	subject = "Medische hulp",
	message = "Hello " .. gender .. " " .. charinfo.lastname .. ",<br /><br />We have just received a message that someone wants to take driving lessons<br />If you are willing to teach, please contact us:<br />Naam: <strong>".. charinfo.firstname .. " " .. charinfo.lastname .. "</strong><br />Phone Number: <strong>"..charinfo.phone.."</strong><br/><br/>Kind regards,<br />Township Los Santos",
	button  = {}
    })
end
