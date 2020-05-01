GM.Version = "1.0"
GM.Name = "MoonLight"
GM.Author = "EmPePr"

DeriveGamemode "sandbox"
DEFINE_BASECLASS "gamemode_sandbox"

GM.Sandbox = BaseClass

AddCSLuaFile "cl_init.lua" 
AddCSLuaFile "shared.lua" 

include "shared.lua"