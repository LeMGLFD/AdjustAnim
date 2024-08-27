local function adjustAnim()
    local ped = PlayerPedId()
    local getIfPlayerPlayAnim = exports["rpemotes"]:IsPlayerInAnim()
    if getIfPlayerPlayAnim and not IsPedInAnyVehicle(ped, false) then

        local clonePed = ClonePed(ped, false, false, true)
        local getPlayedAnim = exports["rpemotes"]:getPlayerAnim()
        local animOption = getPlayedAnim.AnimationOptions
        
        if getPlayedAnim then
            SetEntityNoCollisionEntity(ped, clonePed, false)
            FreezeEntityPosition(ped, true)

            TaskPlayAnim(clonePed, getPlayedAnim[1], getPlayedAnim[2], 2.0, 2.0, -1, 0, 0, false, false, false)
            SetEntityHeading(clonePed, GetEntityHeading(ped))
            SetEntityAlpha(clonePed, 50, true)
            FreezeEntityPosition(clonePed, true)
            SetEntityInvincible(clonePed, true)
            TaskSetBlockingOfNonTemporaryEvents(clonePed, true)

            CreateThread(function()
                while getIfPlayerPlayAnim and clonePed do 
                    if not IsEntityPlayingAnim(clonePed, getPlayedAnim[1], getPlayedAnim[2], 3) then
                        TaskPlayAnim(clonePed, getPlayedAnim[1], getPlayedAnim[2], 5.0, 5.0, animOption.EmoteDuration, animOption.MovementType, 0, false, false, false)
                    end
                    Wait(clonePed and 0 or 1000) 
                end
            end)

            exports.object_gizmo:useGizmo(clonePed)

            local clonePedPose = GetEntityCoords(clonePed)
            SetEntityCoordsNoOffset(ped, clonePedPose.x, clonePedPose.y, clonePedPose.z, true, true, true)
            SetEntityHeading(ped, GetEntityHeading(clonePed))
            DeleteEntity(clonePed)
            exports["rpemotes"]:EmoteCommandStart(getPlayedAnim[4])
            FreezeEntityPosition(ped, false)   
        else
            print("Error: getAnim is nil")
        end
    else
        print("Error: You don't playing an animation")
    end
end

RegisterCommand("adjustAnim", adjustAnim, false)
