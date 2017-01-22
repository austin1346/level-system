#NoSimplerr#
--[ Shared ]--

--[Config]
--Exp Multiplier; Used to change the max Exp required to level up
GM.expMultiplier = 4.75; --Default 4.75x

--How much Exp should be awarded upon killing an Npc?
GM.expNpcKilled = math.random( 90, 110 );

--At what interval should it give players Exp
GM.expTimer = 300; --Default 300s

--Amount of Exp to give players through the above timer
GM.expTimerAmt = 150; --Default 150xp




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
	return ( self:CurLvl() * 100 ) * GAMEMODE.expMultiplier
end
