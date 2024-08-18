local my_prefix = function(fs_entry)
  -- if fs_entry.fs_type == "directory" then
  --   -- NOTE: it is usually a good idea to use icon followed by space
  --   return "X ", "MiniFilesDirectory"
  -- end
  -- return MiniFiles.default_prefix(fs_entry)
end

-- require("mini.files").setup({ content = { prefix = my_prefix } })

return {
  "echasnovski/mini.files",
  version = "*",
  -- opts = { content = { prefix = my_prefix } },
  opts = {},
  vscode = false,
  keys = function()
    return {
      {
        "<leader>n",
        function()
          require("mini.files").open()
        end,
        desc = "open mini.files",
      },
    }
  end,
}
