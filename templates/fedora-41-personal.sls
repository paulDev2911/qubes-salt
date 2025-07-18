# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# templates/fedora-41-personal.sls - Fedora 41 Personal Template
# Creates and configures a personal-use template based on fedora-41
##

{% set template_config = pillar.get('templates:fedora-41-personal', {}) %}
{% set packages = template_config.get('packages', {}) %}
{% set base_template = template_config.get('base_template', 'fedora-41') %}

# Clone template from base fedora-41
fedora-41-personal:
  qvm.clone:
    - name: fedora-41-personal
    - source: {{ base_template }}
    - class: TemplateVM

# Update system packages
update_template_packages:
  qvm.run:
    - name: fedora-41-personal
    - cmd: |
        dnf update -y
        dnf clean all
    - require:
      - qvm: fedora-41-personal

# Install essential packages
install_essential_packages:
  qvm.run:
    - name: fedora-41-personal  
    - cmd: dnf install -y {{ packages.get('essential', [])|join(' ') }}
    - require:
      - qvm: update_template_packages

# Install personal applications
install_personal_packages:
  qvm.run:
    - name: fedora-41-personal
    - cmd: dnf install -y {{ packages.get('personal', [])|join(' ') }}
    - require:
      - qvm: install_essential_packages

# Install development tools
install_development_packages:
  qvm.run:
    - name: fedora-41-personal
    - cmd: dnf install -y {{ packages.get('development', [])|join(' ') }}
    - require:
      - qvm: install_personal_packages

# Install system utilities
install_system_packages:
  qvm.run:
    - name: fedora-41-personal
    - cmd: dnf install -y {{ packages.get('system', [])|join(' ') }}
    - require:
      - qvm: install_development_packages

# Enable RPM Fusion repositories if requested
{% if template_config.get('repositories', {}).get('rpmfusion', False) %}
enable_rpmfusion:
  qvm.run:
    - name: fedora-41-personal
    - cmd: |
        dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
        dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    - require:
      - qvm: install_system_packages
{% endif %}

# Clean up template
cleanup_template:
  qvm.run:
    - name: fedora-41-personal
    - cmd: |
        dnf clean all
        rm -rf /var/cache/dnf/*
        rm -rf /tmp/*
        history -c
    - require:
      {% if template_config.get('repositories', {}).get('rpmfusion', False) %}
      - qvm: enable_rpmfusion
      {% else %}
      - qvm: install_system_packages
      {% endif %}

# Shutdown template when done
shutdown_template:
  qvm.shutdown:
    - name: fedora-41-personal
    - require:
      - qvm: cleanup_template