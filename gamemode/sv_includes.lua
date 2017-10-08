/*---------------------------------------------------------------------------
Clientside
---------------------------------------------------------------------------*/

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_includes.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_calcview.lua")

/*---------------------------------------------------------------------------
Shared
---------------------------------------------------------------------------*/

AddCSLuaFile("shared.lua")
AddCSLuaFile("sh_utilities.lua")

include("sh_utilities.lua")

/*---------------------------------------------------------------------------
Serverside
---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------
Modules
---------------------------------------------------------------------------*/

local fol = GM.FolderName .. "/gamemode/modules/"
local files, folders = file.Find(fol .. "*", "LUA")

for k, v in pairs(files) do
    if (string.GetExtensionFromFilename(v) ~= "lua") then continue end
    include(fol .. v)
    print("Including " .. v)
end

for _, folder in SortedPairs(folders, true) do
    if (folder == "." or folder == "..") then continue end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
        AddCSLuaFile(fol .. folder .. "/" .. File)
        print("Including " .. fol .. folder .. "/" .. File)
    end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
        AddCSLuaFile(fol .. folder .. "/" .. File)
        include(fol .. folder .. "/" .. File)
        print("Including " .. fol .. folder .. "/" .. File)
    end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
        include(fol .. folder .. "/" .. File)
        print("Including " .. fol .. folder .. "/" .. File)
    end
end