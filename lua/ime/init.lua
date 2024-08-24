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
