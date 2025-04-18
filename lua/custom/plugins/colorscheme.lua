require('fidget').setup {
  notification = {
    window = {
      winblend = 0, -- Background color opacity in the notification window
    },
  },
}

return {
  {
    'sainnhe/gruvbox-material',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_forgrund = 'material'
      vim.g.gruvbox_material_ui_contrast = 'high'
      vim.g.gruvbox_material_transparent_background = 2
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_italic = false

      vim.cmd.colorscheme 'gruvbox-material'

      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'gruvbox-material',
        callback = function()
          -- Make Neo-tree popups transparent
          vim.api.nvim_set_hl(0, 'NeoTreeFloatBorder', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NeoTreeFloatTitle', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NeoTreeTitleBar', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NeoTreeFloatNormal', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'NeoTreeMessage', { link = 'NeotreeDimText' })

          -- Make nvim-cmp menu transparent
          vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'PmenuSel', { bg = '#504945' }) -- Keep a subtle highlight for selection
          vim.api.nvim_set_hl(0, 'PmenuSbar', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'PmenuThumb', { bg = '#7c6f64' })

          -- Make floating windows transparent in general
          vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
          vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })

          -- MiniStatusline
          vim.api.nvim_set_hl(0, 'MiniStatuslineFilename', { bg = 'NONE' })
        end,
      })

      vim.cmd 'doautocmd ColorScheme gruvbox-material'
    end,
  },
}
