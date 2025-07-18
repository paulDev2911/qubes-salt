# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# templates/fedora-41-development.sls - Fedora 41 development Template
# Creates and configures a development-use template based on fedora-41
##

{% set template_config = pillar.get('templates:fedora-41-development', {}) %}
{% set packages = template_config.get('packages', {}) %}
{% set base_template = template_config.get('base_template', 'fedora-41') %}

# Clone template from base fedora-41
fedora-41-development:
  qvm.clone:
    - name: fedora-41-development
    - source: {{ base_template }}
    - class: TemplateVM

# Update system packages
update_template_packages:
  qvm.run:
    - name: fedora-41-development
    - cmd: |
        dnf update -y
        dnf clean all
    - require:
      - qvm: fedora-41-development

# Add Microsoft VS Code repository
add_vscode_repo:
  qvm.run:
    - name: fedora-41-development
    - cmd: |
        rpm --import https://packages.microsoft.com/keys/microsoft.asc
        echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo
    - require:
      - qvm: update_template_packages

# Install essential development packages
install_essential_dev_packages:
  qvm.run:
    - name: fedora-41-development
    - cmd: dnf install -y {{ packages.get('essential', [])|join(' ') }}
    - require:
      - qvm: add_vscode_repo

# Install development tools
install_development_tools:
  qvm.run:
    - name: fedora-41-development
    - cmd: dnf install -y {{ packages.get('development', [])|join(' ') }}
    - require:
      - qvm: install_essential_dev_packages

# Install VS Code and IDEs
install_ide_packages:
  qvm.run:
    - name: fedora-41-development
    - cmd: dnf install -y {{ packages.get('ides', [])|join(' ') }}
    - require:
      - qvm: install_development_tools

# Install containerization tools
install_container_tools:
  qvm.run:
    - name: fedora-41-development
    - cmd: dnf install -y {{ packages.get('containers', [])|join(' ') }}
    - require:
      - qvm: install_ide_packages

# Clean up template
cleanup_development_template:
  qvm.run:
    - name: fedora-41-development
    - cmd: |
        dnf clean all
        rm -rf /var/cache/dnf/*
        rm -rf /tmp/*
        history -c
    - require:
      - qvm: install_container_tools

# Shutdown template when done
shutdown_development_template:
  qvm.shutdown:
    - name: fedora-41-development
    - require:
      - qvm: cleanup_development_template