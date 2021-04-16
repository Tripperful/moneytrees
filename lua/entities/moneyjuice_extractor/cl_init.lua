--[[-------------------------------------------------------------------------
Money juice extractor entity
---------------------------------------------------------------------------]]

include( "shared.lua" )

function ENT:DrawCash()

	cam.Start3D2D( self:LocalToWorld( Vector( 4.02, 0, 15 ) ), self:LocalToWorldAngles( Angle( 0, 90, 90 ) ), 0.1 )

		draw.SimpleText( 	"$" .. tostring( math.floor( self:GetCash() ) ),
							"DermaDefault", 
							0, 
							0,
							self.LabelColor,
							TEXT_ALIGN_CENTER,
							TEXT_ALIGN_CENTER )

	cam.End3D2D()
end

function ENT:Think()

	
end

function ENT:Draw()

	MoneyTrees.ApplyGGunFix( self )

	self:DrawModel()
	self:DrawCash()
end
