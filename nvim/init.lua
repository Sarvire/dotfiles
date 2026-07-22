-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

-- Opções básicas
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.g.mapleader = " "

-- Plugins
require("lazy").setup({
    { "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "windwp/nvim-autopairs", event = "InsertEnter" },
    { "numToStr/Comment.nvim" },
})

-- Tema
vim.cmd("colorscheme rose-pine-moon")
vim.api.nvim_set_hl(0, "Normal", { bg = "#0d0808" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#0d0808" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a0a0a" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#3d1515" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#cc2222", bold = true })

-- Lualine
require("lualine").setup({
    options = {
        theme = {
            normal = { a = { fg = "#0d0808", bg = "#cc2222", gui = "bold" }, b = { fg = "#e8d0d0", bg = "#1a0a0a" }, c = { fg = "#e8d0d0", bg = "#0d0808" } },
            insert = { a = { fg = "#0d0808", bg = "#ff3333", gui = "bold" } },
            visual = { a = { fg = "#0d0808", bg = "#8b4040", gui = "bold" } },
            inactive = { a = { fg = "#6b3030", bg = "#0d0808" }, b = { fg = "#6b3030", bg = "#0d0808" }, c = { fg = "#6b3030", bg = "#0d0808" } },
        },
        section_separators = { left = "", right = "" },
        component_separators = { left = "|", right = "|" },
    },
})

-- Plugins setup
require("nvim-tree").setup()
require("nvim-autopairs").setup()
require("Comment").setup()

-- Keymaps
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
