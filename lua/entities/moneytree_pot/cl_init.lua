--[[-------------------------------------------------------------------------
Money tree pot entity
---------------------------------------------------------------------------]]

include( "shared.lua" )

local TreeModel = "models/moneytrees/moneytree.mdl"

function ENT:UpdateTreeModel()

	local Age = self:GetAge()
	local Tree = self.Tree

	if Age >= 0 then
		
		if not ( Tree and Tree:IsValid() ) then 

			Tree = ClientsideModel( TreeModel )
			Tree:SetPos( self:GetPos() )
			Tree.Ang = math.Rand( 0, 360 )

			self.Tree = Tree
		end
	else

		if Tree and Tree:IsValid() then Tree:Remove() end

		return
	end

	local Scale = Age / self.GrowTime * ( self.MaxScale - self.MinScale ) + self.MinScale
	local Mat = Matrix()
	Mat:Scale( Vector( Scale, Scale, Scale ) )
	Tree:EnableMatrix( "RenderMultiply", Mat )

	local Cash = self:GetCash()

	local CashPercent = ( Cash - self.MinCollect ) / ( self.MaxCash - self.MinCollect )

	if CashPercent < 0 then
		
		Tree:SetBodyGroups( "00000" )
	elseif CashPercent < 1 / 3 then

		Tree:SetBodyGroups( "01000" )
	elseif CashPercent < 2 / 3 then

		Tree:SetBodyGroups( "01100" )
	elseif CashPercent < 1 then

		Tree:SetBodyGroups( "01110" )
	else

		Tree:SetBodyGroups( "01111" )
	end
end

function ENT:DrawTree()

	local Tree = self.Tree

	if Tree and Tree:IsValid() then
		
	local HealthPercent = self:GetTreeHealth() / MoneyTrees.tree_health

	render.SetColorModulation( 1, HealthPercent, HealthPercent )
		render.Model( {

			pos = self:LocalToWorld( self.TreePos ),
			angle = self:LocalToWorldAngles( Angle( 45 - HealthPercent * 45, Tree.Ang, 0 ) ),
			model = TreeModel
		}, Tree )
	end
end

function ENT:DrawCash()

	local Cash = math.floor( self:GetCash() )

	if Cash > 0 then
		
		local LabelPos = self:LocalToWorld( Vector( 0, 0, 45 ) )
		local Dir = LabelPos - EyePos()

		if Dir:Length() <= self.LabelDist then
			
			local Ang = EyeAngles()
			Ang = Angle( 0, Ang.yaw - 90, -Ang.pitch + 90 )

			cam.Start3D2D( LabelPos, Ang, 0.1 )

				draw.SimpleText( 	"$" .. tostring( Cash ),
									"DermaLarge", 
									0, 
									0,
									self.LabelColor,
									TEXT_ALIGN_CENTER,
									TEXT_ALIGN_CENTER )

			cam.End3D2D()
		end
	end
end

local SunIcon = Material( "icon16/asterisk_orange.png" )

function ENT:DrawUI( DrawLitInfo )

	local JuicePercent = self:GetJuice() / self:GetVolume()

	cam.Start3D2D( self:LocalToWorld( Vector( 6.01, -1.25, 5 ) ), self:LocalToWorldAngles( Angle( 0, 90, 90 ) ), 0.05 )

		surface.SetDrawColor( 255, 0, 0, 255 )
		surface.DrawRect( 0, 0, 50, 80 )
		surface.SetDrawColor( 255, 255, 0, 255 )
		surface.DrawRect( 0, 80, 50, -JuicePercent * 80 )

		surface.SetFont( "Trebuchet24" )
		surface.SetTextPos( 0, 0 )
		surface.SetTextColor( 0, 0, 0, 255 )
		surface.DrawText( "JUICE" )

		if DrawLitInfo then
			
			surface.SetMaterial( SunIcon )

			if self.WellLit then
				
				surface.SetDrawColor( 255, 255, 255, 255 )
			else

				surface.SetDrawColor( 0, 0, 0, 255 )
			end

			surface.DrawTexturedRect( 9, 24, 32, 32 )
		end

	cam.End3D2D()
end

function ENT:Think()

	self:UpdateTreeModel()
	self:FindJuice() 

	if self.UpdateLight < CurTime() then
			
		self:UpdateLightState()
	end
	
	self:SetNextClientThink( CurTime() + self.ThinkInterval )

	return true
end

function ENT:Draw()

	MoneyTrees.ApplyGGunFix( self )

	self:DrawModel()
	self:DrawTree()
	self:DrawCash()

	local Tier = self:GetTier()

	if Tier > 1 then
		
		self:DrawUI( Tier > 2 )
	end
end

function ENT:OnRemove()

	if self.Tree then

		self.Tree:Remove()
	end

	if self.Emitter then
		
		self.Emitter:Finish()
	end
end

