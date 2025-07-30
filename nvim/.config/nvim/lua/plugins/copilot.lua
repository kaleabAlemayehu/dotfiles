return {
	  "zbirenbaum/copilot.lua",
	  cmd = "Copilot",
	  event = "InsertEnter",
	  config = function()
	    require("copilot").setup({
	      panel = {
	        enabled = true,
	        auto_refresh = false,
	        keymap = {
	          jump_prev = "[[",
	          jump_next = "]]",
	          accept = "<CR>",
	          refresh = "gr",
	          open = "<M-CR>"
	        },
	      },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-J>",      -- Your preferred key
            accept_word = "<C-L>",
            accept_line = "<C-K>",
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
        },
        },
	      filetypes = {
	        help = false,
	        gitcommit = false,
	        gitrebase = false,
	        hgcommit = false,
	        svn = false,
	        cvs = false,
	        ["."] = false,
	      },
	      copilot_node_command = 'node',
	    })
	  end,
}
