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
	
end

local thread = coroutine.create()

local function resume(...)
	local ok,err = coroutine.
end