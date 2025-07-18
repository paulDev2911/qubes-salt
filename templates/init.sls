# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# templates/init.sls - Template Management Entry Point
# Includes all template configurations
##

include:
  - templates.fedora-41-personal
  - templates.fedora-41-development