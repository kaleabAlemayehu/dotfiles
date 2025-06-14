require 'core.globals'
require 'core.keymaps'
require 'core.options'
require 'core.health'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=sable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.wakatime',
  require 'plugins.neotree',
  require 'plugins.bufferline',
  require 'plugins.comments',
  -- require 'plugins.nonels',
  require 'plugins.alpha',
  require 'plugins.whichkey',
  require 'plugins.telescope',
  require 'plugins.lsp',
  -- require 'plugins.image',
  require 'plugins.autocompletion',
  require 'plugins.autoformat',
  require 'plugins.misc',
  require 'plugins.treesitter',
  require 'plugins.debug',
  require 'plugins.indent_line',
  require 'plugins.lint',
  require 'plugins.autopairs',
  require 'plugins.noice',
  require 'plugins.lualine',
  require 'plugins.smearcursor',
  require 'plugins.gitsigns',
  require 'plugins.lazygit',
  require 'plugins.flash',
  require 'theme.material',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
