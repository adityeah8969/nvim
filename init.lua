-- 'stdpath' is a function to fetch standard paths in vim
-- 'data' as arg means retrieving the path to the 'data' directory of neovim usually '~/.local/share/nvim'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- fs_stat function from the Neovim loop module to check the file status (existence) of the specified path (lazypath).
if not vim.loop.fs_stat(lazypath) then
-- system function to execute a shell command  
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
-- add the lazypath to the beginning of the 'runtimepath', ensuring that Neovim searches for runtime files in this directory first.
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")
