#!/usr/bin/python3
# Author Stephen J Kennedy
# Version 2.0
# Script for installing default packages with Python
import os
import apt

def install_default():
    cache = apt.Cache() # get the current installed packages from apt
    programs = ['vim', 'dnsutils', 'ccze', 'iftop', 'htop', 'curl', 'openssh-server', 'openssh-client', 'iptables-persi>
    for program in programs:
        if cache[program].is_installed:
            print(f"Skipping {program}, it is already installed. ")
        else:
            print(f'Installing {program}')
            os.system(f'apt-get install -y {program}')

install_default()
