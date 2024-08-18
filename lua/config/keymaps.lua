-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<tab>", "<C-^>", {})
vim.keymap.set("n", "<M-d>", "<C-d>M", {})
vim.keymap.set("n", "<M-u>", "<C-u>M", {})
vim.keymap.set("n", "<M-o>", "<C-o>", {})
vim.keymap.set("n", "<M-i>", "<C-i>", {})
-- vim.keymap.set("n", "<leader>n", "<cmd> Ex <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> make <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> silent !tmux send -t :2 'make ' Enter; tmux select-window -t :2 <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> silent !tmux send -t 2 'make ' Enter <cr>", {})
-- vim.keymap.set("n", "<leader>k", "<cmd> silent !tmux send -t 2 'make ' Enter; tmux resize-pane -Z <cr>", {})
-- :2 is pane TWO, 2 is just the second one

-- local start = "<cmd>silent !tmux send -t :2 '"
-- local sick_cmd = 'cat Makefile | grep ":" | sed "s/://" | head -n1 | tr -d "\\n" | tr -d " " | xargs -I {} make {}'
-- local _end = "' Enter; tmux select-window -t :2'<CR>"
--
--
--Function choose make file based on file
-- local tst = "cat Makefile | grep ':' | sed 's/://' | fzf | " .. 'tr -d " "' .. "| xargs -I {} make {}"
-- vim.keymap.set(
--   "n",
--   "<leader>l",
--   "<cmd> silent !tmux send -t :2 '" .. tst .. "' Enter ;tmux select-window -t :2 <CR>",
--   {}
-- )

-- Initial element if has not been ran before
_G.FILENAME = "all"
vim.keymap.set("n", "<leader>l", function()
  -- The following runs telescope with a command and saves the output
  local filepath = debug.getinfo(1).source:match("@?(.*/)")
  local opts = {
    -- this is the command which gives the elements to choose from
    find_command = { "bash", filepath .. "get_options_from_Makefile.sh" },

    -- This one saves the picked element to _G.FILENAME
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        -- filename is available at entry[1]
        local entry = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        _G.FILENAME = entry[1]
      end)
      return true
    end,

    -- and what to show
    previewer = require("telescope.previewers").new_termopen_previewer({
      get_command = function(entry)
        local hash = entry.value
        filepath = debug.getinfo(1).source:match("@?(.*/)")
        return { "python3", filepath .. "get_correct.py", hash }
      end,
    }),
  }
  require("telescope.builtin").find_files(opts)
end, {})

-- needs extra function to take arguments
local RunMakeWithTheChoosenName = function(_G)
  print(_G.FILENAME)

  local cwd = vim.loop.cwd()
  local cmd = "silent !tmux send -t :2 'make "
    .. _G.FILENAME
    .. " &| tee .err; "
    .. "cat .err | grep " -- START remove this to just use normal compiler and not format it before
    .. cwd
    .. " | tac > .err.reversed; " -- ENd
    .. "' Enter; tmux select-window -t :2 "
  vim.cmd(cmd)
end
vim.keymap.set(
  "n",
  "<leader>k",
  function()
    RunMakeWithTheChoosenName(_G)
  end,
  -- "<cmd> !tmux send -t :2 'make " .. _G.FILENAME .. "' Enter; tmux select-window -t :2 <cr>",
  { silent = true }
)

vim.keymap.set("n", "ge", function()
  -- vim.cmd("compiler pyunit")
  -- vim.cmd("cf .err.reversed") -- cg does not jump to first error. Set to just .err for other than python
  vim.cmd("cg .err.reversed") -- cg does not jump to first error. Set to just .err for other than python
  vim.cmd("Telescope quickfix")

  -- vim.cmd("cf .err.reversed") -- cg does not jump to first error
end, {})
-- vim.keymap.set("n", "gj", function()
--   vim.cmd("setl efm=%A%f:%l: %m,%-Z%p^,%-C%.%#") -- java
--   vim.cmd("cf .err") -- cg does not jump to first error
-- end, {})

-- print(start .. sick_cmd .. _end)
--
-- end, {})

vim.keymap.set("n", "s", "<cmd> HopWord <cr>", {})
vim.keymap.set("v", "s", "<cmd> HopWord <cr>", {})
vim.keymap.set("o", "s", "<cmd> HopWord <cr>", {})

-- vim.keymap.set("n", "h", "^", {})
-- vim.keymap.set("n", "l", "$", {})

vim.api.nvim_set_option("clipboard", "")
vim.keymap.set("v", "<C-c>", '"+yi', {})

-- Oil
vim.keymap.set("n", "<leader>n", "<cmd> Oil <cr>", {})
vim.keymap.set("n", "<leader>d", "<cmd> bd <cr>", {})
-- vim.keymap.set("v", "y", '"+yi', {})
-- vim.keymap.set("n", "y", '"+yi', {})
-- vim.keymap.set("v", "y", '"+yi', {})
--
-- vim.keymap.set("n", "<leader>q", "<cmd> bd <cr>", {})

vim.keymap.del("n", "=p", {})
vim.keymap.del("n", "=P", {})
vim.keymap.set("n", "=", "}", {})
vim.keymap.set("v", "=", "}", {})
vim.keymap.set("o", "=", "}", {})
--
-- vim.keymap.set("n", "[e", "<cmd>cn<cr>", {})
-- vim.keymap.set("n", "]e", "<cmd>cp<cr>", {})
-- Remove some lazy vim default keymaps
vim.keymap.del("n", "<leader>fn", {})
vim.keymap.del("n", "<leader>ft", {})
vim.keymap.del("n", "<leader>fT", {})

-- vim.keymap.del("n", "<leader>w-", {})
-- vim.keymap.del("n", "<leader>w|", {})
-- vim.keymap.del("n", "<leader>wd", {})
-- vim.keymap.del("n", "<leader>wm", {})
-- vim.keymap.del("n", "<leader>ww", {})

if vim.g.vscode then
  local vscode = require("vscode")
  vim.keymap.set("n", "<C-/>", function()
    vscode.action("editor.action.commentLine")
  end, {})
  vim.keymap.set("n", "<space>/", function()
    vscode.action("editor.action.commentLine")
  end, {})
  vim.keymap.set("v", "<space>/", function()
    vscode.action("editor.action.commentLine")
  end, {})
  vim.keymap.set("n", "<leader>/", function()
    vscode.action("editor.action.commentLine")
  end, {})
  -- slow as fuck -- because its waiting for other f- keymaps.. Should be disabled. is now
  vim.keymap.set("n", "<space>f", function()
    vscode.action("workbench.action.quickOpen")
  end, { remap = true })
  vim.keymap.set("n", "<space>w", function()
    vscode.action("workbench.action.findInFiles")
  end, {})

  vim.keymap.set("n", "<tab>", function()
    vscode.action("extension.goto-previous-buffer")
  end, {})
  -- TODO needs to be relative path
  vim.cmd("source /home/las/.config/nvim/lua/config/vimi2.vim") -- why no work?
  -- vim.keymap.set("n", "<space>a", "<cmd> tabfind <cr>", {})
  vim.keymap.set("n", "<A-i>", "<C-i>", {})
  vim.keymap.set("n", "<A-o>", "<C-o>", {})
end
