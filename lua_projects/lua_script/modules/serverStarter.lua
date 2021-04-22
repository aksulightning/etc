local server_starter = {}

function server_starter.choose (arg)
	if os.execute("ls -f ./servers/" .. arg .. " > /dev/null") then
		os.execute('bash -c "./servers/' .. arg .. '/start-screen.sh"')
		print("Started server: " .. arg)
	else
	print("Server doesn't exist or created yet.")
	print("")
	end
end

function server_starter.close (arg)
	if os.execute("ls -f ./servers/" .. arg .. " > /dev/null") then
		os.execute('screen -S ' .. arg .. '_server -p 0 -X stuff "stop^M"')
	else
	print("Server doesn't exist or created yet.")
	print("")
	end
end

return server_starter
