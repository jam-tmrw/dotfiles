# Alias correct homebrew installed programs
alias ctags='/usr/local/bin/ctags'
alias vim='/usr/local/bin/vim'

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"

# Add RVM to PATH for scripting
export PATH=$PATH:$HOME/.rvm/bin:/usr/local/bin

# Load RVM into a shell session *as a function*
 [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

