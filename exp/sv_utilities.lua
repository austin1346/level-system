#NoSimplerr#
--[Utilities]
local plyMeta = FindMetaTable( "Player" )
util.AddNetworkString( "PlayerLeveledUp" )

--[CanPlayerLevel]
local function canPlayerLevel( ply )
	local expToLevel = ply:expToLevel()
	local curExp = ply:CurExp()
	local curLvl = ply:CurLvl()

	if ( ply:CurExp() >= ply:expToLevel() ) then
		curExp = curExp - expToLevel

		ply:SetNWInt( "PlayerExp", curExp )
		ply:SetNWInt( "PlayerLevel", curLvl + 1 )

		net.Start( "PlayerLeveledUp" )
			net.WriteUInt( ply:CurLvl(), 8 )
		net.Send( ply )
	end
end

--[Set Level]
function plyMeta:SetLevel( newLvl )
	self:SetNWInt( "PlayerLevel", newLvl )
	canPlayerLevel( self )
	self:SetPData( "PlayerLevel", self:CurLvl() )
end

--[Set Exp]
function plyMeta:SetExp( newExp )
	self:SetNWInt( "PlayerExp", newExp )
	canPlayerLevel( self )
	self:SetPData( "PlayerExp", self:CurExp() )
end

--[Add Exp]
function plyMeta:AddExp( newExp )
	self:SetExp( self:CurExp() + newExp )
end

--[View money and exp]
concommand.Add( "show_info", function( ply, cmd, args, str )
	ply:PrintMessage( HUD_PRINTCONSOLE, "----------" )
	ply:PrintMessage( HUD_PRINTCONSOLE, "Level: " .. ply:CurLvl() )
	ply:PrintMessage( HUD_PRINTCONSOLE, "Exp: " .. ply:CurExp() .. "/" .. ply:expToLevel() )
	ply:PrintMessage( HUD_PRINTCONSOLE, "----------" )
end )

--[Set level]
concommand.Add( "set_level", function( ply, cmd, args )
	if !ply:IsSuperAdmin() then return end

	local target = args[1]
	local level = tonumber( args[2] )

	if !IsValid( ply, target, level ) or args[3] or !isnumber( level ) then
		ply:PrintMessage( HUD_PRINTCONSOLE, "Incorrect Syntax! Try; set_level <target> <level>" )
		return
	end

	target = string.lower( target )
	local newTarget

	for k, v in pairs( player.GetHumans() ) do
		if string.find( v:Name():lower(), target, 1, true ) then
			newTarget = v;
			break
		end
	end

	if not newTarget then
		ply:PrintMessage( HUD_PRINTCONSOLE, "Player not found!" )
		return
	end

	newTarget:SetLevel( level )
	newTarget:SetExp( 0 )
	ply:PrintMessage( HUD_PRINTCONSOLE, "Set level for " .. newTarget:Name() .. " to " .. level )
end )
