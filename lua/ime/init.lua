local ok
local backend = nil
local backend_names = {}
for exe, names in pairs {
    ["fcitx5-remote"] = { "fcitx5", "fcitx5-rime" },
    ["g3kb-switch"] = { "g3kbswitch", "gnome-shell" },
    ["ibus-daemon"] = { "ibus" }
} do
    -- luacheck: ignore 112 113
    ---@diagnostic disable: undefined-global
    if vim == nil or vim.fn.executable(exe) == 1 then
        for _, name in ipairs(names) do
            table.insert(backend_names, name)
        end
    end
end
for _, name in ipairs(backend_names) do
    ok, backend = pcall(require, "ime.backends." .. name)
    if ok then
        backend.name = name
        break
    end
end
return backend
