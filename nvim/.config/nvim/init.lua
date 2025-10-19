-- init.lua

-- Bootstrap lazy.nvim plugin manager
local opt = vim.opt
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        style = "auto",
        variant = "tinted", -- "default", "tinted", "deuteranopia", "tritanopia"
      })

      vim.cmd("colorscheme modus")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = false },
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          sh = { "shfmt" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          go = { "gofmt" },
        },
        formatters = {
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
          shfmt = {
            prepend_args = { "-i=2", "-s" },
          },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
      })
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      vim.keymap.set("n", "<M-;>", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment line" })
      vim.keymap.set("v", "<M-;>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment selection" })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
      vim.keymap.set("n", "<C-x><C-f>", ":Telescope git_files<CR>", { silent = true, desc = "Find files" })
      vim.keymap.set("n", "<C-x><C-g>", ":Telescope live_grep<CR>", { silent = true, desc = "Grep files" })
      vim.keymap.set("n", "<C-x><C-b>", ":Telescope buffers<CR>", { silent = true, desc = "Browse buffers" })
    end,
  },
})

-- Clipboard
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Style
opt.number = false
opt.termguicolors = true
opt.wrap = false
opt.scrolloff = 4

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
