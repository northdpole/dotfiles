#dotfiles
Light config for a somewhat portable Debian based system.
Adapted from uberspot/dotfiles

This repo is more of a collection of things that you might find useful rather than a generic solution for every user.

Install with

    cd $HOME
    wget https://raw.githubusercontent.com/northdpole/dotfiles-1/master/.install.sh -O temp_install.sh
    chmod +x temp_install.sh
    ./temp_install.sh
    rm temp_install.sh


If you wanna know the dependencies check [.gitmodules](.gitmodules) and [.install.sh](.install.sh) (ubuntu linux specific)

##Features

 - zsh key bindings, better autocompletion, ls coloring and generally improved behavior in the shell (check [.zshrc](.zshrc),
 - pretty theme for zsh )
 - lots of useful aliases and functions (check [.alias](.alias), [.funcs](.funcs)).
 - keybindings and better functionality in vim/vundle (check [.vimrc](.vimrc), [.vim/](.vim/)). 
 - really useful aliases and improved behavior for git [.gitconfig](.gitconfig). Add your own modifications and private
   username, email to [.gitconfig.user](.gitconfig.user). It is sourced by gitconfig automatically.
 
 TODO:
 - Add custom user.js file + smaller changes for firefox in [.mozilla/firefox/customchanges/](.mozilla/firefox/customchanges/). So you can copy those files to your own firefox profile. Also see if/how I can setup firefox sync automagically
 - Same for chrome 
 - useful keybindings and custom actions for thunar, in [.config/](.config/).
 - Add the GDB config
 - Add the vim wiki config
 - Link to this repo when the Ansible whole system config is done

I've tried to add comments in those configs that explain most of the functionality.
