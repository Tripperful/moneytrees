--[[-------------------------------------------------------------------------
Title
---------------------------------------------------------------------------]]

function MoneyTrees.ApplyGGunFix( Ent )

	if not ( Ent and Ent:IsValid() ) then return false end

	local Phys = Ent:GetPhysicsObject()

	local Parent = Ent:GetParent()

	if ( Phys and Phys:IsValid() ) or ( Parent and Parent.ApplyGGunFix ) then 

		Ent.ApplyGGunFix = true 
	else

		Ent.ApplyGGunFix = nil
	end

	if Ent.ApplyGGunFix then Ent:InvalidateBoneCache() else return false end
end