# BV_Importer
BeenVerified Test - Application to upload compressed (zip) CSV files with a simple interface to read, update, batch create, and batch delete marketing statistics data.

A user is be able to:
  - upload a compressed (zip) CSV file of data. Contents of the file should be mapped to the correct columns in the database (described below).
  - view a list of uploaded files
  - view the saved records from a file
  - delete all the records imported from a single file with one click
  - It is not be possible to duplicate a file upload

### Version
1.0.0

### Tech

BeenVerified Test uses a number of open source projects to work properly:

* [RubyOnRails] - is an open-source web framework that’s optimized for programmer happiness and sustainable productivity.
* [jQuery] - is a fast, small, and feature-rich JavaScript library.
* [Twitter Bootstrap] - great UI boilerplate for modern web apps.
* [MySQL] - is a powerful, open source object-relational database system.



### Installation

You need rbenv installed globally; first, if you have already installed any other ruby manager (like rvm), you must to get rid of rvm in order to install rbenv :

```sh
$ rvm implode
$ rm -rf .rvm
```
Ensure your homebrew is working properly and up to date
```sh
$ brew doctor
$ brew update
```
Install rbenv and ruby-build
```sh
$ brew install rbenv
$ brew install ruby-build
```
##Configurate working directory

### Global git ignore
```sh
$ git config --global core.excludesfile ~/.gitignore
$ printf "vendor/bundle\n.DS_Store\n" >> ~/.gitignore
```
## Set default bundle path
```sh
$ mkdir -p ~/.bundle
$ printf -- "---\nBUNDLE_PATH: vendor/bundle" >> ~/.bundle/config
```
## Instantiate rbenv with your shell (choose preferred file - .profile, .bash_profile, .zshrc, etc)
```sh
$ printf 'eval "$(rbenv init -)"' >> ~/.bash_profile
```
### Remove the RVM stuff from your .profile - It probably looks like...
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

## Reload your profile if you are using .profile
```sh
$ . ~/.profile
```

## Add autocompletion to IRB
```sh
$ touch ~/.irbrc
$ printf "require 'irb/completion'" >> ~/.irbrc
```

## Choose a ruby flavor version to install
```sh
$ rbenv install 2.2.0
$ rbenv rehash
```

## Install MySQL
```sh
$ brew install mysql
```
You can now start the database server using:
```sh
$ mysql.server restart
```

# Change to working dir and clone the source from github
```sh
$ git clone git@github.com/hemelend/BV_Importer.git
$ git fetch
$ git checkout master
```
## Change to application directory
```sh
$ rbenv local 2.2.0
```
## Bundle installation
```sh
$ gem install bundler
```
## Installing gems bundle
```sh
$ bundle install
```
# DBs creations steps
Run rake task to setup database
```sh
$ bundle exec rake db:setup
```

[RubyOnRails]:http://rubyonrails.org
[jQuery]:http://jquery.com
[Twitter Bootstrap]:http://twitter.github.com/bootstrap/
[MySQL]:http://dev.mysql.com/