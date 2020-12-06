#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

dir=~/.dotfiles        # dotfiles directory
backupdir=$dir/backup/ # old dotfiles backup directory

# determine profile filename
if test -n "$ZSH_VERSION"; then
    profile_name="zshrc"
elif test -n "$BASH_VERSION"; then
    profile_name="bashrc"
else
    echo "Error: not running in zsh or bash. Aborting."
    exit
fi

# list of files/folders to symlink in homedir
files="aliases gitconfig vim vimrc tmux.conf config hushlogin"

# change to the dotfiles directory
echo "Changing to $dir"
cd $dir || ( echo "Error: .dotfiles/ must be cloned into ~" && exit )
echo "...done"

# create backup folder in dotfiles directory
echo "Creating $backupdir for backup of any existing dotfiles in ~"
mkdir -p $backupdir
echo "...done"

# move any existing dotfiles in ~ to backup directory, then create symlinks 
echo "Moving any existing dotfiles from ~ to $backupdir"
for file in $files; do
    mv ~/.$file $backupdir
    echo "Creating symlink to $file in ~"
    ln -s $dir/$file ~/.$file
done

# profile is a special case since it requires a different name depending on the shell and OS
mv ~/.$profile_name $backupdir
echo "Creating symlink to $profile_name in ~"
ln -s $dir/profile ~/.$profile_name
echo "...done"

# install external deps
git clone https://github.com/b-ryan/powerline-shell

# install vim plugins
echo "Changing to $dir/vim/bundle/"
cd $dir/vim/bundle/ || ( echo "Error changing to $dir/vim/bundle/, aborting" && exit )
echo "...done"

git clone https://github.com/dense-analysis/ale
git clone https://github.com/preservim/nerdtree
git clone https://github.com/Xuyuanp/nerdtree-git-plugin
git clone https://github.com/vim-airline/vim-airline
git clone https://github.com/tpope/vim-fugitive
git clone https://github.com/airblade/vim-gitgutter
git clone https://github.com/sheerun/vim-polyglot
echo "...done"

echo "Changing to ~. Refer to $dir/powerline-shell/README.md to complete installation."
cd ~
