local PlayerData = nil
local objects = {}
 
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
 
local function loot(xPlayer)
    local randomChance = math.random(1, 100)
    local randomWeapon = Config.WeaponLoot[math.random(1, #Config.WeaponLoot)]
    local randomItem = Config.ItemLoot[math.random(1, #Config.ItemLoot)]
 
    if randomChance > 0 and randomChance < Config.ProbabilityWeaponLoot then
        local randomAmmo = math.random(12, 48)
        GiveWeaponToPed(PlayerPedId(), randomWeapon, randomAmmo, true, false)
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', 'You have found' .. randomWeapon })
    elseif randomChance >= Config.ProbabilityWeaponLoot and randomChance < Config.ProbabilityMoneyLoot then
        TriggerServerEvent('cynio:money')
    elseif randomChance >= Config.ProbabilityMoneyLoot and randomChance < Config.ProbabilityItemLoot then
        TriggerServerEvent('cynio:item', randomItem)
    else
        TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'You found nothing...' })
    end
end

if Config.ObjectEnabled then
	Citizen.CreateThread(function()
	    while true do
	        Citizen.Wait(1)
	        for k,v in pairs(Config.Objects) do
		            local player = PlayerPedId()
		            local distanceobject = 2.2
		            local obj = GetClosestObjectOfType(GetEntityCoords(player).x, GetEntityCoords(player).y, GetEntityCoords(player).z, distanceobject, v, false, true ,true)
		            local distance = #(GetEntityCoords(player) - GetEntityCoords(obj))
			 if distance <= distanceobject then
					local ObjectCoords = GetEntityCoords(obj)
		            if not objects[obj] then
						ESX.Game.Utils.DrawText3D(ObjectCoords + vector3(0.0, 0.0, 0.5), 'Przeszukaj', 1, 4) -- here you can customise what appears on a prop that is searchable
					end

		            if IsControlJustReleased(0, 38) then -- here you can change hotkey that is used to loot, default 'E' (38)
						if not objects[obj] then
							SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
							RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
							Citizen.Wait(1000)
							TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 2.0, 5000, 30, 0, 0, 0, 0)
							Citizen.Wait(5000)
							loot()
							objects[obj] = true
		               	end
		            end
		        end
		    end
		end
		Citizen.Wait(1000)
	end)
end
