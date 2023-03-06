-- ################################################ --
-- ##          __              .___     .__      ## --
-- ##    _____/  |______     __| _/____ |  |     ## --
-- ##  _/ ___\   __\__  \   / __ |/ __ \|  |     ## --
-- ##  \  \___|  |  / __ \_/ /_/ \  ___/|  |__   ## --
-- ##   \___  >__| (____  /\____ |\___  >____/   ## --
-- ##       \/          \/      \/    \/         ## --
-- ################################################ --
lvim.leader = "space"
-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "lunar"
lvim.lsp.diagnostics.virtual_text = false

--basic settings
vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.showmode = true -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - vim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.cursorline = false -- highlight the current line
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true -- display lines as one long line


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.keys.normal_mode["<C-d>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-a>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-w>"] = ":bd<cr>"

lvim.keys.insert_mode[""] = "<C-w>"

lvim.keys.command_mode["jk"] = "<C-c>"
lvim.keys.normal_mode["<C-l>"] = ":noh<cr>"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"

lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.normal_mode["N"] = "Nzz"

-- Move the selected lines up/down with J and K respectively.
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

-- Better tabbing
lvim.keys.normal_mode['<'] = "<<"
lvim.keys.normal_mode['>'] = ">>"


-- Window navigation
lvim.keys.normal_mode['  a'] = ":wincmd h<CR>"
lvim.keys.normal_mode['  d'] = ":wincmd l<CR>"
lvim.keys.normal_mode['  w'] = ":wincmd k<CR>"
lvim.keys.normal_mode['  s'] = ":wincmd j<CR>"


-- Commenting codeblocks
-- lvim.keys.normal_mode[''] = ":norm gcc<CR>"
-- lvim.keys.visual_mode[''] = ":'<,'>norm gcc<CR>"
-- lvim.keys.visual_block_mode[''] = ":norm gc<cr>"



-- Treesitter
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = { "bash", "c", "javascript", "json", "lua", "python", "typescript", "tsx", "css", "rust", "java", "yaml", }

-- Additional Plugins
lvim.plugins = {
    { "nvim-telescope/telescope-file-browser.nvim" },
    {
      "f-person/git-blame.nvim",
      event = "BufRead",
      config = function()
        vim.cmd "highlight default link gitblame SpecialComment"
        vim.g.gitblame_enabled = 0
        vim.g.gitblame_date_format = '%r'
        vim.g.gitblame_message_when_not_committed = 'Oh shit! gotta commit this now...'
      end,
    },
    {
      "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
          require("persistence").setup {
            dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
            options = { "buffers", "curdir", "tabpages", "winsize" },
          }
      end,
  },
  {"theHamsta/nvim-dap-virtual-text"},
  {"ntpeters/vim-better-whitespace"},
  {
    "AckslD/nvim-neoclip.lua"},
    requires = {
      {'kkharji/sqlite.lua', module = 'sqlite'},
      {'nvim-telescope/telescope.nvim'},
    },
    config = function()
      require('neoclip').setup()
    end,

  {
    "jackMort/ChatGPT.nvim",
      config = function()
        require("chatgpt").setup({
          -- optional configuration
        })
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      }
  }
}


require("telescope").load_extension "file_browser"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
    ["<C-Space>"] = actions.close,
    [""] = actions.close,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}


vim.api.nvim_set_keymap( "n", "<C-Space>", ":lua require'telescope'.extensions.file_browser.file_browser({depth=false})<CR>", { noremap = true })
vim.api.nvim_set_keymap( "n", "", ":Telescope git_status<CR>", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-p>", ":Telescope projects<cr>", { noremap = true })
vim.api.nvim_set_keymap( "n", "<C-g>", ":Telescope live_grep theme=ivy<cr>", { noremap = true })

vim.g.better_whitespace_guicolor='Maroon'

-- Function to fix escape behaviour to set the cursor back at the original
-- position where it should be (i.e one step to the right)
function _G.is_at_end()
  local len_line = #vim.api.nvim_get_current_line()
  local _, column = unpack(vim.api.nvim_win_get_cursor(0))
  column = column + 1
  if len_line == 0 or len_line == column then
    vim.api.nvim_feedkeys('','n',false)
  else
    vim.api.nvim_feedkeys('l','n',false)
  end
end

lvim.keys.insert_mode["<Esc>"] = "<Esc>:lua is_at_end()<CR>"
lvim.keys.insert_mode["jk"] = "<Esc>:lua is_at_end()<CR>"


-- Function to execute the current file in the buffer based on the file type
-- TO FIX: not able to auto execute the command sent to the command mode
function _G.run_current_file()

  local filename = vim.api.nvim_buf_get_name(0)
  local _, file_extension = string.match(filename, "(.-)%.([^%.]+)$")

  if file_extension == 'py' then
    vim.api.nvim_feedkeys(':TermExec cmd="python %"','n',false)

  elseif file_extension == 'html' then
    vim.api.nvim_feedkeys(':!google-chrome "%"','n',false)

  elseif file_extension == 'sh' or file_extension == 'bash' then
    vim.api.nvim_feedkeys(':TermExec cmd="bash %"','n',false)

  else
    print("ERROR: Couldn't execute current file (Unsupported file type)")

  end

end

lvim.keys.normal_mode["<F5>"] = "<Esc>:lua run_current_file()<CR>"

