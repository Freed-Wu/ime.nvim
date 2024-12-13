---backend for fcitx5

-- luacheck: ignore 212/self
local p = require "dbus_proxy"
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.fcitx.Fcitx5",
    interface = "org.fcitx.Fcitx.Controller1",
    path = "/controller"
  }
)
local M = {
  proxy = proxy,
}

---enable ascii mode
function M:enable_ascii()
  M.proxy:Deactivate()
end

---disable ascii mode
function M:disable_ascii()
  M.proxy:Activate()
end

---judge if ascii mode
function M:is_ascii()
  return M.proxy:State() == 1
end

---get current input schema name
---@return string
function M:current()
  local im = M.proxy:CurrentInputMethod()
  if im == 'rime' then
    im = im .. ':' .. require 'ime.backends.fcitx5-rime':current()
  end
  return im
end

M:current()

return M
