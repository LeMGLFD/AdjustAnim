local function adjustAnim()
    local ped = PlayerPedId()
    local getPlayerAnim = exports["rpemotes"]:IsPlayerInAnim()
    if getPlayerAnim and not IsPedInAnyVehicle(ped, false) then

        local clonePed = ClonePed(ped, false, false, true)
        local getAnim = exports["rpemotes"]:getPlayerAnim()
        local animOption = getAnim.AnimationOptions
        
        if getAnim then
            SetEntityNoCollisionEntity(ped, clonePed, false)
            FreezeEntityPosition(ped, true)

            TaskPlayAnim(clonePed, getAnim[1], getAnim[2], 2.0, 2.0, -1, 0, 0, false, false, false)
            SetEntityHeading(clonePed, GetEntityHeading(ped))
            SetEntityAlpha(clonePed, 50, true)
            FreezeEntityPosition(clonePed, true)
            SetEntityInvincible(clonePed, true)
            TaskSetBlockingOfNonTemporaryEvents(clonePed, true)

            CreateThread(function()
                while getPlayerAnim and clonePed do 
                    if not IsEntityPlayingAnim(clonePed, getAnim[1], getAnim[2], 3) then
                        TaskPlayAnim(clonePed, getAnim[1], getAnim[2], 5.0, 5.0, animOption.EmoteDuration, animOption.MovementType, 0, false, false, false)
                    end
                    Wait(clonePed and 0 or 1000) 
                end
            end)

            exports.object_gizmo:useGizmo(clonePed)

            CreateThread(function()
                while true do
                    local clonePedPose = GetEntityCoords(clonePed)
                    local foundGround, groundZ = GetGroundZFor_3dCoord(clonePedPose.x, clonePedPose.y, clonePedPose.z, false)
                    if foundGround then
                        SetEntityCoordsNoOffset(ped, clonePedPose.x, clonePedPose.y, groundZ, false, false, false)
                        SetEntityHeading(ped, GetEntityHeading(clonePed))
                        DeleteEntity(clonePed)
                        exports["rpemotes"]:EmoteCommandStart(getAnim[4])
                        FreezeEntityPosition(ped, false)
                        break
                    end
                    Wait(500) 
                end
            end)
        else
            print("Error: getAnim is nil")
        end
    else
        print("Error: You don't playing an animation")
    end
end

RegisterCommand("adjustAnim", adjustAnim, false)
