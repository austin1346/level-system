#NoSimplerr#
--[ Server ]--

--[OnNPCKilled]
function NPCKilled( npc, attacker, inflictor )
	attacker:SetNWInt( "PlayerExp", attacker:CurExp() + 101 )

	canPlayerLevel( attacker )
end
hook.Add( "OnNPCKilled", "PlayerKilledNPC", NPCKilled )
