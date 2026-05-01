return {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {
      keys = {
      {"<leader>gb", "<cmd>ToggleBlame<CR>", desc = "Toggle Git Blame"},
    }
    }
    end,
    opts = {
      blame_options = { '-w' },
    }
}
