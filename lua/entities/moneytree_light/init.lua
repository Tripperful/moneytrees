--[[-------------------------------------------------------------------------
Money tree light entity
---------------------------------------------------------------------------]]

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:OnTakeDamage( DmgInfo )

	if not MoneyTrees.light_health then return end

	self:SetHealth( self:Health() - DmgInfo:GetDamage() )

	local Eff = EffectData()
	Eff:SetOrigin( DmgInfo:GetDamagePosition() )
	Eff:SetNormal( DmgInfo:GetDamageForce() )
	util.Effect( "ManhackSparks", Eff )

	if self:Health() <= 0 then

		local Eff = EffectData()
		Eff:SetOrigin( self:GetPos() )
		util.Effect( "cball_explode", Eff )

		self:EmitSound( Sound( "physics/metal/metal_sheet_impact_hard7.wav" ) )
		self:Remove()
	end
end