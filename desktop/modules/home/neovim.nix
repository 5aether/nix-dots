{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      rustfmt
      black
      clang-tools
      nixfmt
      stylua
      ripgrep
      fd
      rust-analyzer
      pyright
      nil
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      nvim-web-devicons
      plenary-nvim
      telescope-nvim
      telescope-file-browser-nvim
      nvim-treesitter.withAllGrammars
      lualine-nvim
      bufferline-nvim
      toggleterm-nvim
      conform-nvim
      alpha-nvim
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip
      nvim-lspconfig
    ];

    initLua = ''
      -- Options
      vim.opt.number = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.termguicolors = true
      vim.opt.mouse = "a"
      vim.opt.fillchars = { eob = " " } 

      -- Dashboard
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      dashboard.section.header.val = {
        [[    _        _   _                ]],
        [[   / \   ___| |_| |__   ___ _ __  ]],
        [[  / _ \ / _ \ __| '_ \ / _ \ '__| ]],
        [[ / ___ \  __/ |_| | | |  __/ |    ]],
        [[/_/   \_\___|\__|_| |_|\___|_|    ]],
      }

      -- Dashboard buttons (e apre il file browser partendo da ~ con file nascosti)
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", ":enew<CR>"),
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("d", "󰈭  Find word", ":Telescope live_grep<CR>"),
        dashboard.button("e", "  Enter a path", ":lua require('telescope').extensions.file_browser.file_browser({ path = vim.fn.expand('~'), hidden = true })<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      vim.api.nvim_set_hl(0, 'AlphaHeader', { fg = '#89b4fa', bold = true })
      vim.api.nvim_set_hl(0, 'AlphaButtons', { bold = true })
      vim.api.nvim_set_hl(0, 'AlphaShortcut', { fg = '#f38ba8', bold = true })
      
      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)

      -- Autocomplete
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, { { name = 'buffer' }, { name = 'path' } })
      })

      -- LSP
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
      vim.lsp.config("nil_ls", {
        capabilities = capabilities,
        settings = {
          ['nil'] = {
            formatting = { command = { "nixfmt" } },
            nix = { flake = { autoEvalInputs = true } },
          },
        },
      })
      vim.lsp.enable("nil_ls")

      local servers = { "rust_analyzer", "pyright", "clangd" }
      for _, server in ipairs(servers) do
        vim.lsp.config(server, { capabilities = capabilities })
        vim.lsp.enable(server)
      end

      -- Explorer
      require('nvim-tree').setup({
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          api.config.mappings.default_on_attach(bufnr)
          local opts = function(desc) return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true } end
          vim.keymap.set('n', 'n', api.tree.change_root_to_node, opts('CD into folder'))
          vim.keymap.set('n', 'b', api.tree.change_root_to_parent, opts('CD to parent folder'))
        end,
      })

      -- Statusline
      require('lualine').setup()

      -- Telescope
      require('telescope').setup({
        defaults = { vimgrep_arguments = { "rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--hidden", "--glob=!**/.git/*" } },
        pickers = { find_files = { hidden = true, find_command = { "rg", "--files", "--glob=!**/.git/*" } } },
      })
      pcall(require('telescope').load_extension, 'file_browser')

      -- Tabs
      require('bufferline').setup({
        options = { diagnostics = "nvim_lsp", show_close_icon = true, separator_style = "thin" },
      })

      -- Terminal
      require('toggleterm').setup({ size = 15, direction = 'horizontal' })

      -- Formatter
      require('conform').setup({
        formatters_by_ft = { lua = { "stylua" }, python = { "black" }, rust = { "rustfmt" }, c = { "clang-format" }, cpp = { "clang-format" }, nix = { "nixfmt" } },
      })

      -- Transparency
      local transparent_groups = { "Normal", "NormalNC", "NormalFloat", "FloatBorder", "NvimTreeNormal", "NvimTreeNormalNC", "SignColumn", "LineNr", "CursorLine", "CursorLineNr", "EndOfBuffer", "MsgArea", "ToggleTerm", "ToggleTermNormal" }
      for _, group in ipairs(transparent_groups) do vim.api.nvim_set_hl(0, group, { bg = "NONE", ctermbg = "NONE" }) end

      -- Treesitter
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang then pcall(vim.treesitter.start, args.buf, lang) end
        end,
      })

      -- Keybinds
      vim.g.mapleader = " "
      vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save" })
      vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { desc = "Explorer" })
      vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>d", "<cmd>Telescope live_grep<CR>", { desc = "Grep" })
      vim.keymap.set({"n", "t"}, "<leader>j", "<cmd>ToggleTerm<CR>", { desc = "Terminal" })
      vim.keymap.set({ "n", "v" }, "<leader>F", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format" })
      vim.keymap.set({"n", "t"}, "<leader>w", "<cmd>wincmd w<CR>", { desc = "Cycle windows" })
      vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
      
      vim.keymap.set("n", "<leader>c", function()
        local current_buf = vim.api.nvim_get_current_buf()
        if #vim.api.nvim_list_bufs() > 1 then vim.cmd("bprevious") end
        vim.api.nvim_buf_delete(current_buf, { force = false })
      end, { desc = "Close buffer" })
    '';
  };
}
