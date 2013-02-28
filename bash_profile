# If running interactively, then:
if [ "$PS1" ]; then

  # aliases
  if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi

  # history
  if [ ! -d ~/.history ]; then
    mkdir ~/.history
  fi

  # export
  export HISTSIZE=5000
  export HISTFILE=~/.history/${HOSTNAME}
  export HISTCONTROL=ignoredups
  export EDITOR="mate -w"
  export GIT_EDITOR="mate -w"

  # path
  export PATH=~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/opt/local/lib/postgresql90/bin:/usr/local/mongodb/bin:$PATH

  # my colors
  COLOR1="\[\033[0;36m\]"
  COLOR2="\[\033[0;32m\]"
  COLOR3="\[\033[0;36m\]"
  COLOR4="\[\033[0;39m\]"

  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  }

  parse_git_diff() {
    diff=$(git diff --shortstat 2> /dev/null | tail -n1)

    if [ -z "$diff" ]; then
      echo " 0 file changed, 0 insertion(+), 0 deletion(-) :D "
    else
      echo " ${diff} :( "
    fi
  }

  rvm_version() {
    version=$(~/.rvm/bin/rvm-prompt i v g)

    if [ -z "$version" ]; then
      echo ""
    else
      echo "${version} "
    fi
  }

  PS1="$COLOR2\$(rvm_version)$COLOR3\u$COLOR2:$COLOR1\w$COLOR2\$(parse_git_branch)$COLOR1\$(parse_git_diff)$COLOR2 \n$ $COLOR4$EOP"
fi

# rvm
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi

# ssh identity add
ssh-add ~/.ssh/id_rsa > /dev/null 2>&1

# bash bookmarks
if [ -f ~/.bash_bashmarks ] ; then
  . ~/.bash_bashmarks
fi

# git completion
if [ -f ~/.bash_git_completion ] ; then
  . ~/.bash_git_completion
fi

# aliases
alias fs='bundle exec foreman start -f Procfile.development'
alias ss='solr start'
alias integrate='RAILS_ENV=test time rake integrate'
alias mysql=/usr/local/mysql/bin/mysql
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
alias gp='git push '
alias gpl='git pull '
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gcm='git commit -m '
alias gd='git diff'
alias go='git checkout '
