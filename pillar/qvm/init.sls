# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# pillar/qvm/init.sls - VM Configuration Data
# Defines settings for VM creation and management
##

# QVM Configuration
qvm:
  # Global defaults
  template_default: fedora-39
  memory_default: 2048
  
  # Personal VM configuration  
  personal:
    template: fedora-41-personal  # ← Nutzt unser custom template
    label: blue
    memory: 2048
    vcpus: 2
    netvm: sys-firewall
    autostart: false
    backup: true
    start_on_create: false
    
  # Template for future VMs (commented out for now)
  # development:
  #   template: fedora-39
  #   label: green
  #   memory: 4096
  #   vcpus: 4
  #   netvm: sys-firewall
  
  # work:
  #   template: debian-12
  #   label: orange
  #   memory: 3072
  #   vcpus: 2
  #   netvm: sys-firewall