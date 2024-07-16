-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- vim.cmd("compiler pyunit")
vim.cmd("source /home/las/.config/nvim/lua/config/vimi.vim")

-- if vim.g.vscode then
--   local vscode = require("vscode")
--   vim.keymap.set("n", "<C-/>", function()
--     vscode.action("editor.action.commentLine")
--   end, {})
--   vim.keymap.set("n", "<space>a", "<cmd> tabfind <cr>", {})
-- end
