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

-- https://github.com/nvim-telescope/telescope.nvim/issues/2874#issuecomment-1900967890
local function find_files_with_ignore_toggle(opts, no_ignore)
  opts = opts or {}
  no_ignore = vim.F.if_nil(no_ignore, false)
  opts.attach_mappings = function(_, map)
    map({ "n", "i" }, "<C-h>", function(prompt_bufnr) -- <C-h> to toggle modes
      local prompt = require("telescope.actions.state").get_current_line()
      require("telescope.actions").close(prompt_bufnr)
      no_ignore = not no_ignore
      find_files_with_ignore_toggle({ default_text = prompt }, no_ignore)
    end)
    return true
  end

  if no_ignore then
    opts.no_ignore = true
    opts.hidden = true
    opts.prompt_title = "Find Files <ALL>"
  else
    opts.prompt_title = "Find Files"
  end
  require("telescope.builtin").find_files(opts)
end

local common_layout = {
  theme = "dropdown",
  layout_config = {
    width = 0.7,
  },
}

return {
  "nvim-telescope/telescope.nvim",

  keys = {
    {
      "<leader>ss",
      function()
        require("plugins.telescope.pickers").prettyDocumentSymbols({ preview = true })
      end,
      desc = "Symbols",
    },
    {
      "<leader>gc",
      function()
        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
      end,
      desc = "Grep word under cursor",
    },
    {
      "<leader>/",
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Live grep with args",
    },
    {
      "<leader> ",
      find_files_with_ignore_toggle,
      desc = "Find files",
    },
  },

  dependencies = {
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
      config = function()
        require("telescope").load_extension("live_grep_args")
      end,
    },
  },

  config = function(_, opts)
    local tele = require("telescope")
    tele.setup(opts)
    tele.load_extension("live_grep_args")
  end,

  opts = function(_, opts)
    local lga_actions = require("telescope-live-grep-args.actions")
    opts.extensions = {
      live_grep_args = vim.tbl_extend("force", common_layout, {
        preview = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-h>"] = lga_actions.quote_prompt({ postfix = " --no-ignore " }),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
            ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
          },
        },
      }),
    }
    opts.pickers = {
      buffers = vim.tbl_extend("force", common_layout, {
        mappings = {
          i = {
            ["<c-d>"] = require("telescope.actions").delete_buffer,
          },
          n = {
            ["d"] = require("telescope.actions").delete_buffer,
          },
        },
      }),
      find_files = common_layout,
      git_files = common_layout,
      lsp_document_symbols = common_layout,
      lsp_definitions = vim.tbl_extend("force", common_layout, {
        preview = true,
      }),
      lsp_references = vim.tbl_extend("force", common_layout, {
        preview = true,
      }),
    }
    opts.defaults = {
      winblend = 10,
      path_display = filenameFirst,
      preview = false,
    }
  end,
}
