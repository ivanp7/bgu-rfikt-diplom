#!/bin/bash

sh ./compile.sh
OUT=$?

if [ $OUT -eq 0 ]; then
   sh ./compile-bibliography.sh
   OUT=$?

   # following is commented because BiBTeXu returns 1 even on warnings, which is undesirable
   #if [ $OUT -eq 0 ]; then
      sh ./compile.sh
      sh ./compile.sh
      sh ./copy-to-destination.sh

      echo "----------------------------------------------------------------"
      echo "Success!"
      echo
      exit 0
   #fi
fi

echo "----------------------------------------------------------------"
echo "Document compilation has FAILED!"
#echo "Error code:" $OUT
echo
exit $OUT

