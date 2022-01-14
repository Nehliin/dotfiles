#!/bin/bash

if [ -z $1 ]; then
    echo "private email not set"
    exit 1
fi

#if [ -z $2 ]; then
#    echo "work email not set"
#    exit 1
#fi

if [ -z $2 ]; then
    echo "password not set"
    exit 1
fi
sudo apt-get update 

sudo apt-get install build-essential -y
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

printf "Installing rust"
curl https:/sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"

brew install neovim
brew install lazygit 
brew install alacritty

cargo install ripgrep
cargo install fd-find
cargo install bat

sudo apt-get install tmux -y

# setup git 
mkdir -p ~/.ssh

ssh-keygen -t ed25519 -C "$1" -f ~/.ssh/private -N "$3" 

eval "$(ssh-agent -s)" && \
ssh-add ~/.ssh/private

touch ~/.ssh/config

printf "Host *\nAddKeysToAgent yes\n " >> ~/.ssh/config

touch ~/.gitconfig

#printf "[includeIf \"gitdir:~/private/\"]\npath = ~/private/.gitconfig-priv\n[includeIf \"gitdir:~/work/\"]\npath = ~/work/.gitconfig-work\n\n[core]\nexcludesfile = ~/.gitignore" >> ~/.gitconfig

#touch ~/private/.gitconfig.priv

printf "[user]\nemail = $1\n name = Nehliin\n\n[github]\nuser = \"Nehliin\"\n\n[core]\nsshCommand = \"ssh -i ~/.ssh/private\"" >> ~/.gitconfig

sudo apt-get install zsh -y 
# Set shell to zsh 
chsh -s /bin/zsh 
# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cd ~/private
git clone https://github.com/Nehliin/dotfiles.git

rm ~/.zshrc
ln -s "$(pwd)/dotfiles/.zshrc" ~/.zshrc
ln -s "$(pwd)/dotfiles/tmux.conf" ~/.tmux.conf

mkdir -p ~/.config
ln -s "$(pwd)/dotfiles/nvim" ~/.config/nvim  
ln -s "$(pwd)/dotfiles/alacritty" ~/.config/alacritty

# set up rust-analyzer
cd ~/Desktop
git clone https://github.com/rust-analyzer/rust-analyzer.git
cd rust-analyzer && cargo xtask install --server

printf "Set up complete! Here is the git key"
cat ~/.ssh/private.pub

