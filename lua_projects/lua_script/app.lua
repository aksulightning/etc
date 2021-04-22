local commandTable = require "./core/INS_CORE"
local loadstringFromFile = require "../modules/loadstringFromFile"

function first_load_settings ()
	if os.execute("ls ./settings.lua > /dev/null") then
		_G.SMSMH_settings = loadstringFromFile.tableload("settings.lua")
		print("Loaded from settings:")
		for k,v in pairs(_G.SMSMH_settings) do
			print("Value sector: ".. k .. " Value-data: " .. v)
			print("")
		end
	else
		_G.SMSMH_settings = {"1024", "2"}
		loadstringFromFile.tablesave(_G.SMSMH_settings, "settings.lua")
	end
end

function runCommand (cmd)
	if cmd.match(cmd, "(.+)") and not cmd.match(cmd, "(.+) (.+)") then
	local command = cmd.match(cmd, "(.+)")
	if command and commandTable[command] or command == "help" then
		commandTable[command]()
	else
		print("Invalid command.")
		print("")
	end
	end
	if cmd.match(cmd, "(.+) (.*)") and cmd.match(cmd, "(.+)") then
	local command, argument = cmd.match(cmd, "(.+) (.*)")
	if command and commandTable[command] or command == "help" then
		commandTable[command](argument)
	else
		print("Invalid command.")
		print("")
	end
		if command == "help" then
			print("")
			print("Commands:")
			for k, v in pairs(commandTable) do print(k) end
			print("")
		end
	end
end

-- AUTORUN

print("Starting...")

first_load_settings()

-- AUTORUN


print("Simple Minecraft Server Management Helper")
print("Powered by: LUA")
print("This command prompt is licensed under MIT-license")
print("")

while true do

print("||")
local s =  io.read()

runCommand(s)

end
