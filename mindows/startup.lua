--!startup.lua
--!by Zocker1999_NET
-- This file creates a sand-box and runs the mindows core inside.
-- If an error appeers, it will catch the error and print details to the screen.
-- It detectes the system type and pushes this information to the kernel

local sysType = "" -- cc / oc-nothing / oc-openos

if type(_HOST) == "string" and _HOST:sub(1,13) == "ComputerCraft" then
	sysType = "cc"
end
if sysType = "" then
	error("Unable to detect system type")
end

local coroutine = _ENV.coroutine
if sysType:sub(1,2) == "oc" and coroutine == nil then
	coroutine = require("coroutine")
end

local function pr(t)
	if t == nil then
		t = ""
	end
	t = tostring(t)
	if sysType == "cc" then
		print(t)
		sleep(0.5)
	else
		
	end
end

local function showError(err)
	if sysType == "cc" then
		local file = fs.open("/startup","w")
		file.write([[
			print("To start Mindows again, please restart the computer once again.")
			local file = fs.open("/startup","w")
			file.write('shell.run("/mindows/startup.lua")')
			file.close()
		]])
		file.close()
		parallel.waitForAny(function
			if term.isColor() then
				term.setBackgroundColor(colors.blue)
			else
				term.setBackgroundColor(colors.black)
			end
			term.clear()
			term.setTextColor(colors.white)
			term.setCursorPos(1,1)
			pr("Mindows Crash Report")
			pr()
			pr("System crashed caused by")
			pr(err)
			pr()
			pr("Mindows will not boot after the next restart of this computer. If you would like to start Mindows again, restart the computer once again.")
			sleep(10)
		end,function
			local ev,key = os.pullEvent("key")
			if key == keys.leftAlt then
				return nil
			end
		)
		os.shutdown()
		return nil
	else
		
	end
end

local fn = nil



local thread = coroutine.create()

local function resume(...)
	local ret = {coroutine.resume(thread,...)}
	local err = ret[2]
	if ret[1] then
		if type(err) ~= "string" then
			err = "Unknown error"
		end
		showError(err)
	end
	if coroutine.status(thread) == "dead" then
		showError("Thread dead")
	end
end