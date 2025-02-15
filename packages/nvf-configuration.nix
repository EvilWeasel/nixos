{ pkgs, lib, ...}:

{
  vim = {
    theme.enable = true;
    theme.name = "catppuccin";
    theme.style = "frappe";
  };

  statusline.lualine.enable = true;
  telescope.enable = true;
  autocomplete.nvim-cmp.enable = true;

  languages = {
    enableLSP = true;
    enableTreesitter = true;
    
    nix.enable = true;
    ts.enable = true;
    rust.enable = true;
  };
}
