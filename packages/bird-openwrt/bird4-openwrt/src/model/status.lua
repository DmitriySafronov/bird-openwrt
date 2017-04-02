--[[
Copyright (C) 2014-2017 - Eloi Carbo

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

local sys = require "luci.sys"

m = SimpleForm("bird4", "Bird4 UCI Status Page", "This page let you Start,   Stop, Restart and check Bird4 Service Status.")
m.reset = false
m.submit = false

s = m:section(SimpleSection)

start = s:option(Button, "_start", "Start")
start.inputstyle = "apply"

stop = s:option(Button, "_stop", "Stop")
stop.inputstyle = "remove"

restart = s:option(Button, "_restart", "Restart")
restart.inputstyle = "reload"

output = s:option(DummyValue, "_value", "Service Status")
function output.cfgvalue(self, section)
    local ret = ""
    if start:formvalue(section) then
        ret = sys.exec("/etc/init.d/bird4 start_q")
    elseif stop:formvalue(section) then
        ret = sys.exec("/etc/init.d/bird4 stop_q")
    elseif restart:formvalue(section) then
        ret =sys.exec("/etc/init.d/bird4 restart_q")
    else
        ret = sys.exec("/etc/init.d/bird4 status_q")
    end
    return ret
end

return m