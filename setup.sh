#!/bin/bash

if [ -z $1 ]; then
    echo "private email not set"
    exit 1
fi

if [ -z $2 ]; then
    echo "work email not set"
    exit 1
fi

if [ -z $3 ]; then
    echo "password not set"
    exit 1
fi
sudo apt-get update 

sudo apt-get install build-essential -y
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

printf "Installing rust"
curl https:/sh.rustup.rs -sSf | sh -s -- -y

brew install neovim
brew install lazygit 

cargo install ripgrep

# setup git 
mkdir ~/work
mkdir ~/private

mkdir -p ~/.ssh

ssh-keygen -t ed25519 -C "$1" -f ~/.ssh/private -N "$3" 
ssh-keygen -t ed25519 -C "$2" -f ~/.ssh/work -N "$3" 

eval "$(ssh-agent -s)" && \
ssh-add ~/.ssh/private
ssh-add ~/.ssh/work

touch ~/.ssh/config

printf "Host *\nAddKeysToAgent yes\n " >> ~/.ssh/config
  #IdentityFile ~/.ssh/work"

touch ~/.gitconfig

printf "[includeIf \"gitdir:~/private/\"]\npath = ~/private/.gitconfig-priv\n[includeIf \"gitdir:~/work/\"]\npath = ~/work/.gitconfig-work\n\n[core]\nexcludesfile = ~/.gitignore" >> ~/.gitconfig

touch ~/private/.gitconfig.priv

printf "[user]\nemail = $1\n name = Nehliin\n\n[github]\nuser = \"Nehliin\"\n\n[core]\nsshCommand = \"ssh -i ~/.ssh/private\"" >> ~/private/.gitconfig.priv

touch ~/work/.gitconfig.work

printf "[user]\nemail = $2\n name = oskarn\n\n[github]\nuser =\"oskarn\"\n\n[core]\nsshCommand = \"ssh -i ~/.ssh/work\"" >> ~/work/.gitconfig.work

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
mkdir -p ~/.config
ln -s "$(pwd)/dotfiles/nvim" ~/.config/nvim  

