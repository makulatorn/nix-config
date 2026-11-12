{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    shell = "${pkgs.fish}/bin/fish";
    mouse = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    historyLimit = 50000;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on' 
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-processes '"~nvim->nvim" lazygit'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'off'
          set -g @continuum-save-internal '10'
        '';
      }
    ];

    extraConfig = ''
    set -g set-clipboard on
    set -g allow-passthrough on
    bind -T copy-mode-vi y send -X copy-pipe-and-cancel "${pkgs.wl-clipboard}/bin/wl-copy"
    bind -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "${pkgs.wl-clipboard}/bin/wl-copy"
  '';
  };
}
