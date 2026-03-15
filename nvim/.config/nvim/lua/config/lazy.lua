-- ===================================================================
-- Lazy.nvim Plugin Manager Setup
-- ===================================================================
-- Bootstrap and configure lazy.nvim for plugin management
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

-- ===================================================================
-- Bootstrap lazy.nvim
-- ===================================================================
-- Install lazy.nvim if not already installed

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- ===================================================================
-- Plugin Configuration
-- ===================================================================
-- Setup lazy.nvim with a minimal plugin set

require('lazy').setup({
  require 'plugins.ui.colorscheme',
  require 'plugins.ui.which-key',
  require 'plugins.editor.snacks',
  require 'plugins.editor.treesitter',
  require 'plugins.coding.lsp',
  require 'plugins.coding.formatting',
  require 'kickstart.plugins.neo-tree',
}, {
  -- ===================================================================
  -- Lazy.nvim UI Configuration
  -- ===================================================================
  ui = {
    -- Use Nerd Font icons if available, otherwise use unicode fallbacks
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
  -- Automatically check for plugin updates but don't notify
  checker = {
    enabled = false,
    notify = false,
  },

  -- Disable change detection notifications
  change_detection = {
    notify = false,
  },
})
