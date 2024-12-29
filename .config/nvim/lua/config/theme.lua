require("rose-pine").setup({
	variant = "auto",
	extend_background_behind_borders = false,
	styles = {
		transparency = true,
		italic = false
	}
})

vim.cmd("colorscheme rose-pine-moon")
vim.cmd("set number relativenumber")
