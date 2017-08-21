#!/bin/bash

cd ~/git/joeytakeda.github.io;
git pull .;
git add *;
git commit -m "$1";
git push;
