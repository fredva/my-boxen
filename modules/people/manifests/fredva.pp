class people::fredva {
  
  $home = "/Users/${::boxen_user}"
  
  include alfred
  include chrome
  include dropbox
  include fish
  include flux
  include iterm2::stable
  include macvim
  include spotify

  package {
    'vim': ; 
  }

  # 1
  # Set up vim
  #$vimrc = "${home}/.vimrc" 
  #$vimdir = "${home}/.vim" 
  #$dotvim_repo = "${boxen::config::srcdir}/dotvim"

  #repository { $dotvim_repo:
  #  source  => 'fredva/dotvim',
  #}

  #file { $vimrc:
  #  ensure  => link,
  #  target  => "${dotvim_repo}/vimrc",
  #  require => Repository[$dotvim_repo] 
  #}

  #file { $vimdir: 
  #  ensure  => link,
  #  target  => $dotvim_repo,
  #  require => Repository[$dotvim_repo] 
  #}

  # 2
  #include osx::dock::autohide
  #include osx::dock::clear_dock
  #class { 'osx::dock::icon_size':
  #  size => 60
  #}
  
  # 3
  #include osx::dock::disable

  # Mac OS X defaults
  include osx::global::expand_save_dialog
  include osx::global::expand_print_dialog
  include osx::global::disable_autocorrect
  include osx::finder::show_all_on_desktop
  include osx::no_network_dsstores
 
  # Set up dotfiles
  $dotfiles_repo = "${boxen::config::srcdir}/dotfiles"
  $fish_config   = "${home}/.config/fish"
  $bashrc        = "${home}/.bashrc"

  repository { $dotfiles_repo:
    source => 'fredva/dotfiles',
    notify => Exec["generate boxen config for fish"]
  }

  file { "${home}/.config":
    ensure => directory
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
    require => [ Repository[$dotfiles_repo], File["${home}/.config"] ]
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

  # Set up vimdeck 
  class { 'ruby::global':
    version => '2.0.0'
  }

  ruby::gem { 'vimdeck for 2.0.0':
    gem     => 'vimdeck',
    ruby    => '2.0.0',
    version => '~> 0.1.6',
    require => Package['imagemagick']
  }

  package {
    'imagemagick': ;
  }
}
