Is 'personal workflow' script to manage Hexo blog or other writings in case using **gitbook** as text editor.

This script will automatically
- generate table index called **SUMMARY.md**
- "smart" deployment to github

# Gitbook Editor
**Linux** Download it from https://github.com/GitbookIO/editor-legacy/releases. (Legacy)
```
tar -xvzf gitbook-linux32.tar.gz
cd GitBook && ./install.sh
```

New version: https://iot.bzh/download/public/2017/GitBook/
```
wget https://iot.bzh/download/public/2017/GitBook/gitbook-editor-7.0.12-linux-x64.deb
sudo dpkg -i gitbook-editor-7.0.12-linux-x64.deb
```

**Windows** using Chocolately and (for running bash terminal) https://gitforwindows.org/
```
choco install gitbook-editor
```

# How to use
Gitbook will create new directory in every created space in ```space/import/New_space```. And this file executable will be placed in ```Project_folder/source/space/import/Space_name```. First entered a correct directory. Don't placed to another directory, because script will be failed. 

```
# example
cd Project_8log/source/space/import/cisco
```

After that, clone the repository
```
git clone https://github.com/bimsky/gitbook2hexo .
```

And execute script
```
./sed.sh
```

# To do
- replace the defeult push button with sed script
