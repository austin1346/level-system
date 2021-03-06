#NoSimplerr#
--[Stat saving]--
--[Do not touch anything after this line or else it will break!]

local plyMeta = FindMetaTable( "Player" )

--[ First Spawn ]
function firstSpawn( ply )
	ply:SetLevel( tonumber( ply:GetPData( "PlayerLevel", 1 ) ), true )
	ply:SetExp( tonumber( ply:GetPData( "PlayerExp", 0 ) ), true )

	if !LEVELS.logging then return end
	print( "[Levels] Stats loaded for (" .. ply:Name() .. ")" )
end
hook.Add( "PlayerInitialSpawn", "PlayerFirstSpawn", firstSpawn )
