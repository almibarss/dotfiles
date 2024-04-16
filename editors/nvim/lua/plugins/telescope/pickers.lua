-- https://github.com/nvim-telescope/telescope.nvim/issues/2014#issuecomment-1541423345
local telescopePickers = {}
local telescopeMakeEntryModule = require("telescope.make_entry")
local telescopeEntryDisplayModule = require("telescope.pickers.entry_display")
local plenaryStrings = require("plenary.strings")
local devIcons = require("nvim-web-devicons")
local fileTypeIconWidth = plenaryStrings.strdisplaywidth(devIcons.get_icon("fname", { default = true }))

local kind_icons = {
  Text = "",
  String = "",
  Array = "",
  Object = "󰅩",
  Namespace = "",
  Method = "m",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "󰫧",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Copilot = "🤖",
  Boolean = "",
}

function telescopePickers.prettyDocumentSymbols(localOptions)
  if localOptions ~= nil and type(localOptions) ~= "table" then
    print("Options must be a table.")
    return
  end

  options = localOptions or {}

  local originalEntryMaker = telescopeMakeEntryModule.gen_from_lsp_symbols(options)

  options.entry_maker = function(line)
    local originalEntryTable = originalEntryMaker(line)

    local displayer = telescopeEntryDisplayModule.create({
      separator = " ",
      items = {
        { width = fileTypeIconWidth },
        { width = 20 },
        { remaining = true },
      },
    })

    originalEntryTable.display = function(entry)
      return displayer({
        string.format("%s", kind_icons[(entry.symbol_type:lower():gsub("^%l", string.upper))]),
        { entry.symbol_type:lower(), "TelescopeResultsVariable" },
        { entry.symbol_name, "TelescopeResultsConstant" },
      })
    end

    return originalEntryTable
  end

  require("telescope.builtin").lsp_document_symbols(options)
end

return telescopePickers
