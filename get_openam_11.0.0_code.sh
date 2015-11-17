#!/bin/bash

targetDir="$HOME/code/fr"

mkdir -p  $targetDir
cd $targetDir

svn co https://svn.forgerock.org/openam/tags/11.0.0/openam

