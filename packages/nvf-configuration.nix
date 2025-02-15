{ pkgs, lib, ...}:

{
  vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "frappe";
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    filetree.neo-tree.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;
      
      nix.enable = true;
      ts.enable = true;
      rust.enable = true;
      sql.enable = true;
      clang.enable = true;
      python.enable = true;
      markdown.enable = true;
      html.enable = true;
      lua.enable = true;
    };
  };
}
