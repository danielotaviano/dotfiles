-- ===================================================================
-- Colorscheme Configuration - Gruvbox
-- ===================================================================
-- Warm, high-contrast theme with a compact setup
-- See: https://github.com/ellisonleao/gruvbox.nvim

return {
  'ellisonleao/gruvbox.nvim',
  name = 'gruvbox',
  lazy = false,
  priority = 1000,

  config = function()
    require('gruvbox').setup {
      terminal_colors = true,
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      inverse = true,
      contrast = 'hard',
      dim_inactive = false,
      transparent_mode = false,
    }

    vim.o.background = 'dark'
    vim.cmd.colorscheme 'gruvbox'
  end,
}
