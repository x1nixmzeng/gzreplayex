--[[
	x1nixmzeng
	
	example2.lua
--]]


-- Expects a table with 2 strings
function gzreplayRegister()

	return
	{
		-- Plugin name
		'Example 2',
		-- Plugin description
		'This script has a callback when a replay is loaded.\n' ..
		'It also calls a function hook:\n\n' ..
		'With EXP 684604 you are level ' .. GetLevelFromExp( 684604 ) .. '!'
	}

end

-- Callback expects no return value
function gzreplayNewFileLoaded()

	lvl1 = GetLevelFromExp( 1 )
	lvl2 = GetLevelFromExp( 202 )
	lvl3 = GetLevelFromExp( 1003 )
	
	-- Does nothing with this data for now..

end