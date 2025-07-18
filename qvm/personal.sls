# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# qvm.personal - Personal AppVM Configuration
# Creates a personal AppVM with standard settings
##

# Get configuration from pillar
{% set personal_config = pillar.get('qvm:personal', {}) %}
{% set default_template = pillar.get('qvm:template_default', 'fedora-41') %}

# Create personal AppVM
personal:
  qvm.present:
    - name: personal
    - template: {{ personal_config.get('template', default_template) }}
    - label: {{ personal_config.get('label', 'blue') }}
    - mem: {{ personal_config.get('memory', 2048) }}
    - vcpus: {{ personal_config.get('vcpus', 2) }}
    - prefs:
      - netvm: {{ personal_config.get('netvm', 'sys-firewall') }}
      - autostart: {{ personal_config.get('autostart', False) }}
      - include-in-backups: {{ personal_config.get('backup', True) }}

# Ensure the VM is running if specified
{% if personal_config.get('start_on_create', False) %}
personal-running:
  qvm.start:
    - name: personal
    - require:
      - qvm: personal
{% endif %}