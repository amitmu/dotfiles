# dotfiles 
<h5>My way of managing Linux config files across systems</h5>

<h2>Initial setup on main machine</h2>

At a high level, we’re creating a bare repo in a new directory to store the history of our dotfiles. Then we tell Git that the snapshot for that repo actually lives in your home directory, not the directory that contains the bare repo’s history (this lets us keep your dotfiles in your home directory rather than the directory that has the history). We won’t commit the entire home directory (which would take up a lot of space and probably put some important secrets on the internet), just the pieces that you want to add to version control.

1. Create a new bare Git repo to store the history for your dotfiles. 
> git init --bare $HOME/dotfiles.git

2. Tell Git that it should use your home directory as the snapshot for this bare Git repo. 
> alias dotfiles='git --git-dir=$HOME/dotfiles.git/ --work-tree=$HOME'

--git-dir tells Git where the history lives and --work-tree tells Git where the snapshot lives (the snapshot is called the “working tree” in Git jargon). We create an aliased command here so that you don’t have to specify these options manually every time you want to add a dotfile to your Git repo. If you want to use this command in the future, you should add this line to your .bashrc, .zshrc or whatever dotfile you use for aliases.

3. Tell Git that this repo should not display all untracked files (otherwise git status will include every file in your home directory, which will make it unusable).
> dotfiles config status.showUntrackedFiles no

4. Set up a remote repo to sync your dotfiles to (GitHub). 
> dotfiles remote add origin https://github.com/<i>your_id</i>/dotfiles.git

5. Whenever you want to add a new dotfile to your Git repo, use your aliased Git command with your special options set.
> dotfiles add ~/<i>your_dotfile</i>

> ....

> dotfiles commit -m "<i>your_commit_text</i>"

> dotfiles push origin master


<h2>Copying your dotfiles to another machine</h2>

To download your dotfiles onto a new machine:

1. Clone your repo onto the new machine as a non-bare repository. You need a non-bare repository on the new machine since you’re trying to move the actual dotfiles (that is, the snapshot of your repo) onto the new machine, not just the history.
> git clone --separate-git-dir=$HOME/dotfiles.git https://github.com/<i>your_id</i>/dotfiles.git dotfiles.tmp
 
--separate-git-dir tells Git that the history should live in $HOME/dotfiles.git even though the snapshot will live in dotfiles.tmp (which is just an arbitrary temporary directory that we’ll delete later once we’ve moved the dotfiles into their proper locations).

2. Copy the snapshot from your temporary directory to the correct locations on your new machine.
> rsync --recursive --verbose --exclude '.git' dotfiles.tmp/ $HOME/

This command copies every file in dotfiles.tmp and its subdirectories into the corresponding locations in your home directory (so dotfiles.tmp/.gitconfig will be copied to ~/.gitconfig and dotfiles.tmp/.emacs.d/init.el will be copied to ~/.emacs.d/init.el, etc.).

3. Remove the temporary directory. Now that we’ve copied over the snapshot to the correct locations in your actual home directory, we can delete the old snapshot.
> rm -rf dotfiles-tmp

At this point, your new machine has the dotfiles in the correct locations in your home directory and is tracking their history in ~/dotfiles, which is exactly the same state that your original machine was in after Step 1 of the initial setup. To allow your new machine to track changes to the dotfiles, just follow the steps you followed on your original machine, starting with Step 2.

<h2>Tools used for my configs</h2>

1. <b>Vim</b>
- Liteline 
> git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline
 
- Vimwiki 
> git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki

- Nerdtree
> git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/vendor/start/nerdtree

2. <b>Rust</b>
> curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

- lsd (ls replacement) 
> cargo install lsd

3. <b>Nerd Patched Fonts</b> https://github.com/ryanoasis/nerd-fonts

4. <b>Powerline</b> https://github.com/powerline/powerline


