-- If you are using Lazy
return {
  'marko-cerovac/material.nvim',
  lazy = false,
  priority = 1000, -- Ensure it loads first
  config = function()
    vim.g.material_style = 'deep ocean'
    require('material').setup {

      contrast = {
        terminal = false, -- Enable contrast for the built-in terminal
        sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false, -- Enable contrast for floating windows
        cursor_line = true, -- Enable darker background for the cursor line
        lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
        non_current_windows = false, -- Enable contrasted background for non-current windows
        filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
      },

      styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { --[[ italic = true ]]
        },
        strings = { --[[ bold = true ]]
        },
        keywords = { --[[ underline = true ]]
        },
        functions = { --[[ bold = true, undercurl = true ]]
        },
        variables = {},
        operators = {},
        types = {},
      },

      plugins = { -- Uncomment the plugins that you use to highlight them
      },

      disable = {
        colored_cursor = true, -- Disable the colored cursor
        borders = false, -- Disable borders between vertically split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false, -- Hide the end-of-buffer lines
      },

      high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false, -- Enable higher contrast text for darker style
      },

      async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

      custom_colors = nil, -- If you want to override the default colors, set this to a function

      custom_highlights = {}, -- Overwrite highlights with your own
    }
    vim.cmd 'colorscheme material'
    -- theme specific

    vim.keymap.set('n', '<leader>mb', function()
      require('material.functions').find_style()
    end, { noremap = true, silent = true })
  end,
}
