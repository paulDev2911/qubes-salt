# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# pillar/templates/init.sls - Template Package Configuration
# Defines packages for different template types
##

templates:
  # Fedora 41 Personal Template
  fedora-41-personal:
    base_template: fedora-41  # Clone from this template
    packages:
      # Essential tools
      essential:
        - vim
        - git
        - curl
        - wget
        - htop
        - tree
        - unzip
        
      # Personal applications
      personal:
        - firefox
        - thunderbird
        - libreoffice
        - vlc
        - gimp
        
      # Development basics (for personal projects)
      development:
        - python3
        - python3-pip
        - nodejs
        - npm
        
      # System utilities
      system:
        - keepassxc
        - file-roller
        - gnome-calculator
        
    # Services to enable/disable
    services:
      enable:
        - NetworkManager
      disable:
        - cups  # Disable printing by default
        
    # Additional repositories (optional)
    repositories:
      rpmfusion: true
      flathub: false