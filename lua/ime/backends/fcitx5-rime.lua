-- luacheck: ignore 212/self
local p = require "dbus_proxy"
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.fcitx.Fcitx5",
    interface = "org.fcitx.Fcitx.Rime1",
    path = "/rime"
  }
)
local M = {
  proxy = proxy,
}

function M:enable_ascii()
  M.proxy:SetAsciiMode(true)
end

function M:disable_ascii()
  M.proxy:SetAsciiMode(false)
end

function M:is_ascii()
  return M.proxy:IsAsciiMode()
end

function M:current()
  return M.proxy:GetCurrentSchema()
end

M:current()

return M
