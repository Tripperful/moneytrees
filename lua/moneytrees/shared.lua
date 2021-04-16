--[[-------------------------------------------------------------------------
Shared
---------------------------------------------------------------------------]]

util.PrecacheModel( "models/moneytrees/pot.mdl" )
util.PrecacheModel( "models/moneytrees/seeds.mdl" )
util.PrecacheModel( "models/moneytrees/moneyjuice_cell.mdl" )
util.PrecacheModel( "models/moneytrees/moneyjuice_extractor.mdl" )

MoneyTrees.BlacklistedProperties = {

	["persist"] 		= true,
	["bodygroups"] 		= true,
	["skin"] 			= true,
	["extinguish"] 		= true,
	["remover"] 		= true,
	["gravity"] 		= true,
	["drive"] 			= true,
	["collision"] 		= true,
	["npc_bigger"] 		= true,
	["npc_smaller"] 	= true,
}

