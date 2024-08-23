-- exports["rpemotes"]:IsPlayerInAnim()

RegisterNetEvent("adjustAnim")
AddEventHandler("adjustAnim", function ()
    local ped = PlayerPedId()
    local getPlayerAnim = exports["rpemotes"]:IsPlayerInAnim()
    if getPlayerAnim and not IsPedInAnyVehicle(ped, false) then

        ---- Setup Clone Ped
        local clonePed = ClonePed(ped, false, false, true)
        local getAnim = exports["rpemotes"]:getPlayerAnim()
        local animOption = getAnim.AnimationOptions
        SetEntityNoCollisionEntity(ped, clonePed, false)
        TaskPlayAnim(clonePed, getAnim[1], getAnim[2], 2.0, 2.0, -1, 0, 0, false, false, false)
        SetEntityHeading(clonePed, GetEntityHeading(ped))
        SetEntityAlpha(clonePed, 50, true)
        FreezeEntityPosition(clonePed, true)

        FreezeEntityPosition(ped, true)

        CreateThread(function()
            while getPlayerAnim do 
                if not IsEntityPlayingAnim(clonePed, getAnim[1], getAnim[2], 3)  then
                    TaskPlayAnim(clonePed, getAnim[1], getAnim[2], 5.0, 5.0, animOption.EmoteDuration, animOption.MovementType, 0, false, false, false)
                end
                Wait(clonePed and 0 or 1000)
            end
        end)

        exports.object_gizmo:useGizmo(clonePed)
        
        ---- When confirm gizmo 
        local clonePedPose, clonepedHeading = GetEntityCoords(clonePed), GetEntityHeading(clonePed)
        DeleteEntity(clonePed)
        SetEntityCoordsNoOffset(ped, clonePedPose)
        SetEntityHeading(ped, clonepedHeading)
        print(getAnim[4])
        exports["rpemotes"]:EmoteCommandStart(getAnim[4])
        FreezeEntityPosition(ped, false)
    else
        print("Error: You dont playing an animation")
    end
end)
