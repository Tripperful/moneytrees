--[[-------------------------------------------------------------------------
Money juice cell entity
---------------------------------------------------------------------------]]

ENT.Type 		= "anim"
ENT.Base 		= "base_gmodentity"
ENT.Author 		= "Tripperful"
ENT.Spawnable 	= false
ENT.ClassName 	= "moneyjuice_cell"
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()

	if SERVER then
		
		self:SetModel( "models/moneytrees/moneyjuice_cell.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		local Phys = self:GetPhysicsObject()
		Phys:Wake()
		Phys:SetDamping( 0, 20 )

		self:SetUseType( SIMPLE_USE )

		if MoneyTrees.cell_health then
			
			self:SetMaxHealth( MoneyTrees.cell_health )
			self:SetHealth( MoneyTrees.cell_health )
		end

    	self.nodupe = true
	else

	end
	
	self.DumpTime = MoneyTrees.cell_dump_time

	if SERVER then
		
		self:SetJuice( 0 )
	end
end

function ENT:SetupDataTables()

	self:NetworkVar( "Float", 0, "Juice" )

	self.SetJuiceRaw = self.SetJuice

	self.SetJuice = function ( Cell, Amount ) -- Add safe clamping for the setter function 

		Cell:SetJuiceRaw( math.Clamp( math.Round( Amount, 3 ), 0, 1 ) )
	end
end

function ENT:CanProperty( Ply, Property )

	if MoneyTrees.BlacklistedProperties[Property] then return false end

	return true
end