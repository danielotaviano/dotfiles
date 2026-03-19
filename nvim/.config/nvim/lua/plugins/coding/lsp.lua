-- ===================================================================
-- LSP Configuration - Language Server Protocol
-- ===================================================================
-- Complete LSP setup with Mason for automatic server management
-- See: https://github.com/neovim/nvim-lspconfig
-- See: https://github.com/williamboman/mason.nvim

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },

    config = function()
      -- ===================================================================
      -- What is LSP?
      -- ===================================================================
      -- LSP (Language Server Protocol) enables editors and language tooling
      -- to communicate in a standardized way. Language servers like `lua_ls`,
      -- `rust_analyzer`, `gopls` run as separate processes and provide:
      --
      -- - Go to definition/references
      -- - Autocompletion
      -- - Symbol search
      -- - Error diagnostics
      -- - Code actions and refactoring
      -- - Hover documentation
      --
      -- Mason automatically installs and manages these language servers.
      -- See `:help lsp-vs-treesitter` for LSP vs Treesitter comparison.

      -- ===================================================================
      -- Diagnostic Configuration
      -- ===================================================================
      -- Configure how LSP diagnostics are displayed
      local virtual_text_config = {
        source = 'if_many', -- Show source if multiple
        spacing = 2, -- Space between text and diagnostic
        format = function(diagnostic)
          return diagnostic.message
        end,
      }

      vim.g.diagnostic_virtual_text_enabled = true

      vim.diagnostic.config {
        -- Sort diagnostics by severity (errors first)
        severity_sort = true,

        -- Floating window style for diagnostic details
        float = {
          border = 'rounded',
          source = 'if_many', -- Show source if multiple sources
        },

        -- Only underline errors (reduce visual noise)
        underline = {
          severity = vim.diagnostic.severity.ERROR,
        },

        -- Sign column icons (if Nerd Font available)
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},

        -- Virtual text configuration
        virtual_text = virtual_text_config,
      }

      -- Default LSP capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
      end

      -- ===================================================================
      -- Language Server Configuration
      -- ===================================================================
      -- Define language servers and their specific settings
      -- Add/remove servers as needed for your projects
      local servers = {
        -- Rust Language Server
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              -- Use Clippy for enhanced linting
              checkOnSave = {
                command = 'clippy',
              },

              -- Enable all Cargo features
              cargo = {
                allFeatures = true,
              },

              -- Enable procedural macros
              procMacro = {
                enable = true,
              },

              -- Import configuration
              assist = {
                importGranularity = 'module',
                importPrefix = 'self',
              },

              -- Enhanced diagnostics
              diagnostics = {
                enable = true,
                experimental = {
                  enable = true,
                },
              },

              -- Inlay hints for better code understanding
              inlayHints = {
                enable = true,
                parameterHints = {
                  enable = true,
                },
                typeHints = {
                  enable = true,
                },
              },
            },
          },
        },

        -- Lua Language Server (for Neovim configuration)
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- Uncomment to disable noisy missing-fields warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        -- JavaScript/TypeScript
        ts_ls = {
          settings = {
            typescript = {
              preferences = {
                preferGoToSourceDefinition = true,
              },
            },
            javascript = {
              preferences = {
                preferGoToSourceDefinition = true,
              },
            },
          },
        },

        -- Add more servers as needed:
        -- Go: gopls = {}
        -- Python: pyright = {} or pylsp = {}
        -- C/C++: clangd = {}
        -- See `:help lspconfig-all` for complete list
      }

      -- ===================================================================
      -- Mason Tool Installation
      -- ===================================================================
      -- Automatically install language servers and related tools
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Lua formatter
        -- Add other tools as needed:
        -- 'prettier', 'eslint_d', 'black', 'isort', etc.
      })

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
      }

      -- ===================================================================
      -- LSP Server Setup
      -- ===================================================================
      require('mason-lspconfig').setup {
        -- Don't auto-install here (use mason-tool-installer instead)
        ensure_installed = {},
        automatic_installation = false,

        -- Handler for each language server
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            -- Merge server-specific capabilities with defaults
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            -- Setup the language server
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- ===================================================================
      -- Module Exports for Testing
      -- ===================================================================
      -- Export server configuration for testing purposes
      _G.lsp_servers = servers
      _G.lsp_capabilities = capabilities
    end,
  },
}
