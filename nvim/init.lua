-- PLUGIN CONFIGURATION
require('dashboard-conf')
require('lualine-conf')
require('lsp-conf')
require('completions-conf')
require('treesitter-conf')
require('telescope-fb-conf')
require('indent_blankline-conf')
require('nvimtree-conf')

-- EDITOR SETTINGS
local g = vim.g
local o = vim.o

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

o.termguicolors = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Color column
-- o.colorcolumn = '100'

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.relativenumber = true

-- o.cursorline = true

-- Better editing experience
o.expandtab = true
-- o.smarttab = true
o.cindent = true
-- o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1 -- If negative, shiftwidth value is used

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Incremental search
o.incsearch = true
o.hlsearch = false

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

-- vim.cmd("set cmdheight=0")

-- KEYBINDINGS
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

map('n', '<C-b>', ':NvimTreeToggle<CR>')

map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')

map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files)
map('n', '<leader>fg', builtin.live_grep)
map('n', '<leader>fb', ':Telescope file_browser<CR>')
map('n', '<leader>fh', builtin.help_tags)
map('n', '<leader>fr', builtin.oldfiles)

-- LSP keybindings
-- map('n', '<leader>rn', vim.lsp.buf.rename)
-- map('n', '<leader>ca', vim.lsp.buf.code_action)

-- map('n', 'gd', vim.lsp.buf.definition)
-- map('n', 'gi', vim.lsp.buf.implementation)
-- map('n', 'gr', require('telescope.builtin').lsp_references)
-- map('n', 'K', vim.lsp.buf.hover)

-- Indentation configuration
vim.opt.list = true
-- vim.opt.listchars:append 'eol:↴'
vim.opt.listchars:append 'space:·'

-- Plugin setup
require('colorizer').setup()

-- PLUGINS
vim.cmd [[ packadd packer.nvim ]]
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Better status line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    }

    -- File management
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim', 'burntsushi/ripgrep' } },
    }
    use 'nvim-telescope/telescope-file-browser.nvim'

    -- Tpope 
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    }
    use 'simrat39/rust-tools.nvim'

    -- Completions
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
    }
    use 'l3mon4d3/luasnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'rafamadriz/friendly-snippets'

    -- Syntax highlighting
    use ({
        'shaunsingh/nord.nvim',
        as = 'nord',
        config = function()
            vim.cmd('colorscheme nord')
            vim.cmd("highlight WinSeparator guifg=#4c566a")
            vim.cmd("highlight LineNr guifg=#eceff4")
            vim.cmd("highlight LineNrAbove guifg=#616e88")
            vim.cmd("highlight LineNrBelow guifg=#616e88")
        end,
    })
    use ( 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } )

    -- Home screen
    use 'glepnir/dashboard-nvim'

    -- Clipboard
    use 'christoomey/vim-system-copy'

    -- Indentantion
    use 'lukas-reineke/indent-blankline.nvim'
    use 'tpope/vim-sleuth'

    -- Quality of life
    use 'jiangmiao/auto-pairs'
    use 'farmergreg/vim-lastplace'
    use 'norcalli/nvim-colorizer.lua'
end)

