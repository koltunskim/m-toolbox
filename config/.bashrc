
# SOURCE FILES
# 
source_files=(
	/usr/local/etc/bash_completion
    /etc/bashrc
	~/.bash_aliases
    ~/.bash_completion
    ~/.bash_functions 
    ~/.git-prompt.sh
    ~/.fzf.bash
    ~/.fzf.git
    ~/.git-prompt.sh
)

for source_file in "${source_files[@]}"; do 
	if [ -f "$source_file" ]; then 
   	   source_file=$(readlink --canonicalize "${source_file}");
	   source "$source_file"
	fi
done

# PROMPT
function prompt_command() {
	if [ "$M_TOOLBOX_DOCKER" == 'true' ]; then
		export PS1="m-toolbox $(__git_ps1) \033[01;32m\]\w  \\n\[\033[00m\] $ "
	else
		export PS1="$(__git_ps1) \033[01;32m\]\w  \\n\[\033[00m\] $ "
	fi
}
export PROMPT_COMMAND=prompt_command
#export PS1="\[\033[01;32m\]\w  @mac  \\n\[\033[00m\] $ "


##HISTORY
export CLICOLOR=1
export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=100000
export HISTIGNORE="ls:ll:cd*:history*:higrep*"
export HISTSIZE=100000
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
#shopt -s cmdhist
shopt -s checkwinsize
#shopt -s histappend

##VIM
set -o vi
alias vim='nvim'
export BAT_THEME='Visual Studio Dark+'
#export FZF_DEFAULT_COMMAND='rg --files | sort -nr'
export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --exclude '.git' \
	--exclude '.ipython' --exclude '.cache' --exclude '.npm'"

# AUTOCOMPLETION
if [ -f /usr/local/bin/aws_completer ]; then
    complete -C '/usr/local/bin/aws_completer' aws
fi

#ENV
export TERM='screen-256color'

