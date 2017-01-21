#NoSimplerr#
--[Stat saving]
local plyMeta = FindMetaTable( "Player" )

--[Save stats]

--[Timer]
function gmLoaded()
	timer.Create( "SaveTheStats", 10, 0, function()
		for k, v in pairs( player.GetAll() ) do
			v:SetPData( "PlayerLevel", v:CurLvl() )
			v:SetPData( "PlayerExp", v:CurExp() )
			v:ChatPrint( "Stats Saved!;" .. "Level: " .. v:CurLvl() .. "; " .. v:CurExp() .. "/" .. v:expToLevel() )
		end
	end )
end
hook.Add( "Initialize", "GamemodeLoaded", gmLoaded )

--[ First Spawn ]
function firstSpawn( ply )
	if ( ply:GetPData( "PlayerLevel" ) == nil ) then
		ply:SetLevel( 1 )
	else
		ply:SetLevel( tonumber( ply:GetPData( "PlayerLevel" ) ) )
	end

	if ( ply:GetPData( "PlayerExp" ) == nil ) then
		ply:SetExp( 0 )
	else
		ply:SetExp( tonumber( ply:GetPData( "PlayerExp" ) ) )
	end
end
hook.Add( "PlayerInitialSpawn", "PlayerFirstSpawn", firstSpawn )

--[Player Disconnected]
function playerLeft( ply )
	ply:SetPData( "PlayerLevel", ply:CurLvl() )
	ply:SetPData( "PlayerExp", ply:CurExp() )
end
hook.Add( "PlayerDisconnected", "PlayerLeftServer", playerLeft )

--[Shutdown]
function serverClosed()
	for k, v in pairs( player.GetAll() ) do
		v:SetPData( "PlayerLevel", v:CurLvl() )
		v:SetPData( "PlayerExp", v:CurExp() )
	end
end
hook.Add( "ShutDown", "ServerShutDown", serverClosed )
