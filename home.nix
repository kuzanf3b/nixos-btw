{ config, pkgs, ... }:

{
		home.username = "kuzan";
		home.homeDirectory = "/home/kuzan";
		home.stateVersion = "25.05";

		programs.home-manager.enable = true;

		programs.zsh.enable = true;
		programs.git.enable = true;
		programs.firefox.enable = true;

		home.packages = with pkgs; [
				ffmpeg-full
				vscode
				hyprlock
				hypridle
				hyprshot
				grim
				slurp
				swaynotificationcenter
				swww
				discord
				brave
				wlogout
				nautilus
				stow
				waybar
				neovim
				wofi
				ghostty
				fastfetch
				playerctl
				bibata-cursors
				nwg-look
				lazygit
				tmux
				rofi
		];
}
