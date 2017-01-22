#NoSimplerr#
--[ Server ]--
--This is where you define how a player obtains Exp.
--Included are a few examples.

--[OnNPCKilled]
function NPCKilled( npc, attacker, inflictor )
	attacker:AddExp( LEVELS.expNpcKilled )
end
hook.Add( "OnNPCKilled", "PlayerKilledNPC", NPCKilled )

--[Start 'give exp timer']
function initSpawn( ply )
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

	timer.Remove( "xp_" .. id )
end
hook.Add( "PlayerDisconnected", "PlayerLeft2", playerLeft )
