--[[-------------------------------------------------------------------------
Money juice cell entity
---------------------------------------------------------------------------]]

include( "shared.lua" )

function ENT:Draw()

	MoneyTrees.ApplyGGunFix( self )

	self:DrawModel()
end

function ENT:Think()

	local Juice = self:GetJuice()

	if Juice ~= self:GetPoseParameter( "juicelevel" ) then
		
		self:SetPoseParameter( "juicelevel", Juice )
		self:InvalidateBoneCache()
	end
end