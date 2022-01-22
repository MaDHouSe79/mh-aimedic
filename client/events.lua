AddEventHandler("qb-aimedic:client:loadDockter", function()
    player    = GetPlayerPed(-1)
    local playerPos = GetEntityCoords(player)
    local dokter    = GetHashKey(Config.Ped['ambulance'].model)
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