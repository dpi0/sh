return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			format_on_save = function(bufnr)
				-- Disable with a global or buffer-local variable
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 500, lsp_format = "fallback" }
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		-- Define the ToggleFormat function
		function ToggleFormat()
			if vim.g.disable_autoformat then
				vim.cmd("FormatEnable")
			else
				vim.cmd("FormatDisable")
			end
		end

		-- Bind leader st to toggle format disable/enable
		vim.api.nvim_set_keymap(
			"n",
			"<leader>da",
			":lua ToggleFormat()<CR>",
			{ noremap = true, silent = true, desc = "Disable autoformat for current buffer" }
		)
	end,
}
