return {
  "rmagatti/auto-session",
  lazy = false,
  config = function()
    local function clean_session_buffers()
      for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local bt = vim.bo[buf].buftype
        local bn = vim.api.nvim_buf_get_name(buf)
        local ft = vim.bo[buf].filetype
        if bt == "terminal" or bt == "nofile" or ft == "neo-tree" or bn:match("neo-tree") or bn:match("term://") then
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
      end
    end

    require("auto-session").setup({
      log_level = "error",
      auto_restore_last_session = false,
      auto_create = false,
      root_dir = vim.fn.stdpath("data") .. "/sessions/",
      pre_save = function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          local ok, ft = pcall(function() return vim.api.nvim_get_option_value("filetype", { win = win }) end)
          if ok and ft == "neo-tree" then
            pcall(vim.api.nvim_win_close, win, true)
          end
        end
        clean_session_buffers()
      end,
      post_restore = function()
        clean_session_buffers()
        vim.defer_fn(function()
          pcall(vim.cmd, "Neotree reveal")
        end, 200)
      end,
    })
  end,
}
