--[[-------------------------------------------------------------------------
Money tree light entity
---------------------------------------------------------------------------]]

ENT.Type 		= "anim"
ENT.Base 		= "base_gmodentity"
ENT.Author 		= "Tripperful"
ENT.Spawnable 	= false
ENT.ClassName 	= "moneytree_light"

function ENT:Initialize()

	if SERVER then
		
		self:SetModel( "models/props_combine/combine_light001a.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		local Phys = self:GetPhysicsObject()
		Phys:SetMass( 80 )
		Phys:Wake()

		if MoneyTrees.light_health then
			
			self:SetMaxHealth( MoneyTrees.light_health )
			self:SetHealth( MoneyTrees.light_health )
		end

    	self.nodupe = true
	else

		self:SetRenderBounds( Vector( -100, -100, -100 ), Vector( 100, 100, 100 ) )
	end
end