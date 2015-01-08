class people::fredva {

  $home = "/Users/${::boxen_user}"

  include alfred
  include calibre
  include chrome
  include dropbox
  include firefox
  include flux
  include iterm2::stable
  include java
  include macvim
  include spotify
  include vagrant
  include virtualbox
  include vlc
  include wget
  include zsh

  # Mac OS X defaults
  include osx::global::expand_save_dialog
  include osx::global::expand_print_dialog
  include osx::global::disable_autocorrect
  include osx::global::tap_to_click
  include osx::finder::show_all_on_desktop
  include osx::no_network_dsstores
  include osx::disable_app_quarantine
  include osx::dock::autohide
  include osx::dock::clear_dock
  class { 'osx::dock::icon_size':
    size => 60
  }
  include osx::dock::disable

  class { 'nodejs::global': version => 'v0.10.34' }

  # Set up checkout directory for repos
  $localdir = "${home}/local"
  file { $localdir:
    ensure => directory
  }

  $srcdir = "${localdir}/src"
  file { $srcdir:
    ensure => directory,
    require => File[$localdir]
  }

  # Set up vim
  $vimrc = "${home}/.vimrc" 
  $vimdir = "${home}/.vim" 
  $dotvim_repo = "${srcdir}/dotvim"

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
  $dotfiles_repo = "${srcdir}/dotfiles"
  $profile        = "${home}/.profile"

  repository { $dotfiles_repo:
    source => 'fredva/dotfiles',
  }

  file { $profile:
    ensure  => 'link',
    target  => "${dotfiles_repo}/profile",
    require => Repository[$dotfiles_repo]
  }

  # Oh my Zsh
  $ohmyzsh = "${home}/.oh-my-zsh"
  $zshrc = "${home}/.zshrc"
  
  repository { $ohmyzsh:
    source => 'robbyrussell/oh-my-zsh'
  }

  file { $zshrc:
    ensure => 'link',
    target => "${dotfiles_repo}/zshrc.zsh",
    require => Repository[$dotfiles_repo]
  }

  # Configure Git
  file { "${home}/.gitconfig":
    ensure => 'link',
    target => "${dotfiles_repo}/gitconfig",
    require => Repository[$dotfiles_repo]
  }
}
