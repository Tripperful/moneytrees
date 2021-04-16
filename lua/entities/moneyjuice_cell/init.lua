--[[-------------------------------------------------------------------------
Money juice cell entity
---------------------------------------------------------------------------]]

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:OnTakeDamage( DmgInfo )

	if not MoneyTrees.cell_health then return end

	self:SetHealth( self:Health() - DmgInfo:GetDamage() )

	if self:Health() <= 0 then

		local Eff = EffectData()
		Eff:SetOrigin( self:GetPos() )
		util.Effect( "GlassImpact", Eff )

		if self:GetJuice() > 0.2 then
			
			Eff:SetColor( 1 )
			util.Effect( "BloodImpact", Eff )
		end

		self:EmitSound( Sound( "ambient/misc/shutter5.wav" ) )
		self:Remove()
	end
end