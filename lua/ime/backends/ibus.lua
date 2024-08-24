-- luacheck: ignore 112 113 212/self
---@diagnostic disable: undefined-global
local lgi = require "lgi"
local p = require "dbus_proxy"
local DBUS_SESSION_BUS_ADDRESS = ""
if vim then
    local path = vim.fs.find(function(_, _) return true end,
        { path = vim.fs.joinpath(os.getenv("HOME"), ".config", "ibus", "bus") })[1]
    if path then
        for _, line in ipairs(vim.fn.readfile(path)) do
            if line:match("IBUS_ADDRESS=") then
                DBUS_SESSION_BUS_ADDRESS = line:gsub("IBUS_ADDRESS=", "")
            end
        end
    end
end
local proxy = p.Proxy:new(
    {
        bus = p.Bus[DBUS_SESSION_BUS_ADDRESS],
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
    return M.proxy:GetGlobalEngine()[3]:gsub("xkb:", ""):gsub("::.*", "")
end

M:current()

return M
