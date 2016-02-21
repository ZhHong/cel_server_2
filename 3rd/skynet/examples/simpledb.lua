local skynet = require "skynet"
require "skynet.manager"	-- import skynet.register
local db = {}

local command = {}

function command.GET(key)
	return db[key]
end

function command.SET(key, value)
	local last = db[key]
	db[key] = value
	return last
end

function command.USERINFO(key)
	initSimpleDB()
	local last = db[key]
	return last
end

--[[response {
		uid 0 : integer
		uname 1: string
		sex 2: integer
		level 3: integer
		exp 4: integer
		gold 5 : integer
	}
]]
function initSimpleDB()
	db['30001']={['uid']=30001,['uname']='cutely',['sex']=1,['level']=11,['exp']=1000,['gold']=8888}
end

skynet.start(function()
	skynet.dispatch("lua", function(session, address, cmd, ...)
		local f = command[string.upper(cmd)]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			error(string.format("Unknown command %s", tostring(cmd)))
		end
	end)
	skynet.register "SIMPLEDB"
end)
