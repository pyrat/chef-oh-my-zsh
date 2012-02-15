#
# Cookbook Name:: oh-my-zsh
# Recipe:: default
#
# Copyright 2011, Alastair Brunton
# MIT License
#
#

# Assumes that the user is already setup with zsh as their default shell

node[:oh_my_zsh][:users].each do |zsh_user|
  
  script "suck down oh-my-zsh" do
    interpreter "bash"
    user zsh_user
    code <<-EOH
    rm -fr /home/#{zsh_user}/.oh-my-zsh
    /usr/bin/env git clone https://github.com/robbyrussell/oh-my-zsh.git /home/#{zsh_user}/.oh-my-zsh
    mv /home/#{zsh_user}/.oh-my-zsh/templates/zshrc.zsh-template /home/#{zsh_user}/.zshrc
    EOH
  end


  execute "Change the default style" do
    user zsh_user
    command <<-EOH
    sed -i 's/ZSH_THEME=\"robbyrussell\"/ZSH_THEME=\"gentoo\"/' /home/#{zsh_user}/.zshrc
    EOH
  end

  script "Turn off auto update functionality" do
    user zsh_user
    interpreter "zsh"
    code <<-EOH
    echo "\\nDISABLE_AUTO_UPDATE=\"true\"" > /home/#{zsh_user}/.zshrc_update_disabled
    cat /home/#{zsh_user}/.zshrc_update_disabled /home/#{zsh_user}/.zshrc > /home/#{zsh_user}/.zshrc_tmp
    mv /home/#{zsh_user}/.zshrc_tmp /home/#{zsh_user}/.zshrc
    EOH
    not_if {File.exists?("/home/#{zsh_user}/.zshrc_update_disabled")}
  end

end
