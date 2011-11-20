# Description

Assumes ZSH already installed from using the users cookbook and associated data bag configuration.

Add this to your run list.

    recipe[oh-my-zsh]

Also you can define the users that should have oh-my-zsh installed.

eg.

    [:oh_my_zsh][:users] = ['deploy', 'user', 'bob']
