fn = vim.fn
call = vim.call
has = fn.has

Plug = fn['plug#']
stdpath = fn.stdpath

local plug_home

if has("nvim") then
  plug_home = stdpath('data') .. '/plugged'
end

call('plug#begin', plug_home)

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'cohama/lexima.vim'

if has("nvim") then
  Plug('neovim/nvim-lspconfig')
  --Plug('glepnir/lspsaga.nvim')
  -- use this if have some error in glepnir/lspsaga
  Plug('tami5/lspsaga.nvim')
  Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
  Plug('nvim-lua/completion-nvim')
  Plug('nvim-lua/popup.nvim')
  Plug('nvim-lua/plenary.nvim')
  Plug('nvim-telescope/telescope.nvim')
  Plug('kyazdani42/nvim-web-devicons')
  Plug('hoob3rt/lualine.nvim')
end

call('plug#end')
