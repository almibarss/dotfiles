return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader><space>", "<cmd>Telescope find_files previewer=false<cr>", desc = "Find Files (root dir)" },
  },
  opts = function()
    local actions = require("telescope.actions")
    return {
      defaults = {
        mappings = {
          n = {
            ["d"] = actions.delete_buffer,
          },
        },
      },
    }
  end,
}
