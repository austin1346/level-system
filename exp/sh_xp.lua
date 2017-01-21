#NoSimplerr#
--[ Shared ]--

--[Config]
expMultiplier = 4.75;





--[Do not touch anything after this line or else it will break!]
local plyMeta = FindMetaTable( "Player" )

--[Return Player Exp]
function plyMeta:CurExp()
	return self:GetNWInt( "PlayerExp" )
end

--[Return Current Level]
function plyMeta:CurLvl()
	return self:GetNWInt( "PlayerLevel" )
end

--[Exp to level]
function plyMeta:expToLevel()
	return ( self:CurLvl() * 100 ) * expMultiplier
end
