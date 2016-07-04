#!/bin/bash
#This script allows for dist-upgrade - auto-remove
#Author: Stephen J Kennedy
#version 1.1
#DEBUG used with -x (reports shell name, line number, and associated function)
PS4='+ $BASH_SOURCE : $LINENO : ${FUNCNAME[0]} ()'
FOLDER=""
DIRCUSTOM=/bin/custom
DIRCUSTOMLOG=${DIRCUSTOM}/log
DIRSHELL=${DIRCUSTOM}/shell
FILEADDON=addonInstall.sh
DISTUPGRADE=autoDistUpgrade.sh
PWD=$(pwd)

#function to check and see if directory exists.
#If not, creates directory from fMKDIR list
fCHECK(){
   if [ ! -d ${FOLDER} ]
      then
         mkdir ${FOLDER} || return 1
   fi
}

#function to update the folder list to fCHECK
fMKDIR(){
   for DIRFOLDER in $DIRCUSTOM $DIRCUSTOMLOG $DIRSHELL ;
   do
      FOLDER=${DIRFOLDER}
      fCHECK
   done
}

#Function to move any shell files to ~/shell/ folder
fMVFILE(){
   cp -a ${PWD}/. ${DIRSHELL}/
}

fFILERUN(){

   ${DIRSHELL}/${DISTUPGRADE} || return 4
}

fMail(){
   if [ $? -ne 0 ]
      then
         echo "mail error"
         $MAIL -s "Error with ${HOSTNAME} during initSetup.sh." $TO || return 5
   fi
}

fADDON(){
   for ADDON in htop mailutils;
   do
      apt-get install $ADDON --assume-yes || return 6
   done
}

fADDON
fMKDIR
fMVFILE
fFILERUN
fMail

exit 0
             
