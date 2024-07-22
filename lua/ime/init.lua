local ok
local backend = nil
for _, name in ipairs({ "fcitx5", "fcitx5-rime", "g3kbswitch", "gnome-shell" }) do
    ok, backend = pcall(require, "ime.backends." .. name)
    if ok then
        break
    end
end
if backend == nil then
    return
end
return backend
