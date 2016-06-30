#!/bin/bash
logger initiate custom setup.sh
FOLDER=""
DIRCUSTOM=/bin/custom
DIRCUSTOMLOG=${DIRCUSTOM}/log
DIRSHELL=${DIRCUSTOM}/shell
FILELIST=("updates.sh")
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

#function to move any shell files to ~/shell/ folder
fMVFILE(){
for DIRFILE in $FILELIST ;
do
   if [ -f ${PWD}/${FILELIST} ]  || return 2
      then
         cp ${PWD}/${FILELIST} ${DIRSHELL}/$FILELIST || return 3
         #adds shell to daily cronjob
         cp ${PWD}/${FILELIST} /etc/cron.daily/$FILELIST || return 4
   fi
done
}

fFILERUN(){
for FILERUN in $FILELIST ;
do
   ${DIRSHELL}/${FILELIST} || return 5
done
}

fMail(){
 if [ $? -ne 0 ]
   then
      echo "mail error"
      $MAIL -s "Error with ${HOSTNAME} during initSetup.sh." $TO 
fi
}
   
}

fMKDIR
fMVFILE
fFILERUN
fMail

exit 0
