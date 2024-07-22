-- luacheck: ignore 113
---@diagnostic disable: undefined-global
local ok, ime = pcall(require, "ime")

if not ok or ime == nil or type(ime) == "string" then
    return
end
local augroup_id = vim.api.nvim_create_augroup("ime", {})
vim.api.nvim_create_autocmd("InsertLeavePre", {
    group = augroup_id,
    callback = function()
        if vim.fn.reg_executing() == '' and not ime.is_ascii() then
            ime.enable_ascii()
            ime.insert_is_not_ascii = true
        end
    end,
})
vim.api.nvim_create_autocmd("InsertEnter", {
    group = augroup_id,
    callback = function()
        if ime.insert_is_not_ascii and vim.fn.reg_executing() == '' and ime.is_ascii() then
            ime.disable_ascii()
            ime.insert_is_not_ascii = false
        end
    end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
    group = augroup_id,
    callback = function()
        if vim.fn.reg_executing() == '' and not ime.is_ascii() then
            ime.enable_ascii()
            ime.cmd_is_not_ascii = true
        end
    end,
})
vim.api.nvim_create_autocmd("CmdlineEnter", {
    group = augroup_id,
    callback = function()
        if ime.cmd_is_not_ascii and vim.fn.reg_executing() == '' and ime.is_ascii() then
            ime.disable_ascii()
            ime.cmd_is_not_ascii = false
        end
    end,
})
