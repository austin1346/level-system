#NoSimplerr#
--[Server]--
--[Do not touch anything after this line or else it will break!]

--[OnNPCKilled]
function NPCKilled( npc, attacker, inflictor )
	if !LEVELS.expNpcKilledEnabled then return end
	local npcList = LEVELS.expNpcKilledList[npc:GetClass()]
	local defAmt = LEVELS.expNpcKilledDefault

	if LEVELS.expNpcKilledRandEnabled then
		local rand1 = LEVELS.expNpcKilledRandAmt[1]
		local rand2 = LEVELS.expNpcKilledRandAmt[2]
		local amt = npcList or math.random( rand1, rand2 )
		attacker:AddExp( amt )
		attacker:ChatPrint( "Gave amount for list or random" )	--Debug
		return
	end

	attacker:AddExp( npcList or defAmt )
	attacker:ChatPrint( "Gave amount for list or default" )		--Debug
end
hook.Add( "OnNPCKilled", "PlayerKilledNPC", NPCKilled )

--[Start 'give exp timer']
function initSpawn( ply )
	if !LEVELS.expTimerEnabled then return end

	local id = ply:AccountID()

	timer.Create( "xp_" .. id, LEVELS.expTimer, 0, function()
		ply:AddExp( LEVELS.expTimerAmt )
		ply:PrintMessage( HUD_PRINTCONSOLE, "[DEBUG] Timer ran!" )
	end )
end
hook.Add( "PlayerInitialSpawn", "PlayerFirstSpawn2", initSpawn )

--[Remove 'give exp timer']
function playerLeft( ply )
	local id = ply:AccountID()

	if timer.Exists( "xp_" .. id ) then
		timer.Remove( "xp_" .. id )
	end
end
hook.Add( "PlayerDisconnected", "PlayerLeft2", playerLeft )
