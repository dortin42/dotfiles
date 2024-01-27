-- Initial settings
-- Ignore compiled files
vim.o.wildignore = '*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*,*~'

-- Stop acting like classic vi
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.o.history = 777 -- increase history size
vim.o.mouse = "a"   -- Activate the mouse
-- vim.o.synmaxcol = 200 -- Some times the line is too long, is good idea disable color syntax
-- ^ thats not a problem with treesitter
vim.o.splitbelow = true -- change split direction
vim.o.splitright = true
vim.g.mapleader = ","

-- Modify indenting settings
vim.o.autoindent = true       -- autoindent always ON.
vim.o.expandtab = true        -- expand tabs
vim.o.shiftwidth = 4          -- spaces for autoindenting
vim.o.softtabstop = 4         -- remove a full pseudo-TAB when i press <BS>
vim.cmd('syntax on')          -- Enable syntax highlighting
vim.cmd('filetype on')        -- Enable filetype detection
vim.cmd('filetype indent on') -- Enable filetype-specific indenting
vim.cmd('filetype plugin on') -- Enable filetype-specific plugins

-- Some programming languages work better when only 2 spaces padding is used.
vim.cmd('autocmd FileType html,css,sass,scss,javascript setlocal sw=2 sts=2')
vim.cmd('autocmd FileType json setlocal sw=2 sts=2')
vim.cmd('autocmd FileType ruby,eruby setlocal sw=2 sts=2')
vim.cmd('autocmd FileType yaml setlocal sw=2 sts=2')
vim.cmd('autocmd FileType markdown setlocal wrap')

-- Modify some other settings about files
vim.o.encoding = "utf-8"             -- always use unicode (god damnit, windows)
vim.o.backspace = "indent,eol,start" -- backspace always works on insert mode
vim.o.iskeyword = "@"                -- Instant search
vim.o.hidden = true

-- Turn backup off, since most stuff is in SVN, git etc. anyway...
vim.o.backup = false
vim.o.swapfile = false

vim.o.showmode = false       -- always show which mode are we in
vim.o.laststatus = 2         -- always show statusbar
vim.o.wildmenu = true        -- enable visual wildmenu

vim.wo.wrap = false          -- don't wrap long lines
vim.wo.number = true         -- show line numbers
vim.wo.relativenumber = true -- show numbers as relative by default
vim.o.showmatch = true       -- higlight matching parentheses and brackets

-- Turn persistent undo on
-- means that you can undo even when you close a buffer/VIM
local ok, err = pcall(function()
    local home = os.getenv("HOME")
    vim.opt.undodir = string.format("%s/.local/share/nvim/undo/", home)
    vim.opt.undofile = true
    vim.opt.undolevels = 777
    vim.opt.undoreload = 10000
end)

if not ok then
    print("Failed to set undo settings: ", err)
end

-- Terminal settings
-- Are we supporting colors?
if tonumber(vim.o.t_Co) > 2 then
    vim.cmd('syntax on')
    vim.wo.colorcolumn = "80"
    vim.cmd('silent! color gruvbox')
    vim.o.background = "dark"
end

-- Extra fancyness if full pallete is supported.
if tonumber(vim.o.t_Co) >= 256 then
    vim.o.termguicolors = true
    vim.wo.cursorline = true
    vim.wo.cursorcolumn = true
end

-- Mark trailing spaces depending on whether we have a fancy terminal or not
if tonumber(vim.o.t_Co) > 2 then
    vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
    vim.cmd('match ExtraWhitespace /\\s\\+$/')
else
    vim.o.listchars = "trail:$"
    vim.wo.list = true
end

-- Package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
    -- General purpose plugins
    -- 'gioele/vim-autoswap' -- Please Vim, stop with these swap file messages. Just switch to the correct window!
    { 'github/copilot.vim' },
    {
        'mg979/vim-visual-multi',
        branch = 'master',
        config = function()
            -- Mapping for multiple-cursors
            vim.g.VM_maps = {
                ["Find Under"] = '<C-d>', -- replace C-n
                ["Find Subword Under"] = '<C-d>'
            }
        end
    },                        -- Multiple cursors with selection and ctrl + d
    { 'tpope/vim-surround' }, -- Puts ({[ etc with yss csW on normal mode, in visual mode S
    { 'tpope/vim-repeat' },   -- Repeat surround and other cmd plugins with .
    { 'tpope/vim-eunuch' },   -- Better cmd for Vim
    { 'tpope/vim-dispatch' }, -- background subprocess
    { 'tpope/vim-fugitive' }, -- Vim + Git = <3
    { 'tpope/vim-abolish' },  -- Better substitutions :%Subvert/facilit{y,ies}/building{,s}/g and toggle cases:
    -- MixedCase (crm),
    -- camelCase (crc),
    -- snake_case (crs),
    -- UPPER_CASE (cru),
    -- dash-case (cr-),
    -- dot.case (cr.),
    -- space case (cr<space>),
    -- Title Case (crt)
    -- {
    --     "chrisgrieser/nvim-spider",
    --     config = function()
    --         vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
    --         -- vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
    --         vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
    --         vim.keymap.set({ "n", "o", "x" }, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })
    --     end
    -- },
    {
        'abecodes/tabout.nvim',
        config = function()
            require('tabout').setup()
        end
    },
    {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require 'colorizer'.setup({
                user_default_options = {
                    tailwind = true
                }
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        cmd = 'Telescope',
        dependencies = {
            {
                'nvim-lua/plenary.nvim',
                "debugloop/telescope-undo.nvim"
            },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    undo = {
                        use_delta = true,
                        use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
                        side_by_side = false,
                        diff_context_lines = vim.o.scrolloff,
                        entry_format = "state #$ID, $STAT, $TIME",
                        time_format = "",
                        mappings = {
                            i = {
                                -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                                -- you want to replicate these defaults and use the following actions. This means
                                -- installing as a dependency of telescope in it's `requirements` and loading this
                                -- extension from there instead of having the separate plugin definition as outlined
                                -- above.
                                ["<cr>"] = require("telescope-undo.actions").restore,
                            }
                        }
                    }
                },
            })
            require("telescope").load_extension("undo")
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter", -- The main reason Im using neovim
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },
    { 'lewis6991/gitsigns.nvim' }, -- git hunks on numbers panel
    { 'mattn/emmet-vim' },         -- Emmet Ctrl + b + , in normal or insert mode
    {
        'nvim-tree/nvim-tree.lua'
    },
    {
        'yegappan/greplace',         -- Use :Gsearch and :Greplace for search and replace in files
    },
    { 'nvim-lualine/lualine.nvim' }, -- Status line
    { 'akinsho/bufferline.nvim' },   -- Tabline
    -- 'chentoast/marks.nvim' -- Show m's on numbers panel
    { 'jghauser/mkdir.nvim' },
    { 'windwp/nvim-autopairs' }, -- Autoclose ',(,{,[
    { 'roxma/nvim-yarp' },
    { 'matze/vim-move' },        -- Move a line or selection with Alt + j/k
    {
        'Shougo/vimproc.vim',    -- TS compiler with :make
        run = 'make'
    },
    -- 'roxma/python-support.nvim' -- auto pip install with :PythonSupportInitPython3 (not working right now)
    {
        'FooSoft/vim-argwrap', -- wrap and unwrap hashes and arrays with ,a
    },
    {
        'AndrewRadev/splitjoin.vim', -- wrap code statements gS and gJ
        lazy = true,
        keys = {
            { "gJ", "gS", desc = "Wrap code" },
        }
    },
    -- {'unblevable/quick-scope', -- magic with f}, -- 'ggandor/lightspeed.nvim'  -- magic with s
    { 'AndrewRadev/switch.vim' }, -- Switch and toggle a lot of things, see the wiki

    -- Language support
    {
        'tpope/vim-rails' -- Vim Rails productivity (I strongly recommend read the wiki)
    },
    {
        'ray-x/guihua.lua',
        build = 'cd lua/fzy && make'
    },
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            {
                'williamboman/mason.nvim',
                build = ":MasonUpdate", -- :MasonUpdate updates registry contents
                config = function()
                    require("mason").setup()
                end
            },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            {
                'j-hui/fidget.nvim',
                tag = 'legacy',
                opts = {}
            },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
            {
                'dnlhc/glance.nvim', -- :Glance [[opts]] checks places where function is used
                config = function()
                    require('glance').setup({})
                end
            },
            {
                "ThePrimeagen/refactoring.nvim",
                config = function()
                    require("refactoring").setup()
                end,
            } -- :Refactor [[opts]] Extract and refactor code
        },
    },
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'ray-x/navigator.lua',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            require('luasnip.loaders.from_vscode').lazy_load()
            luasnip.config.setup {}

            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    }),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                })
            })
        end
    },
    {
        'sudormrfbin/cheatsheet.nvim',
        dependencies = {
            { 'nvim-telescope/telescope.nvim' },
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        }
    },
    { 'sheerun/vim-polyglot' }, -- text highlight
    { 'wellle/targets.vim' },   -- Better text object handling
    -- 'lifepillar/pgsql.vim' -- PSQL
    -- 'jalvesaq/Nvim-R', {'branch': 'stable'} -- R
    -- 'fatih/vim-go' -- GO (read the wiki PLS)

    -- Colorschemes
    {
        -- 'morhetz/gruvbox'
        -- 'dortin42/golden-vim'
        -- 'RRethy/nvim-base16', base16-gruvbox-dark-pale
        'ellisonleao/gruvbox.nvim',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end
    }
})

-- Plugin dependent settings
vim.cmd([[
  autocmd FileType erb let b:surround_45 = "<% \r %>" " Key -
  autocmd FileType erb let b:surround_61 = "<%= \r %>" " Key =
  autocmd FileType rb let b:surround_61 = "#{\r}" " Key =
]])

vim.cmd([[
  au FileType markdown set conceallevel=0
]])

vim.g.python_support_python2_require = 0

require('gitsigns').setup()
require("nvim-tree").setup({
    renderer = {
        icons = {
            webdev_colors = false,
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = true,
                modified = false,
            },
            glyphs = {
                git = {
                    unstaged = "X",
                    staged = "S",
                    unmerged = "UM",
                    renamed = "M",
                    untracked = "U",
                    deleted = "D",
                    ignored = "I",
                }
            }
        }
    }
})
require('nvim-treesitter.configs').setup {
    highlight = { enable = true },
    indent = { enable = false },
    autotag = { enable = true }
}
local npairs = require("nvim-autopairs")

npairs.setup({
    check_ts = true,
    ts_config = {
        lua = { 'string' }, -- it will not add a pair on that treesitter node
        javascript = { 'template_string' },
        java = false,       -- don't check treesitter on java
    }
})

local ts_conds = require('nvim-autopairs.ts-conds')
npairs.add_rules(require('nvim-autopairs.rules.endwise-elixir'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
npairs.add_rules(require('nvim-autopairs.rules.endwise-ruby'))
vim.cmd("autocmd FileType guihua lua require('cmp').setup.buffer { enabled = false }")
vim.cmd("autocmd FileType guihua_rust lua require('cmp').setup.buffer { enabled = false }")

require('bufferline').setup {
    options = {
        numbers = function(opts)
            return string.format('%s', opts.id)
        end,
        diagnostics = false,
        indicator_icon = '',
        separator_style = 'thin',
        always_show_bufferline = false,
        show_buffer_icons = false,
        show_buffer_close_icons = false,
        show_close_icon = false
    }
}
-- require('marks').setup({
-- default_mappings = true
-- })
require 'navigator'.setup()
require('lualine').setup({
    options = {
        icons_enabled = false,
        theme = 'gruvbox-material',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'filename', path = 1 } },
        lualine_c = {},
        lualine_x = { 'branch', 'diff' },
        lualine_y = { 'encoding' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = { 'filename' },
        lualine_c = {},
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    extensions = { 'fugitive' },
})

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end
}

-- Key remaps
-- Find files
vim.api.nvim_set_keymap('n', '<C-t>', ':Telescope find_files<CR>', { noremap = true })

-- Insert a space in normal mode
vim.api.nvim_set_keymap('n', '<space>', 'i<space><esc>', { noremap = true })

-- Insert an Enter in normal mode
vim.api.nvim_set_keymap('n', '<A-+>', 'i<CR><esc>h', { noremap = true })
vim.api.nvim_set_keymap('n', '+', '0i<CR><esc>h', { noremap = true })

-- Find word under cursor
vim.api.nvim_set_keymap('n', '#', 'gd', { noremap = true })

-- Make window navigation less painful.
vim.api.nvim_set_keymap('n', '<BS>', '<C-W>h', {})
vim.api.nvim_set_keymap('', '<C-h>', '<C-w>h', {})
vim.api.nvim_set_keymap('', '<C-j>', '<C-w>j', {})
vim.api.nvim_set_keymap('', '<C-k>', '<C-w>k', {})
vim.api.nvim_set_keymap('', '<C-l>', '<C-w>l', {})
vim.api.nvim_set_keymap('n', '<C-q>', '<C-^>', { noremap = true })

-- Working with buffers is cool.
vim.api.nvim_set_keymap('n', '<C-n>', ':BufferLineCycleNext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':BufferLineCyclePrev<CR>', { noremap = true })

-- These commands will move the current buffer backwards or forwards in the bufferline
vim.api.nvim_set_keymap('n', '<A-n>', ':BufferLineMoveNext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<A-p>', ':BufferLineMovePrev<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<C-f>', ':bfirst<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-g>', ':blast<CR>', { noremap = true })

-- Working with tabs is cool.
vim.api.nvim_set_keymap('n', '<Leader>l', ':tablast<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':tabfirst<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>n', ':tabNext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>p', ':tabprevious<CR>', { noremap = true })

-- Copy/paste from system clipboard
vim.api.nvim_set_keymap('n', 'Y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', 'Y', '"+y', { noremap = true })

-- Copy WSL
vim.cmd([[
  let s:clip = '/mnt/c/Windows/System32/clip.exe'
  if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.regname=='+' | call system('echo '.shellescape(join(v:event.regcontents)).' | '.s:clip) | endif
    augroup END
  endif
]])

-- Force update file
vim.api.nvim_set_keymap('n', '<F5>', ':e!<CR>', {})

-- Relative numbering
vim.api.nvim_set_keymap('n', '<F6>', ':set invrelativenumber<CR>', {})
vim.api.nvim_set_keymap('i', '<F6><esc>', ':set invrelativenumber<CR>a', {})

-- NvimTree
vim.api.nvim_set_keymap('n', '<f2>', ':NvimTreeToggle<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>r', ':NvimTreeFindFile<CR>', {})

-- Close the current buffer
vim.api.nvim_command('command! BW :bn|:bd#')
vim.api.nvim_set_keymap('n', '<Leader>q', ':BW<CR>', {})

-- Delete current buffer
vim.api.nvim_set_keymap('n', '<Leader>d', ':Unlink<CR>:BW<CR>', {})

-- Save and restore sessions
vim.api.nvim_set_keymap('n', '<F3>', ':mksession! ~/.vim/session <cr>', {})
vim.api.nvim_set_keymap('n', '<F4>', ':source ~/.vim/session <cr>', {})

-- Save with Ctrl + s
vim.api.nvim_set_keymap('n', '<C-s>', ':update<CR>', {})
vim.api.nvim_set_keymap('i', '<C-s>', '<Esc>:update<CR>a', {})

-- Wrap arrays and hashes
vim.api.nvim_set_keymap('n', '<Leader>a', ':ArgWrap<CR>', {})

-- Switch
vim.api.nvim_set_keymap('n', '-', ':Switch<CR>', {})

-- Copy file path
vim.api.nvim_set_keymap('n', '<Leader>y', ':let @+ = expand("%")<CR>', {})

-- Telescope
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")