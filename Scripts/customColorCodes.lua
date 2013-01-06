--[[
	x1nixmzeng
	
	customColorCodes.lua
--]]

function gzreplayRegister()

	-- Tag followed by the colour value
	AddChatColor('!', 0x0088FF )
	AddChatColor('@', 0xFF8800 )
	AddChatColor('#', 0x11DD11 )

	return
	{
		'customColourCodes',
		'This script registers some more colour codes used by some private servers'
	}

end
