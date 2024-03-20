-- https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1873229658
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
    end)
  end,
})

local function filenameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

return {
  "nvim-telescope/telescope.nvim",
  opts = function()
    local actions = require("telescope.actions")
    return {
      pickers = {
        buffers = {
          path_display = filenameFirst,
          previewer = false,
        },
        git_files = {
          path_display = filenameFirst,
          previewer = false,
        },
        find_files = {
          path_display = filenameFirst,
          previewer = false,
        },
      },
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
