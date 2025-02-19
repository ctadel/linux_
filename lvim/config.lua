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
vim.diagnostic.config({ virtual_text = false })

--basic settings
vim.opt.backup = false -- creates a backup file
-- vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.clipboard = "unnamed"
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
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true -- display lines as one long line


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.keys.normal_mode["<C-d>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<C-a>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-w>"] = ":bd<cr>"

lvim.keys.insert_mode["<C-BS>"] = "<C-w>"

-- lvim.keys.command_mode["jk"] = "<C-c>"
-- lvim.keys.command_mode["JK"] = "<C-c>"
lvim.keys.normal_mode["<C-l>"] = ":noh<cr>"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"


vim.api.nvim_exec([[
  silent! nunmap ]q
]], false)
vim.api.nvim_exec([[
  silent! nunmap [q
]], false)

lvim.keys.normal_mode["["] = "10k"
lvim.keys.normal_mode["]"] = "10j"

lvim.keys.normal_mode["n"] = "nzz"
lvim.keys.normal_mode["N"] = "Nzz"

lvim.keys.visual_mode['Y'] = '"+y'

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

-- lvim.keys.normal_mode['q:'] = ""


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
lvim.builtin.treesitter.highlight.additional_vim_regex_highlighting = true

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
        vim.g.gitblame_enabled = 1
        vim.g.gitblame_date_format = '%r'
        vim.g.gitblame_message_when_not_committed = '  🤷 Oh man!! gotta commit this now...'
        vim.g.gitblame_delay = 300
      end,
    },
  {"theHamsta/nvim-dap-virtual-text"},
  {"ntpeters/vim-better-whitespace"},
  {"AckslD/nvim-neoclip.lua"},
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "github/copilot.vim",
}


require("telescope").load_extension "file_browser"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults={
  mappings = {
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
  },
  file_ignore_patterns = {"*.pyc"},
  layout_strategy = "horizontal",
  sorting_strategy = "descending",
  layout_config = {
    -- mirror=true,
    width = 0.8, -- Adjust the width value as needed
    height = 0.8, -- Adjust the height value as needed
    preview_cutoff = 40, -- Adjust the preview cutoff value as needed
    horizontal = {
      width_padding = 0.3, -- Adjust the width padding value as needed
      height_padding = 0.2, -- Adjust the height padding value as needed
      preview_width = 0.6, -- Adjust the preview width value as needed
    },
  },
}
lvim.builtin.telescope.theme='ivy'


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
-- lvim.keys.insert_mode["jk"] = "<Esc>:lua is_at_end()<CR>"
-- lvim.keys.insert_mode["JK"] = "<Esc>:lua is_at_end()<CR>"
-- lvim.keys.insert_mode["kj"] = "<Esc>:lua is_at_end()<CR>"
-- lvim.keys.insert_mode["KJ"] = "<Esc>:lua is_at_end()<CR>"


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


-- Function to copy the text with colors
vim.api.nvim_create_user_command('RichCopy', function (args)
  local saved_html_use_css = vim.g.html_use_css
  local saved_html_no_progress = vim.g.html_no_progress
  vim.g.html_use_css = false
  vim.g.html_no_progress = true

  vim.cmd {
    cmd = 'TOhtml',
    range = { args.line1, args.line2 },
  }
  vim.g.html_use_css = saved_html_use_css
  vim.g.html_no_progress = saved_html_no_progress

  vim.cmd([[%s/^\s*[^ ]*\.html\s*//e]])
  vim.cmd 'w !xclip -selection clipboard -t text/html -i'
  vim.cmd.bwipeout { bang = true }

end, {
 range = '%',
})

-- lvim.keys.visual_mode['Y'] = {':RichCopy<CR>', noremap = true, silent=true}

local function format_sql()
  -- Save the current buffer content to a temporary file
  local tmpfile = vim.fn.tempname() .. '.sql'
  vim.cmd('write ' .. tmpfile)

  -- Run the sqlformat command on the temporary file
  local cmd = 'sqlformat -i lower -k upper -r ' .. tmpfile
  local formatted_sql = vim.fn.system(cmd)

  -- Replace the buffer content with the formatted SQL
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(formatted_sql, '\n'))

  -- Delete the temporary file
  vim.fn.delete(tmpfile)
end

-- Create a command to call the format_sql function
vim.api.nvim_create_user_command('FormatSQL', format_sql, {})

function GoTo_DAP_Repl_window()
  local repetitions = 10  -- Number of times to repeat the commands

  for _ = 1, repetitions do
    vim.cmd('wincmd j')  -- Move to the window below the current one
    vim.cmd('wincmd h')  -- Move to the window on the left side
  end
  -- vim.cmd('startinsert')
end

function GoTo_DAP_Code_window()
  local repetitions = 10  -- Number of times to repeat the commands

  for _ = 1, repetitions do
    vim.cmd('wincmd k')  -- Move to the window below the current one
    vim.cmd('wincmd h')  -- Move to the window on the left side
  end
end

function DAP_clear_repl_window()
  GoTo_DAP_Repl_window()
  vim.api.nvim_feedkeys('aaS.clear\', 'n', true)
end

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python").configurations({
    justMyCode = false,
  })
end)

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "python",
}

lvim.keys.normal_mode["B"] = "<cmd>lua require('dap').toggle_breakpoint()<CR>"
lvim.builtin.which_key.mappings['B'] = {"<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint"}
lvim.builtin.which_key.mappings['n'] = {"<cmd>lua require('dap').step_over()<CR>", "DAP - Step Over"}
lvim.builtin.which_key.mappings['u'] = {"<cmd>lua require('dap').step_out()<CR>", "DAP - Step Out"}
lvim.builtin.which_key.mappings['s'] = {"<cmd>lua require('dap').step_into()<CR>", "DAP - Step Into"}
lvim.builtin.which_key.mappings['c'] = {"<cmd>lua require('dap').continue()<CR>", "DAP - Continue"}
lvim.builtin.which_key.mappings['dr'] = {"<cmd>lua GoTo_DAP_Repl_window()<CR>a", "DAP - Jump to Repl window"}
lvim.builtin.which_key.mappings['dR'] = {'<cmd>lua DAP_clear_repl_window()<CR>', "DAP - Jump to Repl window"}
lvim.builtin.which_key.mappings['dm'] = {"<cmd>lua GoTo_DAP_Code_window()<CR>", "DAP - Jump to Main window"}

lvim.builtin.which_key.mappings["dT"] = { "O__import__('ipdb').set_trace()<esc>j0w<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Add a legacy breakpoint" }

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}


-- Disable copilot (very expensive tokens)
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.cmd("Copilot disable")
    end,
})
