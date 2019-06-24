################################### #DEV #Tech #needed ##########################################

# Add Homebrew `/usr/local/bin` and User `~/bin` to the `$PATH`
PATH=/usr/local/bin:$PATH
PATH=/usr/local/sbin:$PATH
PATH=$HOME/bin:$PATH

#Android platform
PATH=~/Library/Android/sdk/platform-tools:$PATH

#nodeJs
PATH=/usr/local/opt/node@10/bin:$PATH

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
  [ -r "$file" ] && source "$file"
done
unset file

export PATH

#rbenv
#eval "$(rbenv init -)"

#Git integration and repository detections ()
sh /usr/local/etc/bash_completion.d/git-completion.bash

#if you are using iterm
test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
 
# Docker Alias/helpers
alias dc="docker-compose"
alias dcr="docker-compose run --rm "
alias dps="docker ps --format='{{.Names}}'"
complete -F _docker_compose dc
complete -F _docker-machine dm
#Example of docker up helper
#alias dcmini="dc up -d <App1> <App2> <App3> mq"

#Ipconfig aleternative for unix
alias ipconfig='ifconfig | grep inet'

#Git with locale alias
alias git='LC_ALL=en_GB git'

#pull all git repositories on each subfolders
alias pullAllSub="find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin development \;"
#reset all git repositories on each subfolders
alias resetAllSub="find . -type d -depth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} reset --hard HEAD \;"

#Symfony Doctrine Aliases
alias doctrine-drop="php bin/console doctrine:database:drop --force"
alias doctrine-create="php bin/console doctrine:database:create"
alias doctrine-update="php bin/console doctrine:schema:update --force"
alias doctrine-fixtures="php bin/console doctrine:fixtures:load"

#symfony-debug
alias routes="php bin/console debug:router"

doctrineRebuild(){
	if [ -f "bin/console" ]
		then
			doctrine-drop
			doctrine-create
			doctrine-update
			doctrine-fixtures --no-interaction
		else
			echo "Symfony PHP console is not available in current folder: "
			pwd
	fi
}

#vagrant aliases
alias get-back-rsync="vagrant gatling-rsync-auto"


#Load private bash profile if exists.
if [ -f ".bash_profile_private" ]
	then
		source ".bash_profile_private"
	else
		echo "no private bash profile file found"
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\[\033[01;31m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\] $(parse_git_branch)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] "
