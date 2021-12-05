#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)


echo "setup brew..."
$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)


echo "install some recent version of common tools..."
brew install wget
brew install tree
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install git
brew install git-lfs



echo "installing a better find..."
brew install the_silver_searcher


#echo "install a more modern version of bash..."
#brew install bash
#brew install bash-completion2


# Remove outdated versions from the cellar.
brew cleanup