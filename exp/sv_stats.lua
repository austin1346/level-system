#NoSimplerr#
--[Stat saving]
local plyMeta = FindMetaTable( "Player" )

--[Save stats]

--[ First Spawn ]
function firstSpawn( ply )
	ply:SetLevel( tonumber( ply:GetPData( "PlayerLevel", 1 ) ) )
	ply:SetExp( tonumber( ply:GetPData( "PlayerExp", 0 ) ) )
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
