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
