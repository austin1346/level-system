#NoSimplerr#
--[Utilities]
local plyMeta = FindMetaTable( "Player" )
util.AddNetworkString( "PlayerLeveledUp" )

--[CanPlayerLevel]
function canPlayerLevel( ply )
	local expToLevel = ply:expToLevel()
	local curExp = ply:CurExp()
	local curLvl = ply:CurLvl()

	if ( ply:CurExp() >= ply:expToLevel() ) then
		curExp = curExp - expToLevel

		ply:SetNWInt( "PlayerExp", curExp )
		ply:SetNWInt( "PlayerLevel", curLvl + 1 )

		net.Start( "PlayerLeveledUp" )
			net.WriteString( ply:CurLvl() )
		net.Send( ply )
	end
end

--[Set Level]
function plyMeta:SetLevel( newLvl )
	self:SetNWInt( "PlayerLevel", newLvl )

	canPlayerLevel( self )
end

--[Set Exp]
function plyMeta:SetExp( newExp )
	self:SetNWInt( "PlayerExp", newExp )

	canPlayerLevel( self )
end

--[Add Exp]
function plyMeta:AddExp( newExp )
	self:SetNWInt( "PlayerExp", self:CurExp() + newExp )
end

--[View money and exp]
concommand.Add( "show_info", function( ply, cmd, args )
	ply:PrintMessage( HUD_PRINTCONSOLE, "----------" )
	ply:PrintMessage( HUD_PRINTCONSOLE, "Level: " .. ply:CurLvl() )
	ply:PrintMessage( HUD_PRINTCONSOLE, "Exp: " .. ply:CurExp() .. "/" .. ply:expToLevel() )
	ply:PrintMessage( HUD_PRINTCONSOLE, "----------" )
end )
