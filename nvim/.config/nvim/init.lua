-- init.lua

-- Bootstrap lazy.nvim plugin manager
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
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "miikanissi/modus-themes.nvim",
    priority = 1000,
    config = function()
      -- You can customize the theme here
      require("modus-themes").setup({
 	-- Uses system theme preference
        style = "auto",
 	-- Options: "default", "tinted", "deuteranopia", "tritanopia"
        variant = "tinted",
      })
      
      vim.cmd("colorscheme modus")
    end,
  },
})

-- Show line numbers
vim.opt.number = false
-- Enable 24-bit RGB colors
vim.opt.termguicolors = true
-- Sync with system clipboard
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

