#!/bin/bash

cp -apfv ../HomePage/improve/_book/* .;

git add *;

git commit -m $1 -a;

git push;
