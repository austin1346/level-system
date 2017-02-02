#NoSimplerr#
--[Config]--
LEVELS = {}

--[Base settings] These are very important and should be tested multiple times after editing
--Enable logging in the server console?
LEVELS.logging = true;
--The multiplier used to adjust the difficulty of leveling. (Default 3.25x)
LEVELS.expMultiplier = 3.25;
--The maximum level a player can reach. (Default 55)
LEVELS.maxLevel = 55;

--[Client settings]
--The message to display when a player levels up.
LEVELS.levelUpNotifyMsg = "Level up!";
--The sound to be played when a player levels up. You can find other sounds here: https://maurits.tv/data/garrysmod/wiki/wiki.garrysmod.com/index8f77.html
LEVELS.levelUpSound = "garrysmod/save_load4.wav";

--[Exp upon NPC killed]
--Should the player receive Exp for killing en Npc?
LEVELS.expNpcKilledEnabled = true;
--How much Exp should be awarded upon killing an Npc?
LEVELS.expNpcKilledDefault = 100;
--Should it generate a random number instead of using the default value above?
LEVELS.expNpcKilledRandEnabled = true;
--If random is enabled, between what TWO values should it generatre the number?
LEVELS.expNpcKilledRandAmt = {90, 110}
--What Npc's (if any) should have special Exp rewards? If an npc isn't in the list below, then it will reward the default amount that you set above instead.
LEVELS.expNpcKilledList = {
	npc_crow = 50, --Syntax: npc_class = xp,
	npc_pigeon = 50,
	npc_seagull = 50,
	npc_monk = 200,
} --You need to find what the classname is for the specific NPC you're trying to add, I've included some examples. Just leave the table empty if you don't want any special rewards.

--[Exp Timer]
--Should the Exp Timer be enabled?
LEVELS.expTimerEnabled = true;
--At what interval should it give players Exp if enabled? (Default 300sec)
LEVELS.expTimer = 300;
--Amount of Exp to give players through the above timer. (Default 150xp)
LEVELS.expTimerAmt = 150;






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
	return ( self:CurLvl() * 100 ) * LEVELS.expMultiplier
end

--[Formatted EXP]
function plyMeta:GetFormattedExp() --Red=Low xp; Green=High xp; Color will change from red to green based on how close to leveling they are. Need to convert FormattedExp to a percentage.
	local CurExp = self:CurExp()
	local MaxExp = self:expToLevel()
	return ( CurExp .. "/" .. MaxExp )
end
