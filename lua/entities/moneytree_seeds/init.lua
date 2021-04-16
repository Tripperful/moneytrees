--[[-------------------------------------------------------------------------
Money tree seeds entity
---------------------------------------------------------------------------]]

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:OnTakeDamage( DmgInfo )

	if not MoneyTrees.seeds_health then return end

	self:SetHealth( self:Health() - DmgInfo:GetDamage() )

	if self:Health() <= 0 then

		local Eff = EffectData()
		Eff:SetOrigin( self:GetPos() )
		util.Effect( "RagdollImpact", Eff )

		self:EmitSound( Sound( "physics/cardboard/cardboard_box_impact_bullet1.wav" ) )
		self:Remove()
	end
end