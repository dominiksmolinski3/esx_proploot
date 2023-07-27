

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

objects = {}

if Config.ObjectEnabled then
	Citizen.CreateThread(function()
	    while true do
	        Wait(0)
	        for k,v in pairs(Config.Objects) do
		        	local player = GetPlayerPed(-1)
		        	local distanceobject = 2.2
		            local obj = GetClosestObjectOfType(GetEntityCoords(player).x, GetEntityCoords(player).y, GetEntityCoords(player).z, distanceobject, v, false, true ,true)
		            local distance = GetDistanceBetweenCoords(GetEntityCoords(player), GetEntityCoords(obj), true)
		    


			    if distance <= distanceobject then

		            local ObjectCoords = GetEntityCoords(obj)

		            if not objects[obj] then
		            ESX.Game.Utils.DrawText3D(ObjectCoords + vector3(0.0, 0.0, 0.5), '~c~Search~b~[E]~c~ ', 1, 4) -- here you can customise what appears on a prop that is searchable
		        	end

		            if IsControlJustReleased(0, 38) then -- here you can change hotkey that is used to loot, default 'E' (38)
						if not objects[obj] then
			

		                    SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263, true)
		                    RequestAnimDict("anim@amb@clubhouse@tutorial@bkr_tut_ig3@")
							while not HasAnimDictLoaded("anim@amb@clubhouse@tutorial@bkr_tut_ig3@") do
								Citizen.Wait(5)
							end
							TaskPlayAnim(PlayerPedId(), "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", 2.0, 2.0, 5000, 30, 0, 0, 0, 0)
							Citizen.Wait(5000)
	
							randomChance = math.random(1, 100)
							randomWeapon = Config.WeaponLoot[math.random(1, #Config.WeaponLoot)]
							randomItem = Config.ItemLoot[math.random(1, #Config.ItemLoot)]

							if randomChance > 0 and randomChance < Config.ProbabilityWeaponLoot then
								local randomAmmo = math.random(12, 48) -- here you can choose between which numbers amount ammo will be given to weapon if you loot it
								GiveWeaponToPed(GetPlayerPed(-1), randomWeapon, randomAmmo, true, false)
								exports['mythic_notify']:DoHudText('inform','You have found a weapon.')
							elseif randomChance >= Config.ProbabilityWeaponLoot and randomChance < Config.ProbabilityMoneyLoot then
								TriggerServerEvent('cynio:money')
							elseif randomChance >= Config.ProbabilityMoneyLoot and randomChance < Config.ProbabilityItemLoot then
								TriggerServerEvent('cynio:item', randomItem)
							elseif randomChance >= Config.ProbabilityItemLoot and randomChance < 100 then
								exports['mythic_notify']:DoHudText('inform','You did not find anything...') -- here you can edit message for your language
							end
							objects[obj] = true
		               	end
		            end
		        end
		    end
		end
	end)
end
