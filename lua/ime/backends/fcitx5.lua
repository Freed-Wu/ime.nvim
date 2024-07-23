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

function M:enable_ascii()
  M.proxy:Deactivate()
end

function M:disable_ascii()
  M.proxy:Activate()
end

function M:is_ascii()
  return M.proxy:State() == 1
end

function M:current()
  local im = M.proxy:CurrentInputMethod()
  if im == 'rime' then
    im = im .. ':' .. require 'ime.backends.fcitx5-rime':current()
  end
  return im
end

return M
