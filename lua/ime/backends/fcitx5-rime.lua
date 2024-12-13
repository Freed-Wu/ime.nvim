---backend for fcitx5, with rime support

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

---enable ascii mode
function M:enable_ascii()
  M.proxy:SetAsciiMode(true)
end

---disable ascii mode
function M:disable_ascii()
  M.proxy:SetAsciiMode(false)
end

---judge if ascii mode
---@return boolean
function M:is_ascii()
  return M.proxy:IsAsciiMode()
end

---get current input schema name
---@return string
function M:current()
  return M.proxy:GetCurrentSchema()
end

M:current()

return M
