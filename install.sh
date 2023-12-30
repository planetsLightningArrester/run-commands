#!/bin/bash

mv ~/.config/nvim{,.bak}
mv ~/.cshrc{,.bak}
mv ~/.bashrc{,.bak}
mv ~/.vimrc{,.bak}
mv ~/.tmux.conf{,.bak}
mv ~/.tmux.conf.local{,.bak}
mv ~/.screenrc{,.bak}
mv ~/.Xdefaults{,.bak}
mv ~/.Xresources{,.bak}

ln -sf ~/run-commands/nvim ~/.config/nvim
ln -sf ~/run-commands/.bashrc ~
ln -sf ~/run-commands/.cshrc ~
ln -sf ~/run-commands/.vimrc ~
ln -sf ~/run-commands/.tmux.conf ~
ln -sf ~/run-commands/.tmux.conf.local ~
ln -sf ~/run-commands/.screenrc ~
ln -sf ~/run-commands/.Xdefaults ~
ln -sf ~/run-commands/.Xresources ~

# EOF
