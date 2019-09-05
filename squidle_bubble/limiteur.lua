local ind = {l = false, r = false}

local speedBuffer  = {}
local velBuffer    = {}

IsCar = function(veh)
		    local vc = GetVehicleClass(veh)
		    return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end	

Fwv = function (entity)
		    local hr = GetEntityHeading(entity) + 90.0
		    if hr < 0.0 then hr = 360.0 + hr end
		    hr = hr * 0.0174533
		    return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end


local enableCruise = false
Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 0 )   
		local ped = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(ped, false)
		local vehicleModel = GetEntityModel(vehicle)
		local speed = GetEntitySpeed(vehicle)
		local float Max = GetVehicleMaxSpeed(vehicleModel)
			if ( ped ) then
				if IsControlJustPressed(1, 137) then  -- https://docs.fivem.net/game-references/controls/
					local inVehicle = IsPedSittingInAnyVehicle(ped)
					if (inVehicle) then
						if (GetPedInVehicleSeat(vehicle, -1) == ped) then
							if enableCruise == false then 
							SetVehicleMaxSpeed(vehicle, speed)
							enableCruise = true
				SendNUIMessage({
						cruise = true,
						TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = 'Limiteur de vitesse activé.' })
					})else
					SetVehicleMaxSpeed(vehicle, Max)
					enableCruise = false
					TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Limiteur de vitesse désactivé.' })
					SendNUIMessage({
						cruise = false,
					})
					end 
						else
							TriggerEvent('mythic_notify:client:SendAlert', { type = 'error', text = 'Vous devez être dans un véhicule.' })
						end
					end
				end
			end
		end
end)
