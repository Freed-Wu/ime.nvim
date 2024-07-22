-- luacheck: ignore 212/self
local p = require "dbus_proxy"
local cjson = require "cjson"
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.gnome.Shell",
    interface = "org.g3kbswitch.G3kbSwitch",
    path = "/org/g3kbswitch/G3kbSwitch"
  }
)
local M = {
  proxy = proxy,
}

function M:enable_ascii()
  M.proxy:Set(0)
end

function M:disable_ascii()
  M.proxy:Set(1)
end

function M:is_ascii()
  return M.proxy:Get()[2] == "0"
end

function M:current()
  local id = M.proxy:Get()[2]
  for _, kv in ipairs(cjson.decode(M.proxy:List()[2])) do
    if kv.key == id then
      return kv.value
    end
  end
  return ""
end

return M