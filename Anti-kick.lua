local LocalPlayer = Players.LocalPlayer
local oldhmmi
local oldhmmnc
local oldKickFunction

if hookfunction then
    oldKickFunction = hookfunction(LocalPlayer.Kick, function() end)
end

oldhmmi = hookmetamethod(game, "__index", function(self, method)
    if self == LocalPlayer and method:lower() == "kick" then
        return error("Expected ':' not '.' calling member function Kick", 2)
    end
    return oldhmmi(self, method)
end)

oldhmmnc = hookmetamethod(game, "__namecall", function(self, ...)
    if self == LocalPlayer and getnamecallmethod():lower() == "kick" then
        return
    end
    return oldhmmnc(self, ...)
end)
