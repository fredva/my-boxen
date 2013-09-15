class people::fredva {
  
  $home = "/Users/${::boxen_user}"
  
  include "alfred"
  include "dropbox"
  include "macvim"
  include "spotify"
  include "virtualbox"
  include "vagrant"

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
}
