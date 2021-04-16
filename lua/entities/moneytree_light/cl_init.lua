--[[-------------------------------------------------------------------------
Money tree light entity
---------------------------------------------------------------------------]]

include( "shared.lua" )

function ENT:Draw()

	MoneyTrees.ApplyGGunFix( self )

	self:DrawModel()

	local Light = DynamicLight( self:EntIndex() )

	if Light then

		Light.pos = self:WorldSpaceCenter()
		Light.r = MoneyTrees.light_color.r
		Light.g = MoneyTrees.light_color.g
		Light.b = MoneyTrees.light_color.b
		Light.brightness = 2
		Light.Decay = 1000
		Light.Size = 256
		Light.DieTime = CurTime() + 1
	end
end