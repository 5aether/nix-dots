{ config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    initLua = ''
      -- Base Settings
      vim.opt.number = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- Leader key
      vim.g.mapleader = " "

      -- Keybinds
      vim.keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save the file" })
    '';
  };
}
