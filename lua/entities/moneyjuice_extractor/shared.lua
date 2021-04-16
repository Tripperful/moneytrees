--[[-------------------------------------------------------------------------
Money juice extractor entity
---------------------------------------------------------------------------]]

ENT.Type 		= "anim"
ENT.Base 		= "base_gmodentity"
ENT.Author 		= "Tripperful"
ENT.Spawnable 	= false
ENT.ClassName 	= "moneyjuice_extractor"

function ENT:Initialize()

	if SERVER then

		self:SetModel( "models/moneytrees/moneyjuice_extractor.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		local Phys = self:GetPhysicsObject()
		Phys:Wake()
		Phys:SetMass( 80 )
		self:PhysWake()

		self:SetUseType( SIMPLE_USE )
		self:SetTrigger( true )

    	self.nodupe = true

    	self.ThinkInterval 	= MoneyTrees.think_functions_interval
		self.JuicePerTact 	= 1 / MoneyTrees.extractor_cell_fill_time * self.ThinkInterval
		self.CashPerTact 	= MoneyTrees.extractor_cell_fill_price * self.JuicePerTact

		if MoneyTrees.extractor_health then
			
			self:SetMaxHealth( MoneyTrees.extractor_health )
			self:SetHealth( MoneyTrees.extractor_health )
		end
	else

		self.LabelColor = MoneyTrees.label_color
	end

	if SERVER then
		
		self:SetCash( 0 )
	end
end

function ENT:SetupDataTables()

	self:NetworkVar( "Float", 0, "Cash" )

	self.SetCashRaw = self.SetCash

	self.SetCash = function ( Extractor, Amount ) -- Add safe clamping for the setter function 

		Extractor:SetCashRaw( Amount > 0 and Amount or 0 )
	end
end

function ENT:CanProperty( Ply, Property )

	if MoneyTrees.BlacklistedProperties[Property] then return false end

	return true
end