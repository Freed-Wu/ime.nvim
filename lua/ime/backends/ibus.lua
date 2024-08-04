-- luacheck: ignore 212/self
local lgi = require "lgi"
local p = require "dbus_proxy"
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.freedesktop.IBus",
    interface = "org.freedesktop.IBus",
    path = "/org/freedesktop/IBus",
    flags = lgi.Gio.DBusProxyFlags.DO_NOT_AUTO_START
  }
)
local M = {
  proxy = proxy,
  ascii_kbd = "xkb:us::eng",
  non_ascii_kbd = "rime"
}

function M:enable_ascii()
  M.proxy:SetGlobalEngine(M.ascii_kbd)
end

function M:disable_ascii()
  M.proxy:SetGlobalEngine(M.non_ascii_kbd)
end

function M:is_ascii()
  return M.proxy:GetGlobalEngine()[3] == M.ascii_kbd
end

function M:current()
  return M.proxy:GetGlobalEngine()[3]:sub("xkb:", ""):sub("::.*", "")
end

return M
