-- Configure blink.cmp
require('blink.cmp').setup {
  keymap = { preset = 'enter' },
}

-- Configure telescope
local telescope_themes = require 'telescope.themes'
require('telescope').setup {
  defaults = telescope_themes.get_ivy(),
  extensions = {
    ['ui-select'] = {
      telescope_themes.get_ivy(),
    },
  },
}

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    -- This ensures our config runs after the default LSP setup
    event = 'VeryLazy',
    config = function()
      -- Ensure Vue language server is installed
      local ensure_installed = {
        'vue-language-server',
        'typescript-language-server',
        'typescript', -- Make sure TypeScript itself is installed
      }

      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Wait for Mason to complete installation
      -- Configure Vue language server integration
      local mason_registry = require 'mason-registry'

      -- Make sure the package is installed before trying to configure it
      if mason_registry.is_installed 'vue-language-server' and mason_registry.is_installed 'typescript-language-server' then
        local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
        local typescript_path = mason_registry.get_package('typescript-language-server'):get_install_path() .. '/node_modules/typescript/lib'

        local lspconfig = require 'lspconfig'

        -- Configure TypeScript with Vue plugin
        lspconfig.tsserver.setup {
          cmd = { 'typescript-language-server', '--stdio' },
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
              },
            },
            tsserver = {
              path = typescript_path,
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        }

        -- Configure Volar (Vue Language Server)
        lspconfig.volar.setup {
          filetypes = { 'vue' },
        }

        vim.notify('Vue language server configured successfully', vim.log.levels.INFO)
      else
        vim.notify('Vue language server not installed. Run :Mason to install it manually.', vim.log.levels.WARN)
      end
    end,
  },
}
