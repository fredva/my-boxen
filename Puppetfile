# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

def github(name, version, options = nil)
  options ||= {}
  options[:repo] ||= "boxen/puppet-#{name}"
  mod name, version, :github_tarball => options[:repo]
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen",      "3.2.0"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "autoconf",   "1.0.0"
github "dnsmasq",    "1.0.0"
github "gcc",        "2.0.1"
github "git",        "1.3.2"
github "homebrew",   "1.4.1"
github "hub",        "1.1.0"
github "inifile",    "1.0.0", :repo => "puppetlabs/puppetlabs-inifile"
github "nginx",      "1.4.2"
github "nodejs",     "3.4.1"
github "openssl",    "1.0.0"
github "repository", "2.2.0"
github "ruby",       "6.5.0"
github "stdlib",     "4.1.0", :repo => "puppetlabs/puppetlabs-stdlib"
github "sudo",       "1.0.0"
github "xquartz",    "1.1.0"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "alfred",     "1.1.6"
github "chrome",     "1.1.1"
github "dropbox",    "1.1.1"
github "fish",       "1.0.0"
github "flux",       "1.0.0"
github "iterm2",     "1.0.3"
github "macvim",     "1.0.0"
github "mou",        "1.1.3"
github "osx",        "1.6.0"
github "spotify",    "1.0.1"
github "vagrant",    "3.0.0"
github "virtualbox", "1.0.7"
github "wget",       "1.0.0"
github "firefox",    "1.1.4"
