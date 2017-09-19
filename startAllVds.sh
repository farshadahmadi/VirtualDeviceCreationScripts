#!/bin/bash

for i in {10..49}
do

  cd vd"$i"

  ./start.sh

  cd ..

done
