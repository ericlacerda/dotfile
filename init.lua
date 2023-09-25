vim.o.termguicolors = true
require "paq" {
    "savq/paq-nvim";
    "OmniSharp/omnisharp-vim";
    "preservim/nerdtree";
    "dense-analysis/ale";
    "BurntSushi/ripgrep";
    "nvim-lua/plenary.nvim";
    {"nvim-telescope/telescope.nvim", branch="0.1.x"};
    "mhinz/vim-signify";
    {"neoclide/coc.nvim",·branch="release"};
    "mfussenegger/nvim-dap";
    "rcarriga/nvim-dap-ui";
    "tomasr/molokai";
    "NvChad/nvim-colorizer.lua";
}

local colorizer = require('colorizer').setup()


local wo = vim.wo
local g = vim.g
local opt = vim.opt

wo.number = true -- show line numbers
g.OmniSharp_server_use_net6 = 1
opt.wrap = false -- no text wrap
opt.backup = false -- no annoying backup file
-- everything in utf-8
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.termencoding = "utf-8"

vim.o.clipboard = "unnamedplus"
vim.g.molokai_original = 1
vim.cmd([[
	colorscheme deep_teal_sea
	set listchars=tab:>·,trail:~,extends:>,precedes:<,space:·
	set list
	" 4 spaces indentation
	set tabstop=4 softtabstop=0 expandtab shiftwidth=4

	" Deal with unwanted white spaces (show them in red)
	highlight ExtraWhitespace ctermbg=red guibg=red
	match ExtraWhitespace /\s\+$/
	autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
	autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
	autocmd InsertLeave * match ExtraWhitespace /\s\+$/
	autocmd BufWinLeave * call clearmatches()

" Coc CSS
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
]])

vim.api.nvim_set_keymap('n', 'nt', ':NERDTreeToggle<CR>', {})
vim.api.nvim_set_keymap('n', 'fn', ':Telescope find_files<CR>', {})
vim.api.nvim_set_keymap('n', 'ft', ':Telescope live_grep<CR>', {})
vim.api.nvim_set_keymap('n', 'nc', ':ColorizerReloadAllBuffers<CR>', {})

-- Omnisharp key maps
vim.api.nvim_set_keymap('n', '<F12>', ':OmniSharpGotoDefinition tabedit<CR>', {})
vim.api.nvim_set_keymap('n', '<c-r><c-r>', ':OmniSharpRename<CR>', {})
vim.api.nvim_set_keymap('n', 'action', ':OmniSharpGetCodeActions<CR>', {})
vim.api.nvim_set_keymap('n', '<c-k><c-d>', ':OmniSharpCodeFormat<CR>', {})
vim.api.nvim_set_keymap('n', '<s-F12>', ':OmniSharpFindUsages<CR>', {});
-- Find usages above uses the quickfix window, you can close it by :ccl
-- or go to the next error by :cn or previous by :cp
vim.api.nvim_set_keymap('n', '<F1>', ':OmniSharpDocumentation<CR>', {})
vim.api.nvim_set_keymap('n', '<c-F12>', ':OmniSharpFindImplementations<CR>', {})
vim.api.nvim_set_keymap('n', 'param', ':OmniSharpSignatureHelp<CR>', {})
vim.api.nvim_set_keymap('n', '<c-Down>', ':OmniSharpNavigateDown<CR>', {})
vim.api.nvim_set_keymap('n', '<c-Up>', ':OmniSharpNavigateUp<CR>', {})
vim.api.nvim_set_keymap('n', 'log', ':OmniSharpOpenLog<CR>', {})
vim.api.nvim_set_keymap('n', 'check', ':OmniSharpGlobalCodeCheck<CR>', {})

-- debug config start
local dap = require('dap')

dap.adapters.coreclr = {
  type = 'executable',
  command = 'C:\\Users\\EricL\\netcoredbg\\netcoredbg.exe',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '\\bin\\Debug\\net7.0\\', 'file')
    end,
  },
 {
    type = "coreclr",
    name = "attach  - netcoredbg",
    request = "attach",
    program = function()
      return vim.fn.input('Path to dll', vim.fn.getcwd() .. '\\bin\\Debug\\net7.0\\', 'file')
    end,
  },
}




vim.api.nvim_set_keymap('n', '<F9>', '<cmd>lua require"dap".toggle_breakpoint()<CR>', {})
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', {})
vim.api.nvim_set_keymap('n', '<s-F5>', '<cmd>lua require"dap".terminate()<CR>', {})
vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>', {})
vim.api.nvim_set_keymap('n', '<F8>', '<cmd>lua require"dap".step_into()<CR>', {})
-- NOTE: When you step into a method, it will not open in a new tab, it will go into a new buffer,
-- therefore use Ctrl+6 to switch in between buffers, if you don't want to lose track of where you were before.
-- And if you want to get rid of the other buffer(s) then:
-- 1. List the buffers with :ls
-- 2. grab their id number and then
-- 3. delete them by typing :bw# where # is the id of the buffer you want to wipe out
vim.api.nvim_set_keymap('n', '<s-F11>', '<cmd>lua require"dap".step_out()<CR>', {})
vim.api.nvim_set_keymap('n', 'repl', '<cmd>lua require"dap.repl".toggle()<CR>', {})
-- vim.api.nvim_set_keymap('n', 'repl', '<cmd>lua require"dap".repl.open()<CR>', {})
-- NOTE: IF you are ever stuck working with multiple buffers, then you can do ":tab ball" (yes with b, ball)
-- and it will put all those buffers in their own tab.
-- debug config end

-- debugging UI
local dapui = require("dapui")

dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = false, -- because I'm not using NVIM version 8, I'm using 7.2
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
