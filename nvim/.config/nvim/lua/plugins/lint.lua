return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      -- Define custom golangci-lint pointing to Mason binary
      lint.linters.golangci_lint = {
        cmd = vim.fn.stdpath 'data' .. '/mason/bin/golangci-lint',
        stdin = false,
        args = { 'run', '--out-format=line-number', '--timeout=5m' },
        stream = 'stdout',
        ignore_exitcode = true,
        parser = require('lint.parser').from_pattern(
          '[^:]+:(%d+):(%d+): (%w+): (.*)',
          { 'lnum', 'col', 'severity', 'message' },
          {
            ['error'] = vim.diagnostic.severity.ERROR,
            ['warning'] = vim.diagnostic.severity.WARN,
            ['info'] = vim.diagnostic.severity.INFO,
            ['hint'] = vim.diagnostic.severity.HINT,
          }
        ),
      }

      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        javascript = { 'eslint' },
        typescript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescriptreact = { 'eslint' },
        vue = { 'eslint' },
        go = { 'golangci_lint' },
        sh = { 'shellcheck' },
        bash = { 'shellcheck' },
      }

      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          pcall(lint.try_lint)
        end,
      })
    end,
  },
}
