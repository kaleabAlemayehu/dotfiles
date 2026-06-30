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

      -- Define statix for Nix linting (install via: nix profile install nixpkgs#statix)
      lint.linters.statix = {
        cmd = 'statix',
        stdin = false,
        args = { 'check', '--format', 'json', '%' },
        stream = 'stdout',
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local decoded = vim.json.decode(output)
          if decoded and decoded.diagnostics then
            for _, diag in ipairs(decoded.diagnostics) do
              table.insert(diagnostics, {
                lnum = diag.range.start.line - 1,
                col = diag.range.start.character,
                end_lnum = diag.range['end'].line - 1,
                end_col = diag.range['end'].character,
                severity = vim.diagnostic.severity.WARN,
                message = diag.message,
                source = 'statix',
              })
            end
          end
          return diagnostics
        end,
      }

      -- Define credo for Elixir linting (install via: mix escript.install hex cli credo)
      lint.linters.credo = {
        cmd = 'mix',
        stdin = false,
        args = { 'credo', 'list', '--format', 'json' },
        stream = 'stdout',
        ignore_exitcode = true,
        parser = function(output)
          local diagnostics = {}
          local ok, decoded = pcall(vim.json.decode, output)
          if ok and decoded and decoded.issues then
            for _, issue in ipairs(decoded.issues) do
              local severity = vim.diagnostic.severity.INFO
              if issue.priority and issue.priority >= 10 then
                severity = vim.diagnostic.severity.ERROR
              elseif issue.priority and issue.priority >= 0 then
                severity = vim.diagnostic.severity.WARN
              end
              table.insert(diagnostics, {
                lnum = issue.line_no - 1,
                col = 0,
                severity = severity,
                message = issue.message,
                source = 'credo',
              })
            end
          end
          return diagnostics
        end,
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
        kotlin = { 'ktlint' },
        nix = { 'statix' },
        elixir = { 'credo' },
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
