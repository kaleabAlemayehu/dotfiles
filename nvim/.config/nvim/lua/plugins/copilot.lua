return {
  "github/copilot.vim",
  config = function()
    -- Enable verbose logging
    vim.g.copilot_log_file = "/tmp/copilot.log"  -- Add this (Linux/macOS)
    vim.g.copilot_log_level = "debug"  -- Add this
    -- Optional: disable default tab mapping if you use other completion
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    -- Custom keymaps
    vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
    vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
  end
}
