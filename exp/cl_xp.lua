#NoSimplerr#
--[ Client ]--

net.Receive( "PlayerLeveledUp", function()
	local newLevel = net.ReadString()

	surface.PlaySound( "garrysmod/save_load4.wav" )
	notification.AddLegacy( "Level up!; " .. newLevel, NOTIFY_GENERIC, 5 )
end )