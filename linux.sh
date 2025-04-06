# Problems with ipv6???? 
# /etc/default/grub
# GRUB_CMDLINE_LINUX_DEFAULT="quiet splash ipv6.disable=1"
# sudo update-grub

sudo apt-get install build-essential

echo "Installing necessary utilities"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
curl https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz -o ~/Downloads

echo "Setting up a nice terminal experience"
sudo apt install zsh git
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
curl -sS https://starship.rs/install.sh | sh
curl https://raw.githubusercontent.com/LucasCodr/dotfiles/refs/heads/main/.zshrc -o ~/.zshrc

echo >> /home/lucas/.zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/lucas/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install fzf
brew install zoxide

echo "Installing ghostty and dependencies..."

curl https://ziglang.org/download/0.14.0/zig-linux-x86_64-0.14.0.tar.xz -o ~/Downloads/zig-linux-x86_64-0.14.0.tar.xz
tar xf ~/Downloads/zig-linux-x86_64-0.14.0.tar.xz
mv zig-linux-x86_64-0.14.0 $HOME/.local
ln -s $HOME/.local/zig-linux-x86_64-0.14.0/zig $HOME/.local/zig
sudo apt install libgtk-4-dev libadwaita-1-dev git blueprint-compiler gettext
brew install --cask font-jetbrains-mono-nerd-font
git clone https://github.com/ghostty-org/ghostty
cd ghostty
zig build -p $HOME/.local -Doptimize=ReleaseFast
mkdir ~/.config/ghostty/config
curl https://raw.githubusercontent.com/LucasCodr/dotfiles/refs/heads/main/.config/ghostty/config -o ~/.config/ghostty/config
echo "Log out and hopefully ghostty will show as an app"

echo "Installing and setting up nvim..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

git clone https://github.com/LucasCodr/dotfiles.git
cp -r ./dotfiles/.config/nvim ~/.config/nvim
echo "nvim is ready to go."

echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

echo "Github CLI"
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
        && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
        && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y
