#!/bin/sh
echo "ISO所需packages列表:" >> ./README.md
for rpm in `ls ./iso/packages`; do
   echo $rpm >> ./README.md
done
