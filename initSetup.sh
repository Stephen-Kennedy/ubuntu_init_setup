!/bin/bash
logger initiate custom setup.sh
FOLDER=""
DIRCUSTOM=/bin/custom
DIRCUSTOMLOG=${DIRCUSTOM}/log
DIRSHELL=${DIRCUSTOM}/shell
FILELIST=("updates.sh")

shopt -s nullglob

#function to check and see if directory exists.
#If not, creates directory from fMKDIR list
fCHECK(){
   if [ ! -d ${FOLDER} ]
      then
         mkdir ${FOLDER}
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
   if [ -f ${pwd}/${FILELIST} ]
      then
         cp ${pwd}/${FILELIST} ${DIRSHELL}/$FILELIST
   fi
done
}

fFILERUN(){
for FILERUN in $FILELIST ;
do
   ${DIRSHELL}/${FILELIST}
done
}

fMKDIR
fMVFILE
fFILERUN

shopt +s nullglob
exit
