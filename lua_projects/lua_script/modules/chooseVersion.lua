local mc_game_versions = {"1.12.2", "1.13.2", "1.14.3"}

function search_Version (version)
	for k,v in pairs(mc_game_versions) do
		if v == version then
			return version
		end
	end
end

local choose_mc_version = {}

function choose_mc_version.select (arg, software, version)
	if software == "paper" then
		if version == search_Version(version) then
			os.execute("wget https://papermc.io/api/v1/paper/" .. version .."/latest/download -O ./servers/" .. arg .. "/Server.jar" )
			os.execute("chmod +x ./servers/" .. arg .. "/Server.jar")
			success = true
		end
	end
end

return choose_mc_version
