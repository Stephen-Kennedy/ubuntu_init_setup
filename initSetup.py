#!/usr/bin/python3
# Author Stephen J Kennedy
# Version 1.0
# Script for installing default packages with Python
import os
import apt

def install_default():
  os.system('apt -y update')
  cache = apt.Cache() # get the current installed packages from apt
  programs = ['vim', 'dnsutils', 'ccze', 'iftop', 'htop', 'curl', 'openssh-client']

  for program in programs:
    if cache["%s" % program].is_installed:
      print("Skipping %s, it is already installed. " % (program))
    else:
      print("Installing %s " % program)
      os.system('apt-get install -y %s' % (program))
      
install_default()
