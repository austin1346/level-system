#NoSimplerr#
--[ Server ]--

--[OnNPCKilled]
function NPCKilled( npc, attacker, inflictor )
	attacker:AddExp( math.random( 50, 150 ) )
end
hook.Add( "OnNPCKilled", "PlayerKilledNPC", NPCKilled )
