# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# qvm/init.sls - Personal VM Creation
# Creates and configures a personal AppVM
##

# Include personal VM configuration
include:
  - qvm.personal