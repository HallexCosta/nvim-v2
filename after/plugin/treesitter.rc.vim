if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua <<EOF
require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  ident = {
    enable = false,
    disable = {}
  },
  indent = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "html",
    "scss"
  }
}
EOF
