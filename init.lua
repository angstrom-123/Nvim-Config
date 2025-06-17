-- Created by angstrom

local PATH = '~/.local/share/nvim/plugged'
local Plug = vim.fn['plug#']
local g = vim.g
local wo = vim.wo
local opt = vim.opt

vim.call('plug#begin')
Plug 'ellisonleao/gruvbox.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
vim.call('plug#end')

-- Configure colour scheme
vim.o.background = 'dark'
require('gruvbox').setup({
	invert_selection = true,
	bold = true,
	italic = {
		strings = false,
		emphasis = false,
		comments = false,
		operators = false,
		folds = false,
	},
})
vim.cmd('colorscheme gruvbox')

-- Configure auto-complete
local cmp = require('cmp')
cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn['vsnip#anonymous'](args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered({
			border = 'double',
		}),
		documentation = cmp.config.window.bordered({
			border = 'double',
		}),
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({
			select = true
		}),
		['<Tab>'] = cmp.mapping.confirm({
			select = true
		}),
	}),
	sources = cmp.config.sources({
		{name = 'nvim_lsp'},
		{name = 'buffer'},
		{name = 'vsnip'},
	}),
})

-- configure c / c++ lsp 
local lspconfig = require('lspconfig')
lspconfig.clangd.setup({
	on_attach = on_attach,
	cmd = {'clangd-18', '--background-index'},
})

-- Configure telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action({apply=true}) end, bufopts)
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'Telescope find files'})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = 'Telescope live grep'})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = 'Telescope buffers'})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = 'Telescope help tags'})
vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, {desc = 'Telescope goto declaration'})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {desc = 'Telescope goto definition'})
vim.keymap.set('n', 'gi', builtin.lsp_implementations, {desc = 'Telescope goto implementation'})
vim.keymap.set('n', 'gr', builtin.lsp_references, {desc = 'Telescope goto references'})
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {noremap=true, silent=true});
vim.keymap.set('n', 'm', function() vim.lsp.buf.hover({border = 'double', max_height = 25, max_width = 120}) end, bufopts);

-- Configure nvim
vim.diagnostic.config({
	virtual_text = true,
})
wo.relativenumber = true
wo.number = true
wo.cursorline = true
opt.guicursor = ''
opt.colorcolumn = {'80', '100'}
opt.autoindent = true
opt.smartindent = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.history = 5000
opt.mouse = a
