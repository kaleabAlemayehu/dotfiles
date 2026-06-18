return {
  'nickjvandyke/opencode.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = { 'folke/snacks.nvim' },
  config = function()
    local opencode_cmd = 'opencode --port'

    ---@type snacks.terminal.Opts
    local term_opts = {
      win = {
        position = 'right',
        enter = false,
      },
    }

    ---@type opencode.Opts
    vim.g.opencode_opts = {
      server = {
        start = function()
          require('snacks.terminal').open(opencode_cmd, term_opts)
        end,
      },
    }

    vim.o.autoread = true

    vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
      require('snacks.terminal').toggle(opencode_cmd, term_opts)
    end, { desc = 'Toggle OpenCode' })

    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').ask '@this: '
    end, { desc = 'Ask OpenCode' })
    vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
      require('opencode').select()
    end, { desc = 'Select OpenCode' })
    vim.keymap.set({ 'n', 'x' }, 'go', function()
      return require('opencode').operator '@this '
    end, { desc = 'Append range to OpenCode', expr = true })
    vim.keymap.set('n', 'goo', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Append line to OpenCode', expr = true })
    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Scroll OpenCode up' })
    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Scroll OpenCode down' })

    vim.api.nvim_create_autocmd('User', {
      pattern = { 'OpencodeEvent:tui.command.execute' },
      callback = function(args)
        ---@type opencode.server.Event
        local event = args.data.event
        if event.properties.command == 'prompt.submit' then
          local win = require('snacks.terminal').get(opencode_cmd, { create = false })
          if win then
            win:show()
          end
        end
      end,
    })
  end,
}
