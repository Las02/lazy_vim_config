-- return {
--   "smoka7/hop.nvim",
--   version = "*",
--   opts = {},
--   vscode = true,
-- }
return {
  "leath-dub/snipe.nvim",
  version = "*",
  opts = {},
  vscode = false,
  config = function()
    local snipe = require("snipe")
    snipe.setup()
    vim.keymap.set("n", "<leader>j", snipe.create_buffer_menu_toggler())
  end,
}
