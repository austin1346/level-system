#NoSimplerr#
--[Utilities]--
--[Do not touch anything after this line or else it will break!]
local plyMeta = FindMetaTable( "Player" )
util.AddNetworkString( "PlayerLeveledUp" )

--[CanPlayerLevel]
local function canPlayerLevel( ply )
	local expToLevel = ply:expToLevel()
	local curExp = ply:CurExp()
	local curLvl = ply:CurLvl()

	if ( ply:CurExp() >= ply:expToLevel() ) then
		curExp = curExp - expToLevel

		ply:SetExp( curExp )
		ply:SetLevel( curLvl + 1 )

		net.Start( "PlayerLeveledUp" )
			net.WriteUInt( ply:CurLvl(), 8 )
		net.Send( ply )
	end
end

--[Set Level]
function plyMeta:SetLevel( newLvl, noSave )
	self:SetNWInt( "PlayerLevel", math.max( newLvl, 1 ) )

	if noSave then return end
	canPlayerLevel( self )
	self:SetPData( "PlayerLevel", self:CurLvl() )
end

--[Set Exp]
function plyMeta:SetExp( newExp, noSave )
	self:SetNWInt( "PlayerExp", newExp )

	if noSave then return end
	self:SetPData( "PlayerExp", self:CurExp() )
	canPlayerLevel( self )
end

--[Add Exp]
function plyMeta:AddExp( newExp )
	self:SetExp( self:CurExp() + newExp )
	self:ChatPrint( "+" .. newExp .. "xp" )
end

--[Remove Exp]
function plyMeta:RemoveExp( newExp )
	self:SetExp( self:CurExp() - newExp )
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
	if !ply:IsSuperAdmin() then
		ply:PrintMessage( HUD_PRINTCONSOLE, "Incorrect Usergroup!" )
		return
	end

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

	if !( level >= 1 ) then
		ply:PrintMessage( HUD_PRINTCONSOLE, "Target level has to be greater than 0!" )
		return
	end

	newTarget:SetExp( 0 )
	newTarget:SetLevel( level )
	ply:PrintMessage( HUD_PRINTCONSOLE, "Set level for " .. newTarget:Name() .. " to " .. level )
end )
