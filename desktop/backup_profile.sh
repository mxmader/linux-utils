#!/bin/bash

tar -zcvf ~/joe_profile.tgz ~/.ssh ~/.py* ~/.vimrc ~/.zsh* ~/.bash* ~/.gdrive ~/.aws ~/.git* ~/.gnupg ~/.godaddy* ~/.local

aws s3 cp ~/joe_profile.tgz s3://mader-archive/
