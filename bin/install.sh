#!/bin/sh
ROOT=`pwd`
DIR=./erts-5.8.4/bin
sed s:%FINAL_ROOTDIR%:$ROOT: $DIR/erl.src > $DIR/erl

