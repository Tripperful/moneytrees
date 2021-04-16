--[[-------------------------------------------------------------------------
Money juice extractor entity
---------------------------------------------------------------------------]]

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

local CellEjectCooldown = 0.5

function ENT:EjectCell()

	if self.Cell and self.Cell:IsValid() then

		self.Cell:SetPos( Vector( 5, 0, 7 ) )
		self.Cell:SetParent( nil )
		self.Cell:SetNotSolid( false )

		self.LastEject = CurTime()
	end

	self.Cell = nil
	self:EmitSound( Sound( "buttons/lever7.wav" ) )
end

function ENT:InsertCell( Cell )
	
	if self.Cell and self.Cell:IsValid() then return end
	
	if self.LastEject and self.LastEject + CellEjectCooldown > CurTime() then return end

	if Cell:GetJuice() >= 1 then return end

	self.Cell = Cell
	Cell:SetNotSolid( true )
	Cell:SetPos( self:LocalToWorld( Vector( 0, 0, 7 ) ) )
	Cell:SetAngles( self:GetAngles() )
	Cell:SetParent( self )
	
	DropEntityIfHeld( Cell )

	self:EmitSound( Sound( "buttons/lever3.wav" ) )
end

function ENT:Use( Ply )

	self:EjectCell()
end

function ENT:Think()

	local Cell = self.Cell

	if Cell and Cell:IsValid() then
		
		local Cash = self:GetCash()
		local Juice = Cell:GetJuice()

		if Juice < 1 and Cash > 0 then
			
			Cell:SetJuice( Juice + self.JuicePerTact )
			self:SetCash( Cash - self.CashPerTact )
		else

			self:EjectCell()
		end
	end

	self:NextThink( CurTime() + self.ThinkInterval )

	return true
end

function ENT:Touch( Other )

	local Class = Other.ClassName

	if not Class then return end

	local Cash = self:GetCash()

	if Class == "moneyjuice_cell" then
		
		if Cash > 0 then 

			self:InsertCell( Other )
		end
	elseif Class == "spawned_money" and not Other.Collected then
		
		self:SetCash( Cash + Other:Getamount() )
		Other.Collected = true
		Other:Remove()
	end
end

function ENT:OnRemove()

	if self.Cell and self.Cell:IsValid() then
		
		self.Cell:SetParent( nil )
	end
end

function ENT:OnTakeDamage( DmgInfo )

	if not MoneyTrees.extractor_health then return end

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