#!/bin/bash

for i in {10..28}
do

  cd vd"$i"

  ./stop.sh

  cd ..

done
