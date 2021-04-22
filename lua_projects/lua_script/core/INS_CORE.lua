local choose_mc_version = require "../modules/chooseVersion"
local server_starter = require "../modules/serverStarter"
local loadstringFromFile = require "../modules/loadstringFromFile"

function view_help ()
	print("Simple Minecraft Server Management Helper")
	print("Help page")
	print("=====================================================")
	print("about -- Shows information about command prompt")
	print("help -- Shows help page")
	print("create -- Helps management creation of new server.")
	print("start -- Starts choosed server.")
	print("close -- Shutdowns choosed server.")
	print("sysinfo -- Shows current system.")
	print("exit -- Exit from command prompt.")
	print("=====================================================")
	print("")
end

function acceptionofEULA (arg, value)
	if value == "true" then
	os.execute("echo 'eula = true' > ./servers/" .. arg .. "/eula.txt")
	else
	os.execute("echo 'eula = false' > ./servers/" .. arg .. "/eula.txt")
	end
end

local CORE = {}

function CORE.modify_settings ()
	print("Set setting1:")
	local setting1 = io.read()
	print("Set setting2:")
	local setting2 = io.read()
	_G.SMSMH_settings[1] = setting1
	_G.SMSMH_settings[2] = setting2
	loadstringFromFile.tablesave(_G.SMSMH_settings, "settings.lua")
	print("Settings are saved!")
	print("")
end

function CORE.create_settings ()
	if os.execute("ls ./settings.lua > /dev/null") then
		print("OK")
	else
		_G.SMSMH_settings = {"1024", "2"}
		-- 1 is MEMORY 1 GB = 1024M, 2 is for none
		loadstringFromFile.tablesave(_G.SMSMH_settings, "settings.lua")
		print("Settings file created!")
	end
end

function CORE.load_settings ()
	_G.SMSMH_settings = loadstringFromFile.tableload("settings.lua")
		for k,v in pairs(_G.SMSMH_settings) do
		print("Loaded from settings:")
		print("Value sector: ".. k .. " Value-data: " .. v)
	end
end


function CORE.about ()
	print("Simple Minecraft Server Management Helper")
	print("Version: 1.0")
	print("This command prompt is licensed under The GNU General Public License v3.0")
	print("")
	print("Lua version:")
	os.execute("lua -v")
	print("")
	
	local system
	
	if os.getenv("WINDIR") then
		system = 'Windows'
		print("Operating system is: " .. system)
		print("")
		return system
	end

	if os.getenv("HOME") then
		system = 'Linux'
		print("Operating system is: " .. system)
		print("")
		return system
	end
end

function CORE.start (arg)
	server_starter.choose(arg)
end

function CORE.close (arg)
	server_starter.close(arg)
end

function CORE.create (arg)
	local success = false
	print("Name will be: " .. arg)
	os.execute("mkdir ./servers/" .. arg)
	-- Create files
	print("Do you accept Mojang's EULA? *true* or *false*")
	local acception_of_mojang_eula = io.read()
	acceptionofEULA(arg, acception_of_mojang_eula)
	os.execute("cp ./resources/* ./servers/" .. arg .. "/")
	os.execute("echo 'java -Xms1024m -Xmx1024m -jar Server.jar' >> ./servers/" .. arg .. "/start.sh")
	os.execute("echo 'screen -dmS ".. arg .."_server java -Xms1024m -Xmx1024m -jar Server.jar' >> ./servers/" .. arg .. "/start-screen.sh")
	os.execute("chmod +x ./servers/" .. arg .. "/start.sh")
	os.execute("chmod +x ./servers/" .. arg .. "/start-screen.sh")
	print("What server software you want to use? (Vanilla, paper or Sponge?)")
	local server_software = io.read()
	print("What Minecraft version you want to use?")
	local mc_version = io.read()
	choose_mc_version.select(arg, server_software, mc_version)
	print("Done")
	print("")
end

function CORE.exit ()
	os.exit()
end

function CORE.help ()
	view_help()
end

return CORE
