--[[-------------------------------------------------------------------------
Money tree pot entity
---------------------------------------------------------------------------]]

ENT.Type 		= "anim"
ENT.Base 		= "base_gmodentity"
ENT.Author 		= "Tripperful"
ENT.Spawnable 	= false
ENT.ClassName 	= "moneytree_pot"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

local SimpleVolume = MoneyTrees.pot_simple_volume
local AdvancedVolume = MoneyTrees.pot_advanced_volume
local UltimateVolume = MoneyTrees.pot_ultimate_volume

local HullMins = Vector( -3, -3, -3 )
local HullMaxs = Vector( 3, 3, 3 )

function ENT:FindJuice()

	local Volume = self:GetVolume()

	if Volume == self:GetJuice() then return end

	local Tr = {

		start = self:WorldSpaceCenter(),
		endpos = self:GetPos() + Vector( 0, 0, 50 ),
		filter = self,
		mins = HullMins,
		maxs = HullMaxs,
		ignoreworld = true
	}

	Tr = util.TraceHull( Tr )

	local Ent = Tr.Entity

	if not ( Ent and Ent:IsValid() ) then return end

	if Ent.ClassName == "moneyjuice_cell" then

		local CellJuice = Ent:GetJuice()
		TransferJuice = math.Clamp( 1 / Ent.DumpTime * self.ThinkInterval, 0, CellJuice )
		TransferJuice = math.Clamp( TransferJuice, 0, Volume - self:GetJuice() )

		if TransferJuice > 0 then
			
			if SERVER then
				
				Ent:SetJuice( Ent:GetJuice() - TransferJuice )
				self:SetJuice( self:GetJuice() + TransferJuice )
			else
				
				local Drop = self.Emmiter:Add( "effects/blood_core", Ent:LocalToWorld( Vector( 0, 0, 5 ) ) )
				Drop:SetDieTime( 1 )
				Drop:SetStartAlpha( 255 )
				Drop:SetEndAlpha( 0 )
				Drop:SetStartSize( 8 )
				Drop:SetEndSize( 16 )
				Drop:SetRoll( math.Rand( 0, 360 ) )
				Drop:SetColor( 255, 255, 0 )
				Drop:SetAirResistance( 20 );
				Drop:SetGravity( Vector( 0, 0, -100 ) );
				Drop:SetCollide( true );
				Drop:SetBounce( 0 ); 
			end
		end
	end
end

function ENT:UpdateLightState()

	self.WellLit = false

	local Tr = {

		start = self:WorldSpaceCenter(),
		endpos = self:WorldSpaceCenter() + Vector( 0, 0, 10000000 ),
		filter = self,
		ignoreworld = false,
		mask = MASK_OPAQUE,
	}

	Tr = util.TraceLine( Tr )

	if Tr.HitSky then 

		self.WellLit = true
	end

	if not self.WellLit then
		
		for I, Light in pairs( ents.FindByClass( "moneytree_light" ) ) do
		
			if ( Light:WorldSpaceCenter() - self:WorldSpaceCenter() ):Length() <= MoneyTrees.light_distance then
				
				self.WellLit = true

				break
			end
		end
	end

	self.UpdateLight = CurTime() + MoneyTrees.pot_light_update_interval
end

local function PotFilter( self, Ent, Ply, Tier )

	if not IsValid( Ent ) then return false end
	if not ( Ent.ClassName and Ent.ClassName == "moneytree_pot" ) then return false end

	return Ent:GetTier() == Tier
end

local AdvancedPrice = MoneyTrees.pot_advanced_price
local UltimatePrice = MoneyTrees.pot_ultimate_price

properties.Add( "upgradepot1", {

	MenuLabel = "Upgrade to advanced",
	Order = 1,
	MenuIcon = "icon16/medal_silver_2.png",

	Filter = function( self, Ent, Ply )
		
		return PotFilter( self, Ent, Ply, 1 )
	end,

	Action = function( self, Ent )

		Derma_Query( 	"Upgrade pot to advanced? ($" .. tostring( AdvancedPrice ) .. ")", 
						"Upgrade pot",
						"Yes", 
						function()

							self:MsgStart()

								net.WriteEntity( Ent )

							self:MsgEnd()
						end, 
						"No", 
						nil )
	end,

	Receive = function( self, length, Ply )
		
		local Ent = net.ReadEntity()
		
		if not self:Filter( Ent, Ply ) then return end

		if Ply:getDarkRPVar( "money" ) < AdvancedPrice then
			
			DarkRP.notify( Ply, NOTIFY_ERROR, 3, "You can not afford this upgrade!" )
		else

			Ent:SetTier( Ent:GetTier() + 1 )
			Ply:addMoney( -AdvancedPrice )
			DarkRP.notify( Ply, NOTIFY_GENERIC, 3, "Upgraded pot to advanced!" )
		end
	end
} )

properties.Add( "upgradepot2", {

	MenuLabel = "Upgrade to ultimate",
	Order = 1,
	MenuIcon = "icon16/medal_gold_2.png",

	Filter = function( self, Ent, Ply )
		
		return PotFilter( self, Ent, Ply, 2 )
	end,

	Action = function( self, Ent )

		Derma_Query( 	"Upgrade pot to ultimate? ($" .. tostring( UltimatePrice ) .. ")", 
						"Upgrade pot",
						"Yes", 
						function()

							self:MsgStart()

								net.WriteEntity( Ent )

							self:MsgEnd()
						end, 
						"No", 
						nil )
	end,

	Receive = function( self, length, Ply )
		
		local Ent = net.ReadEntity()
		
		if not self:Filter( Ent, Ply ) then return end

		if Ply:getDarkRPVar( "money" ) < UltimatePrice then
			
			DarkRP.notify( Ply, NOTIFY_ERROR, 3, "You can not afford this upgrade!" )
		else

			Ent:SetTier( Ent:GetTier() + 1 )
			Ply:addMoney( -UltimatePrice )
			DarkRP.notify( Ply, NOTIFY_GENERIC, 3, "Upgraded pot to ultimate!" )
		end
	end
} )

function ENT:Initialize()

	if SERVER then
		
		self:SetModel( "models/moneytrees/pot.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		local Phys = self:GetPhysicsObject()
		Phys:Wake()
		Phys:SetDamping( 0, 20 )

		self:SetUseType( SIMPLE_USE )
		self:SetTrigger( true )

    	self.nodupe = true

    	self.CanGrowCash = CurTime()

    	if MoneyTrees.pot_health then 

	    	self:SetMaxHealth( MoneyTrees.pot_health )
	    	self:SetHealth( MoneyTrees.pot_health )
    	end
	else
		
		self.TreePos 	= Vector( 0, 0, 7 )
		self.MinScale 	= MoneyTrees.tree_min_scale
		self.MaxScale 	= MoneyTrees.tree_max_scale
		self.LabelDist 	= MoneyTrees.tree_cash_label_distance
		self.LabelColor = MoneyTrees.label_color

		-- For rendering and use extension
		local BoxMins = Vector( -15 * self.MaxScale, -21 * self.MaxScale, 0 )
		local BoxMaxs = Vector( 15 * self.MaxScale, 21 * self.MaxScale, 33 * self.MaxScale + self.TreePos.z )

		self:SetCollisionBounds( BoxMins, BoxMaxs )
		self:SetRenderBounds( BoxMins, BoxMaxs )

		self.Emmiter = ParticleEmitter( self:GetPos(), false )
	end



	self.ThinkInterval 	= MoneyTrees.think_functions_interval
	self.GrowTime 		= MoneyTrees.tree_grow_time
	self.MinCollect 	= MoneyTrees.tree_min_collectable_cash
	self.MaxCash 		= MoneyTrees.tree_max_cash
	self.CashCoolDown	= MoneyTrees.tree_cash_cooldown
	self.JuicePerTact 	= 1 / MoneyTrees.tree_one_juice_cell_consumption_time * self.ThinkInterval
	self.CashPerTact 	= self.MaxCash / MoneyTrees.tree_max_cash_grow_time * self.ThinkInterval
	self.UpdateLight 	= CurTime()
	self.LightMul		= MoneyTrees.light_multiplier

	if SERVER then
		
		self:SetCash( 0 )
		self:SetJuice( 0 )
		self:SetTier( 1 )
		self:SetAge( -1 )
		self:SetVolume( SimpleVolume )
		self:SetTreeHealth( 0 )
	end
end

function ENT:SetupDataTables()

	self:NetworkVar( "Int", 0, "Tier" )

	self.SetTierRaw = self.SetTier

	self.SetTier = function ( Pot, Tier ) -- Extend setter function, add automatic bodygroups handling

		if Tier == 1 then
		
			self:SetBodyGroups( "000" )
			self:SetVolume( SimpleVolume )
		elseif Tier == 2 then
		
			self:SetBodyGroups( "010" )
			self:SetVolume( AdvancedVolume )
		elseif Tier == 3 then
			
			self:SetBodyGroups( "011" )
			self:SetVolume( UltimateVolume )
		else return end

		Pot:SetTierRaw( Tier )
	end

	self:NetworkVar( "Float", 0, "Cash" )

	self.SetCashRaw = self.SetCash

	self.SetCash = function ( Pot, Amount ) -- Add safe clamping for the setter function 

		Pot:SetCashRaw( Amount < Pot.MaxCash and Amount or Pot.MaxCash )
	end

	self:NetworkVar( "Float", 1, "Juice" )

	self.SetJuiceRaw = self.SetJuice

	self.SetJuice = function ( Pot, Amount ) -- Add safe clamping for the setter function 

		Pot:SetJuiceRaw( math.Clamp( math.Round( Amount, 3 ), 0, self:GetVolume() ) )
	end

	self:NetworkVar( "Float", 2, "Age" )

	self:NetworkVar( "Float", 3, "Volume" )

	self:NetworkVar( "Float", 4, "TreeHealth" )

	self.SetTreeHealthRaw = self.SetTreeHealth

	self.SetTreeHealth = function( Pot, Amount ) -- Add safe clamping for the setter function 

		Pot:SetTreeHealthRaw( math.Clamp( Amount, 0, MoneyTrees.tree_health ) )
	end
end

function ENT:CanProperty( Ply, Property )

	if MoneyTrees.BlacklistedProperties[Property] then return false end

	return true
end
