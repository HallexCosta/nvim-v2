-- Aliases Vim API {{{
cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
api = vim.api  -- to call Vim API e.g. api.nvim_command [[augroup Format]]
fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
g = vim.g      -- a table to access global variables
s = vim.s      -- a table to access global variables
opt = vim.opt  -- to set options

exists = fn.exists
has = fn.has
cmd = api.nvim_command
runtime = vim.runtime
--}}}

-- Fundamentals {{{
-- init autocmd
cmd [[ autocmd! ]]
-- set script encoding
-- cmd [[ set scriptencoding utf-8 ]]
-- stop loading config if it's on tiny or small
if not 1 then
  return
end

opt.compatible = false
opt.number = true
cmd [[ syntax enable ]]
opt.fileencodings = {'utf-8', 'sjis', 'euc-jp', 'latin'}
opt.encoding = 'utf-8'
opt.title = true
opt.autoindent = true
opt.background = 'dark'
opt.backup = false
opt.hlsearch = true
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 2
opt.scrolloff = 10
opt.expandtab = true

-- let loaded_matchparen = 1
opt.shell = 'fish'
opt.backupskip = {'/tmp/*', '/private/tmp/*'}

-- incremental substitution (neovim)
if has('nvim') then
  opt.inccommand = 'split'
end

-- Suppress appending <PasteStart> and <PasteEnd> when pasting
cmd [[ set t_BE= ]]

opt.sc = false
opt.ru = false
opt.sm = false

-- Do not redraw while executing macros (good performance config)
opt.lazyredraw = true
-- set showmatch

-- How many tenths of a second to blink when matching brackets
-- opt.mat = 2

-- Ignore case when searching
opt.ignorecase = true
-- Be smart when using tabs ;)
opt.smarttab = true

-- indents
opt.tabstop = 4 
opt.shiftwidth = 2
opt.softtabstop= 0 

opt.ai = true -- Auto indent
opt.si = true -- Smart indent
opt.wrap = false -- No Wrap lines
opt.backspace = {'start', 'eol', 'indent'}

-- Finding files - Search down into subfolders
opt.path:append('**')
opt.wildignore:append('*/node_modules/*')

-- Turn off paste mode when leaving insert
cmd [[ autocmd InsertLeave * set nopaste ]]

-- Add asterisks in block comments
-- vim.inspect(vim.opt.formatoptions:get()) -- show formatoptions
opt.formatoptions:append('r')
--}}}

-- Highlights {{{
opt.cursorline = true
-- opt.cursorcolumn = true

-- Set cursor line color on visual mode
cmd [[ highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40 ]]

cmd [[ highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000 ]]

cmd [[ augroup BgHighlight ]]

cmd [[ autocmd! ]]
cmd [[ autocmd WinEnter * set cul ]]
cmd [[ autocmd WinLeave * set nocul ]]

cmd [[ augroup END ]]

local term = os.getenv('TERM')

if term ~= 'screen' then
  cmd [[
    autocmd bufenter * if bufname("") !~ "^?[a-za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $pwd`/`basename %`]\e\\"' | endif
  ]]
  cmd [[
    autocmd vimleave * silent!  exe '!echo -n "\ek[`hostname`:`basename $pwd`]\e\\"'
  ]]
end

--}}}

-- File types {{{
---------------------------------------------------------------------
-- JavaScript
cmd [[ au BufNewFile,BufRead *.es6 setf javascript ]]
-- TypeScript
cmd [[ au BufNewFile,BufRead *.tsx setf typescriptreact ]]
-- Markdown
cmd [[ au BufNewFile,BufRead *.md set filetype=markdown ]]
-- Flow
cmd [[ au BufNewFile,BufRead *.flow set filetype=javascript ]]

opt.suffixesadd = { '.js', '.es', '.jsx', '.json', '.css', '.less', '.sass', '.styl', '.php', '.py', '.md'}

cmd [[ autocmd FileType coffee setlocal shiftwidth=2 tabstop=4 ]]
cmd [[ autocmd FileType ruby setlocal shiftwidth=2 tabstop=4 ]]
cmd [[ autocmd FileType yaml setlocal shiftwidth=2 tabstop=4 ]]
cmd [[ filetype plugin indent on ]]
--}}}

-- Imports {{{
-- load plugs
cmd [[ runtime ./plug.lua ]]

if has('unix') then
  local uname = fn.system("uname -s") 

  -- Do Mac stuff
  if uname == 'Darwin\n' then
    cmd [[ runtime ./macos.vim ]]
  end
end

cmd [[ runtime ./maps.vim ]]
--}}}

-- Syntax theme (true color) {{{
if exists("&termguicolors") and exists("&winblend") then
  opt.syntax = 'enable'
  opt.termguicolors = true
  opt.winblend = 0
  opt.wildoptions = 'pum'
  opt.pumblend = 5
  opt.background='dark'
  
  -- Use NeoSolarized
  g.neosolarized_termtrans = 1
  cmd [[ runtime ./colors/NeoSolarized.vim]]
  cmd 'colorscheme NeoSolarized'
end
--}}}

-- Extras {{{
opt.exrc = true
--}}}

-- vim: set foldmethod=marker foldlevel=0:
