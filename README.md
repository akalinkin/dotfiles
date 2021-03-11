# Dotfiles

My `dotfiles` to share configuration between workspaces

## Setup and update

### Prerequisites

1. Update sources `sudo apt update`
2. Install dependencies 

```
sudo apt install curl libnotify-bin xinput git tmux vim vim-gnome vim-gtk urlview wmctrl taskwarrior python3-pip scrot nitrogen
```
2. Install **tpm** `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
3. Install **Vundle** `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
4. Download Russian language spell file `mkdir -p ~/.vim/spell && curl -o ~/.vim/spell/ru.utf-8.spl ftp://ftp.vim.org/pub/vim/runtime/spell/ru.utf-8.spl`
5. Install **time tracking hook for taskwarrior** `pip3 install taskwarrior-time-tracking-hook`
6. Add hook to **taskwarrior** `mkdir -p ~/.task/hooks && ln -s `which taskwarrior_time_tracking_hook` ~/.task/hooks/on-modify.timetracking`
7. Install **zsh** `sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
8. Install **lsd** [LSDeluxe](https://github.com/Peltoche/lsd) LSDeluxe from package


### Setup

Before you begin with this **dotfiles** you need to install `git` software

1. Define the alias in the current shell scope:

```bash
alias dotconf='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

2. To prevent recurtion in `git` add the repo itself to `.gitignore` in the home directory:

```bash
echo ".dotfiles" >> $HOME/.gitignore
```

3. Clone the repo (latest version with some experiments in `develop` branch:

_Latest_

```bash
git clone --bare -b develop git@github.com:akalinkin/dotfiles.git $HOME/.dotfiles
```

_Stable_

```bash
git clone --bare git@github.com:akalinkin/dotfiles.git $HOME/.dotfiles
```

4. Checkout actual content to `$HOME` directory:

```bash
dotconf checkout
```

5. Set the flag **showUntrackedFiles** to `no` on this specific (local) repository:

```bash
dotconf config --local status.showUntrackedFiles no
```

### Main UseCase

```bash
dotconf status
dotconf add .aliases
dotconf commit -m "feat(aliases) Add .aliases"
dotconf push
```


## License

Copyright 2019 Alex Kalinkin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
