#!/bin/bash

echo "updating summary..."
sed -i 's/.md/.html/g' SUMMARY.md
echo "[OK]"

#### EXAMPLE
#### Adding text to the end
#sed -i -e '$aTEX_THERE' ../../index.md 
#### Adding text to the begining
#sed -i '1s/^/TEXT_HERE\n/' ../../index.md 

#### Command to print your current directory (without full) 
#basename "$PWD"
#### Normaly your script need like this, but thereis do nothing, it's like need () to run command correctly
#sed -i -e '$a* ['"$basename "$PWD""'](Import/'"$basename $PWD"'/summary.html)' ../../index.md 

while true; do
    read -p "UPDATE TO INDEX.MD? [Y/n] " rmv
    case $rmv in
        [Yy]* ) echo "checking up..."; break;;
        "") echo "checking up..."; break;;
        [Nn]* ) exit;;
        * ) echo "WRONG ANSWER...";;
    esac
done

#### check if name already in index.md
#grep -q "$(basename $PWD)" ../../index.md; [ $? -eq 0 ] && echo "'$(basename $PWD)' already in list, skipping..." && exit || echo "adding '$(basename $PWD)' to index.md..." && sed -i -e '$a## ['$(basename $PWD)'](Import/'$(basename $PWD)'/summary.html)' ../../index.md
isInFile=$(cat ../../index.md | grep -c ""$(basename $PWD)"")

if [ $isInFile -eq 0 ]; then
   echo "adding '$(basename $PWD)' to index.md..."
   sed -i -e '$a## ['$(basename $PWD)'](Import/'$(basename $PWD)'/summary.html)' ../../index.md
   #### in fish avoid $ ,just use '(basename $PWD)'
   #sed -i -e '$a* ['(basename $PWD)'](Import/'(basename $PWD)'/ summary.html)' ../../index.md
   echo "[OK]"
else
   echo "'$(basename $PWD)' is in file at least once, skipping..."
fi

x="$(basename $PWD)"

echo "setup remote..."
git remote add main git@gitlab.com:bimsky/"$x".git
git remote add origin https://gitlab.com/bimsky/"$x"
echo "[OK]"

echo "publishing..."
git add --all
git commit -m "Played code today."
# use remote name "main" to use ssh (origin already used to gitbook)
git push -u main master
echo "[OK]"

while true; do
    read -p "DEPLOY YOUR WORK? [Y/n] " rmv
    case $rmv in
        [Yy]* ) echo "[OK]"; break;;
        "") echo "[OK]"; break;;
        [Nn]* ) exit;;
        * ) echo "WRONG ANSWER...";;
    esac
done

echo "checking $x submodule..."

isInFile=$(cat ../../../../.gitmodules | grep -c ""$(basename $PWD)"")

if [ $isInFile -eq 0 ]; then
   cd ../../../../
   git submodule add git@gitlab.com:bimsky/"$x".git source/space/Import/"$x"
   echo "submodule updated..."
   git config --file .gitmodules --name-only --get-regexp path
else
   echo "submodule ok..."
   git config --file .gitmodules --name-only --get-regexp path
fi

echo "deploying to github..."
cd ../../../../
#### if any error with submodule, run
git submodule update --init
git rm --cached source/space/Import/"$x"
git submodule add git@gitlab.com:bimsky/"$x".git source/space/Import/"$x"
git submodule update --init

git add --all
git commit -m "Played code today."
git push -u origin master
