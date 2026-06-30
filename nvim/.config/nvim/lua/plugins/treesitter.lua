return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').setup {
      install_dir = vim.fn.stdpath 'data' .. '/site',
    }

    require('nvim-treesitter').install {
      'bash',
      'c',
      'cpp',
      'css',
      'diff',
      'dockerfile',
      'elixir',
      'go',
      'gomod',
      'gowork',
      'html',
      'javascript',
      'json',
      'kotlin',
      'latex',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'nix',
      'query',
      'rust',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'vue',
      'yaml',
    }

    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
