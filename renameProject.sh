#!/bin/bash
#this script helps you to rename the template project to your custom name



for f in $(find . -type f  \( -iname \*.conf -o -iname \*.py -o -iname \*.config -o -iname \*.conf -o -iname \*.yml -o -iname \*.compose \)  -not -path '*/venv/*')
do
sed -i.bak 's@mysite@NEWNAME@g' ${f}
done

