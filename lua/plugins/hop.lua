return {
  "smoka7/hop.nvim",
  version = "*",
  opts = {},
  -- config = function() end,
  --   branch = 'v2', -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require("hop").setup({})
  end,
  vscode = true,
}
