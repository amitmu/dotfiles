# dotfiles
This is my way of managing Linux config files across systems. YMMV.

---
![Tux](assets/tux.png)  

## Initial setup on main machine

At a high level, we’re creating a bare repo in a new directory to store the history of our dotfiles. Then we tell Git that the snapshot for that repo actually lives in your home directory, not the directory that contains the bare repo’s history (this lets us keep your dotfiles in your home directory rather than the directory that has the history). We won’t commit the entire home directory (which would take up a lot of space and probably put some important secrets on the internet), just the pieces that you want to add to version control.

1. Create a new bare Git repo to store the history for your dotfiles. 

```bash 
git init --bare $HOME/dotfiles.git 
```

2. Tell Git that it should use your home directory as the snapshot for this bare Git repo. 
```bash
alias dotfiles='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'
```

> --git-dir tells Git where the history lives and --work-tree tells Git where the snapshot lives (the snapshot is called the “working tree” in Git jargon). We create an aliased command here so that you don’t have to specify these options manually every time you want to add a dotfile to your Git repo. If you want to use this command in the future, you should add this line to your .bashrc, .zshrc or whatever dotfile you use for aliases.

3. Tell Git that this repo should not display all untracked files (otherwise git status will include every file in your home directory, which will make it unusable).
```bash
dotfiles config status.showUntrackedFiles no
```

4. Set up a remote repo to sync your dotfiles to (GitHub). 
```bash
dotfiles remote add origin https://github.com/<your id>/dotfiles.git
```

5. Whenever you want to add a new dotfile to your Git repo, use your aliased Git command with your special options set.
```bash
dotfiles add ~/<your dotfile>
```
> repeat above for each new file

```
dotfiles commit -m "<your commit text>"
dotfiles push origin master
```

---
 ![Tux](assets/tux.png)

## Copying your dotfiles to another linux machine

To download your dotfiles onto a new machine:

1. Clone your repo onto the new machine as a non-bare repository. You need a non-bare repository on the new machine since you’re trying to move the actual dotfiles (that is, the snapshot of your repo) onto the new machine, not just the history.
```bash
git clone --separate-git-dir=$HOME/dotfiles.git https://github.com/<your id>/dotfiles.git dotfiles.tmp
```

> --separate-git-dir tells Git that the history should live in $HOME/dotfiles.git even though the snapshot will live in dotfiles.tmp (which is just an arbitrary temporary directory that we’ll delete later once we’ve moved the dotfiles into their proper locations).

2. Copy the snapshot from your temporary directory to the correct locations on your new machine.
```bash
rsync --recursive --verbose --exclude '.git' dotfiles.tmp/ $HOME/
```
> This command copies every file in dotfiles.tmp and its subdirectories into the corresponding locations in your home directory (so dotfiles.tmp/.bashrc will be copied to ~/.bashrc and dotfiles.tmp/.vim/vimrc will be copied to ~/.vim/vimrc, etc.).

3. Remove the temporary directory. Now that we’ve copied over the snapshot to the correct locations in your actual home directory, we can delete the old snapshot.
```bash
rm -rf dotfiles-tmp
```

At this point, your new machine has the dotfiles in the correct locations in your home directory and is tracking their history in ~/dotfiles, which is exactly the same state that your original machine was in after Step 1 of the initial setup. To allow your new machine to track changes to the dotfiles, just follow the steps you followed on your original machine, starting with Step 2.

---  
![Win](assets/win10.png)

## If your other machine is running Windows 

You can replicate the vim config on a windows machine. Works with command line vim. gVim has issues. 

---  
## Tools and utilities used for my configs  

1 [Vim Text Editor](https://github.com/vim/vim)

2 [Liteline](https://github.com/itchyny/lightline.vim) 
```bash
 git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
```

3 [Vimwiki](https://github.com/vimwiki/vimwiki.git) 
```bash
git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki
```

4 [Nerdtree](https://github.com/preservim/nerdtree.git)
```bash
git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree
```

5 [Rust](https://www.rust-lang.org/)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

6 [lsd (ls replacement)](https://github.com/Peltoche/lsd) 
```bash
cargo install lsd
```

7 [Powerline](https://github.com/powerline/powerline)
> Awesome command line prompt.

8 [Nerd Patched Fonts](https://github.com/ryanoasis/nerd-fonts)
> These are patched ttf fonts which allow the special characters required by powerline.

---
---

