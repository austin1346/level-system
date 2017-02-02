#NoSimplerr#
--[Client]--

net.Receive( "PlayerLeveledUp", function()
	local newLevel = net.ReadUInt( 8 )

	surface.PlaySound( LEVELS.levelUpSound )
	notification.AddLegacy( LEVELS.levelUpNotifyMsg .. " (" .. newLevel .. ")", NOTIFY_GENERIC, 5 )
end )
