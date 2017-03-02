#!/bin/bash

MESSAGE="$1";

cd ~/site/joeytakeda.github.io/;
git pull .;
git add *;
git commit -m ""+MESSAGE+"";
git push;
