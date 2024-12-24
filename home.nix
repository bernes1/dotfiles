{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "duck";
  home.homeDirectory = "/Users/duck";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh.enable = true;

  programs.zoxide.enable = true;
  programs.zoxide.enableZshIntegration = true;
  programs.fzf.enable = true;
  programs.dircolors.enable = true;

  programs.git = {
    enable = true;
    userEmail = "37117219+bernes1@users.noreply.github.com.";
    userName = "bernes1";
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "dark_plus";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages = {
      language-server.typescript-language-server = with pkgs.nodePackages; {
        command =
          "${typescript-language-server}/bin/typescript-language-server";
        args = [
          "--stdio"
          "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"
        ];
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
        {
          name = "rust";
          auto-format = false;
        }
        {
          name = "python";
          auto-format = true;
        }
      ];
    };
  };
  programs.tmux = {
    enable = true;
    extraConfig = ''
      ...
      set -g status-right '#[fg=black,bg=color15] #{cpu_percentage}  %H:%M '
      run-shell ${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/cpu.tmux
    '';
  };

}
