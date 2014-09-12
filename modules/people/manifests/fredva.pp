class people::fredva {
  
  $home = "/Users/${::boxen_user}"
  
  include alfred
  include chrome
  include dropbox
  include firefox
  include flux
  include iterm2::stable
  include macvim
  include spotify
  include vagrant
  include virtualbox
  include vlc
  include wget

  package {
    'vim': ; 
  }

  # Mac OS X defaults
  include osx::global::expand_save_dialog
  include osx::global::expand_print_dialog
  include osx::global::disable_autocorrect
  include osx::finder::show_all_on_desktop
  include osx::no_network_dsstores
  include osx::dock::autohide
  include osx::dock::clear_dock
  class { 'osx::dock::icon_size':
    size => 60
  }
  include osx::dock::disable

  # Set up vim
  $vimrc = "${home}/.vimrc" 
  $vimdir = "${home}/.vim" 
  $dotvim_repo = "${boxen::config::srcdir}/dotvim"

  repository { $dotvim_repo:
    source  => 'fredva/dotvim',
  }

  file { $vimrc:
    ensure  => link,
    target  => "${dotvim_repo}/vimrc",
    require => Repository[$dotvim_repo] 
  }

  file { $vimdir: 
    ensure  => link,
    target  => $dotvim_repo,
    require => Repository[$dotvim_repo] 
  }

  # Set up dotfiles
  $dotfiles_repo = "${boxen::config::srcdir}/dotfiles"
  $bashrc        = "${home}/.bashrc"

  repository { $dotfiles_repo:
    source => 'fredva/dotfiles',
  }

  file { $bashrc:
    ensure  => 'link',
    target  => "${dotfiles_repo}/bashrc",
    require => Repository[$dotfiles_repo]
  }

  # Configure Git
  file { "${home}/.gitconfig":
    ensure => 'link',
    target => "${dotfiles_repo}/gitconfig",
    require => Repository[$dotfiles_repo]
  }
}
