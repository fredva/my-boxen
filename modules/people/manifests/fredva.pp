class people::fredva {
  
  $home = "/Users/${::boxen_user}"
  
  include "alfred"
  include "chrome"
  include "dropbox"
  include "fish"
  include "flux"
  include iterm2::stable
  include "macvim"
  include "mou"
  include "spotify"
  include "vagrant"
  include "virtualbox"
  include "wget"

  package {
    'vim': ; 
  }

  # Set up vim
  $vimrc = "${home}/.vimrc" 
  $vimdir = "${home}/.vim" 
  $dotvim_repo = "${boxen::config::srcdir}/dotvim"

  repository { $dotvim_repo:
    source  => 'fredva/dotvim',
    extra   => "--recurse-submodules"
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
  $fish_config   = "${home}/.config/fish"
  $bashrc        = "${home}/.bashrc"

  repository { $dotfiles_repo:
    source => 'fredva/dotfiles',
    notify => Exec["generate boxen config for fish"]
  }

  # The Boxen script to source in the shell is made for POSIX shells.
  # Make a fish-friendly equivalent to source in the fish config
  exec { "generate boxen config for fish":
    command     => "$home/.config/fish/boxen-to-fish.rb",
    provider    => 'shell',
    refreshonly => true,
    user        => $::boxen_user
  }

  file { $fish_config: 
    ensure  => 'link',
    target  => "${dotfiles_repo}/fish",
    require => Repository[$dotfiles_repo]
  }

  file { $bashrc:
    ensure  => 'link',
    target  => "${dotfiles_repo}/bashrc",
    require => Repository[$dotfiles_repo]
  }
}
