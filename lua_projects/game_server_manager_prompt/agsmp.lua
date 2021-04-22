local commandTable = {}
local commandTable2 = {}
local commandTable3 = {}

function commandTable.helloworld(message, player)
	print("Hello world!")
end

while true do
	message = io.read()
	-- Command only
	local command = message:match("(.+)")
	if command and commandTable[command] then
		commandTable[command](argument, player)
	end
	-- Command: one arg
	local command, arg1 = message:match("(.+) (.+)")
	if command and commandTable[command] then
		commandTable[command](argument, player)
	end
	-- Command: two arg
	local command, arg1, arg2 = message:match( "(.+) (.+)")
	if command and commandTable[command] then
		commandTable[command](argument, player)
	end
end