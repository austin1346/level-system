#NoSimplerr#
--[ Server ]--

--[OnNPCKilled]
function NPCKilled( npc, attacker, inflictor )
	attacker:AddExp( 101 )
end
hook.Add( "OnNPCKilled", "PlayerKilledNPC", NPCKilled )
