--[[-------------------------------------------------------------------------
Money tree seeds entity
---------------------------------------------------------------------------]]

ENT.Type 		= "anim"
ENT.Base 		= "base_gmodentity"
ENT.Author 		= "Tripperful"
ENT.Spawnable 	= false
ENT.ClassName 	= "moneytree_seeds"

function ENT:Initialize()

	if SERVER then
		
		self:SetModel( "models/moneytrees/seeds.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		self:PhysWake()
		
    	self.nodupe = true

    	if MoneyTrees.seeds_health then
			
			self:SetMaxHealth( MoneyTrees.seeds_health )
			self:SetHealth( MoneyTrees.seeds_health )
		end
	else

	end
end

function ENT:CanProperty( Ply, Property )

	if MoneyTrees.BlacklistedProperties[Property] then return false end

	return true
end