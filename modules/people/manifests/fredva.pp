class people::fredva {
  
  $home = "/Users/${::boxen_user}"
  
  include "alfred"
  include "dropbox"
  include "macvim"
  include "spotify"
  include "virtualbox"
  include "vagrant"
  include "fish"

  package {
    'vim': ; 
  }

  # Set up vim
  $vimrc = "${home}/.vimrc" 
  $vimdir = "${home}/.vim" 
  $dotvim_repo = "${boxen::config::srcdir}/dotvim"

  repository { $dotvim_repo:
    source  => 'fredva/dotvim',
    notify => Exec["update_dotvim_git_submodules"]
  }

  exec { "update_dotvim_git_submodules":
    command => "cd $dotvim_repo && git submodule init && git submodule update",
    provider => "shell",
    refreshonly => true,
    user => $::boxen_user
  }

  file { $vimrc:
    target => "${dotvim_repo}/vimrc",
    require => Repository[$dotvim_repo] 
  }

  file { $vimdir: 
    target => $dotvim_repo,
    require => Repository[$dotvim_repo] 
  }

  # Set up dotfiles
  $dotfiles_repo = "${boxen::config::srcdir}/dotfiles"
  $fish_config = "${home}/.config/fish"
  repository { $dotfiles_repo:
    source => 'fredva/dotfiles',
    notify => Exec["generate boxen config for fish"]
  }

  exec { "generate boxen config for fish":
    command => "$home/.config/fish/boxen-to-fish.rb",
    provider => 'shell',
    refreshonly => true,
    user => $::boxen_user
  }

  file { $fish_config: 
    ensure => 'link',
    target => "${dotfiles_repo}/fish",
    require => Repository[$dotfiles_repo]
  }


}
