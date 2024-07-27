-- luacheck: ignore 212/self
local p = require "dbus_proxy"
local proxy0 = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.freedesktop.IBus",
    interface = "org.freedesktop.IBus",
    path = "/org/freedesktop/IBus"
  }
)
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.freedesktop.IBus",
    interface = "org.freedesktop.IBus",
    path = proxy0:CurrentInputContext()
  }
)
local M = {
  proxy = proxy,
}

function M:enable_ascii()
  M.proxy:Enable()
end

function M:disable_ascii()
  M.proxy:Disable()
end

function M:is_ascii()
  return M.proxy:IsEnabled()
end

function M:current()
  return M.proxy0:CurrentInputContext():gsub('.*/', '')
end

return M
