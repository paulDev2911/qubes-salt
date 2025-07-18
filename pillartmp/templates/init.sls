# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# pillar/templates/init.sls - Template Package Configuration
# Defines packages for different template types
##

templates:
  fedora-41-personal:
    base_template: fedora-41
    packages:
      essential:
        - vim
        - git
        - curl
        - wget
        - htop
        - tree
        - unzip
        
      personal:
        - firefox
        - thunderbird
        - libreoffice
        - vlc
        - gimp
        
    services:
      enable:
        - NetworkManager
      disable:
        - cups

  fedora-41-development:
    base_template: fedora-41
    packages:
      essential:
        - vim
        - git
        - curl
        - wget
        - htop
        - tree
        - unzip
        - which
        - make
      development:
        - python3
        - python3-pip
        - python3-devel
        - npm
      ides:
        - code
        - vim-enhanced
        - nano
      containers:
        - docker
        - docker-compose
      services:
        enable:
          - NetworkManager
          - docker
        disable:
          - cups