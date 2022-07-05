set nocompatible

let g:python3_host_prog="/home/josh/miniconda3/bin/python3"
let g:autoformat_verbosemode=1

"" Autoformat on save
"" au BufWrite * :Autoformat

"" Autocompletion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

"" Use Ctrl+p to open fuzzy search
"" nnoremap <silent> <C-p> :FZF<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
"" nnoremap <silent> <leader>F :FZF ~<cr>


"" Show line numbers
"" set number
set relativenumber

"" Allow mouse to move cursor
set mouse=a

call plug#begin()

" Core (treesitter, nvim-lspconfig, nvim-cmp, nvim-telescope, nvim-lualine)
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Functionalities
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'mhinz/vim-signify'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-abolish'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'Yggdroot/indentLine'
Plug 'chrisbra/Colorizer'
Plug 'KabbAmine/vCoolor.vim'
Plug 'dkarter/bullets.vim'
Plug 'wellle/context.vim'
Plug 'antoinemadec/FixCursorHold.nvim'

" Functionalities - Python
Plug 'heavenshell/vim-pydocstring'

" Aesthetics - Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'zaki/zazen'
Plug 'yuttie/hydrangea-vim'

" Aesthetics - Others
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-journal'

"" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'

"" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }

"" Linting and autoformat
Plug 'dense-analysis/ale'
Plug 'vim-autoformat/vim-autoformat'

"" Fuzzy search plugin
"" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }


"" Git support
Plug 'airblade/vim-gitgutter'

"" Plug 'posva/vim-vue'

"" Plug 'neovim/node-host', { 'do': 'npm install' }
"" Plug 'billyvg/tigris.nvim', { 'do': './install.sh' }

call plug#end()

"" Enable gruvbox color scheme
autocmd vimenter * ++nested colorscheme gruvbox

"" CoC extensions
let g:coc_global_extensions = ['coc-tsserver']

""" Core plugin configuration (vim)

" Treesitter
augroup DraculaTreesitterSourcingFix
    autocmd!
    autocmd ColorScheme dracula runtime after/plugin/dracula.vim
    syntax on
augroup end

" nvim-cmp
set completeopt=menu,menuone,noselect

" signify
let g:signify_sign_add = '│'
let g:signify_sign_delete = '│'
let g:signify_sign_change = '│'
hi DiffDelete guifg=#ff5555 guibg=none

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'NonText'
" Disable indentLine from concealing json and markdown syntax (e.g. ```)
let g:vim_json_syntax_conceal = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" FixCursorHold for better performance
let g:cursorhold_updatetime = 100

" context.vim
let g:context_nvim_no_redraw = 1

" Neovim :Terminal
tmap <Esc> <C-\><C-n>
tmap <C-w> <Esc><C-w>
"tmap <C-d> <Esc>:q<CR>
autocmd BufWinEnter,WinEnter term://* startinsert
autocmd BufLeave term://* stopinsert

" Python
let g:python3_host_prog = '~/.config/nvim/env/bin/python3'
let g:pydocstring_doq_path = '~/.config/nvim/env/bin/doq'

""" Core plugin configuration (lua)
lua << EOF
servers = {
    'pyright',
		'tsserver',
		--'tsserver', -- uncomment for typescript. See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md for other language servers
}
require('treesitter-config')
require('nvim-cmp-config')
require('lspconfig-config')
require('telescope-config')
require('lualine-config')
require('nvim-tree').setup()
require('nvim-tree-config')
require('diagnostics')
EOF

""" Custom Functions

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

""" Custom Mappings (vim) (lua custom mappings are within individual lua config files)

" Core
let mapleader=","
nmap <leader>q :NvimTreeFindFileToggle<CR>
nmap \ <leader>q
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>t :call TrimWhitespace()<CR>
xmap <leader>a gaip*
nmap <leader>a gaip*
nmap <leader>h :RainbowParentheses!!<CR>
nmap <leader>j :set filetype=journal<CR>
nmap <leader>k :ColorToggle<CR>
nmap <leader>l :Limelight!!<CR>
xmap <leader>l :Limelight!!<CR>
nmap <silent> <leader><leader> :noh<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
nmap <leader>$s <C-w>s<C-w>j:terminal<CR>:set nonumber<CR><S-a>
nmap <leader>$v <C-w>v<C-w>l:terminal<CR>:set nonumber<CR><S-a>

" Python
autocmd Filetype python nmap <leader>d <Plug>(pydocstring)
autocmd FileType python nmap <leader>p :Black<CR>

" Solidity (requires: npm install --save-dev prettier prettier-plugin-solidity)
autocmd Filetype solidity nmap <leader>p :0,$!npx prettier %<CR>

" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fc <cmd>Telescope colorscheme<cr>
nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find<cr>
