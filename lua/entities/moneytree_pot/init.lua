--[[-------------------------------------------------------------------------
Money tree pot entity
---------------------------------------------------------------------------]]

AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )

include( "shared.lua" )

function ENT:PlantSeeds( Seeds )

	if self:GetAge() >= 0 then return false end

	self:SetAge( 0 )
	self:SetTreeHealth( MoneyTrees.tree_health )
	Seeds:Remove()
end

function ENT:GrowCash()

	if CurTime() > self.CanGrowCash then
		
		self:SetCash( self:GetCash() + self.CashPerTact * ( self.WellLit and self.LightMul or 1 ) )
	end
end

function ENT:KillTree()

	self:SetAge( -1 )
	self:SetCash( 0 )

	local Eff = EffectData()
	Eff:SetOrigin( self:LocalToWorld( Vector( 0, 0, 10 ) ) )
	util.Effect( "AntlionGib", Eff )
	self:EmitSound( Sound( "ambient/misc/shutter5.wav" ) )
end

function ENT:Think()

	local Age = self:GetAge()
	local Juice = self:GetJuice()

	self:FindJuice() 

	if Age >= 0  then

		local TreeHealth = self:GetTreeHealth()

		self:SetJuice( self:GetJuice() - self.JuicePerTact )

		if Juice > 0 then
			
			if Age < self.GrowTime then
				
				self:SetAge( Age + self.ThinkInterval * ( self.WellLit and self.LightMul or 1 ) )
			else

				self:GrowCash()
			end

			if TreeHealth < MoneyTrees.tree_health then
				
				self:SetTreeHealth( TreeHealth + self.ThinkInterval )
			end
		else
			if Age >= self.GrowTime then
				
				if  TreeHealth > 0 then
								
					self:SetTreeHealth( TreeHealth - self.ThinkInterval )
				else

					self:KillTree()
				end
			end
		end

		if self.UpdateLight < CurTime() then
			
			self:UpdateLightState()
		end
	end
	
	self:NextThink( CurTime() + self.ThinkInterval )

	return true
end
function ENT:Use( Ply )

	local Cash = math.floor( self:GetCash() )

	if Cash >= self.MinCollect then
		
		if Ply:IsValid() and Ply:IsPlayer() then
			
			Ply:addMoney( Cash )
			DarkRP.notify( Ply, NOTIFY_GENERIC, 3, "You have collected $" .. tostring( Cash ) .. " from a money tree!" )
			self:SetCash( 0 )
			self.CanGrowCash = CurTime() + self.CashCoolDown
		end
	end
end

function ENT:Touch( Other )

	local Class = Other.ClassName

	if Class and Class == "moneytree_seeds" then
		
		self:PlantSeeds( Other )
	end
end

function ENT:OnTakeDamage( DmgInfo )

	if not MoneyTrees.pot_health then return end

	self:SetHealth( self:Health() - DmgInfo:GetDamage() )

	if self:Health() <= 0 then
		
		if self:GetAge() >= 0 then
			
			self:KillTree()
		end

		local Eff = EffectData()
		Eff:SetOrigin( self:GetPos() )
		util.Effect( "GlassImpact", Eff )
		
		self:Remove()
	end
end