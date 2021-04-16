--[[-------------------------------------------------------------------------
Money tree seeds entity
---------------------------------------------------------------------------]]

include( "shared.lua" )

function ENT:Draw()

	MoneyTrees.ApplyGGunFix( self )

	self:DrawModel()
end