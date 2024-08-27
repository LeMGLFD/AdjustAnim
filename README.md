# ADJUST YOUR POSITION WHEN YOU PLAY EMOTE WITH OBJECT GIZMO

## Preview

https://cdn.discordapp.com/attachments/1268202683177635870/1276556263727038506/2024-08-23_16-58-27.mp4?ex=66cf3b2a&is=66cde9aa&hm=ee6e81671608b191563d33841755122e41b660bf571bd72bb6ee1466bda04d21&

## Dependencies

- **ObjectGizmo** : https://github.com/Demigod916/object_gizmo
- **RPEmote** : https://github.com/LeMGLFD/rpemotes-reborn

## Compatibility

This script only work with **RPEmote**:

- https://github.com/alberttheprince/rpemotes-reborn/releases/tag/v1.6.9

## Integration Instructions

To use the export `exports["rpemotes"]:getPlayerAnim()`, please use my customized fork of RPEmote:

- https://github.com/LeMGLFD/rpemotes-reborn

Alternatively, if you prefer to manually add the functionality, follow these steps:

### 1. Add at the Top of `Emote.lua`

```lua
local currentPlayedAnimTable = {}
```

###  2. Add in the EmoteCancel() Function

```lua
    currentPlayedAnimTable = {}
```
###  3. Add in OnEmotePlay() Function

``` lua
    for _, v  in pairs(RP) do
        for k, vv in pairs(v) do
            if vv == EmoteName then
                table.insert(EmoteName, k)
                break -- break loop when vv == EmoteName for prevent crash 
            end
        end
    end
    currentPlayedAnimTable = EmoteName
    print("DebugPrint("..json.encode(currentPlayedAnimTable))
```

###  4. Add at the End of Emote.lua
```lua
exports('getPlayerAnim', function()
	return currentPlayedAnimTable
end)
```
----------------------------------------------------------

And all its good, enjoy :)