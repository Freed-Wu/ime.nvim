-- luacheck: ignore 111 113
---@diagnostic disable: undefined-global
if vim and vim.env.GI_TYPELIB_PATH == nil then
    local f = io.open("/run/current-system/nixos-version")
    if f then
        f:close()
        f = io.popen(vim.fs.joinpath(
            vim.fs.dirname(debug.getinfo(1).source:match("@?(.*)")),
            "get-GI_TYPELIB_PATH.nix"
        ))
        if f then
            loadstring("vim.env.GI_TYPELIB_PATH = " .. f:read())()
            f:close()
        end
    end
end
local ok
local backend = nil
for _, name in ipairs {
    "fcitx5", "fcitx5-rime", "g3kbswitch", "gnome-shell", "ibus"
} do
    ok, backend = pcall(require, "ime.backends." .. name)
    if ok then
        backend.name = name
        break
    end
end
return backend
