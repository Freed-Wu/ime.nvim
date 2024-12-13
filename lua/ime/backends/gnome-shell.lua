---backend for gnome-shell < 41. If you use ibus or fcitx5, please use them.

-- luacheck: ignore 212/self
local p = require "dbus_proxy"
local cjson = require "cjson"
local proxy = p.Proxy:new(
  {
    bus = p.Bus.SESSION,
    name = "org.gnome.Shell",
    interface = "org.gnome.Shell",
    path = "/org/gnome/Shell"
  }
)
local M = {
  proxy = proxy,
}

---enable ascii mode
function M:enable_ascii()
  M.proxy:Eval("\"imports.ui.status.keyboard.getInputSourceManager().inputSources[0].activate()\"")
end

---disable ascii mode
function M:disable_ascii()
  M.proxy:Eval("\"imports.ui.status.keyboard.getInputSourceManager().inputSources[1].activate()\"")
end

---judge if ascii mode
---@return boolean
function M:is_ascii()
  return M.proxy:Eval("\"imports.ui.status.keyboard.getInputSourceManager().currentSource.index\"")[2] == "0"
end

---get current input schema name
---@return string
function M:current()
  local id = M.proxy:Eval("\"imports.ui.status.keyboard.getInputSourceManager().currentSource.index\"")[2]
  for _, kv in ipairs(cjson.decode(M.proxy:Eval(
    "\"var ids=[]; \
    for(var i in imports.ui.status.keyboard.getInputSourceManager().inputSources){ \
      ids.push({key:i,value:imports.ui.status.keyboard.getInputSourceManager().inputSources[i].id}) \
    }; \
    ids\""
  )[2])) do
    if kv.key == id then
      return kv.value
    end
  end
  return ""
end

M:current()

return M
