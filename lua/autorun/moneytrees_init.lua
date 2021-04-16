--[[-------------------------------------------------------------------------
Init
---------------------------------------------------------------------------]]

MoneyTrees = MoneyTrees or {}

if SERVER then

	-- Shared
	AddCSLuaFile()
	AddCSLuaFile( "moneytrees_config.lua" )
	AddCSLuaFile( "moneytrees/shared.lua" )
	AddCSLuaFile( "moneytrees/sh_customthings.lua" )

	-- Clientside
	AddCSLuaFile( "moneytrees/cl_init.lua" )
end

-- Shared
include( "moneytrees_config.lua" )
include( "moneytrees/shared.lua" )
include( "moneytrees/sh_customthings.lua" )

if SERVER then

	-- Serverside
else

	-- Clientside
	include( "moneytrees/cl_init.lua" )
end

-- Shared post-includes
