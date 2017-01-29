autoload -U compinit && compinit

# prompt
PROMPT='[%n@%m%~$'

# rbenv
eval "$(rbenv init -)"

# alias
alias ls='ls -G'
alias vim='split_vim $1'




# --- function -----------------------------------------------------------------------------------------

# ssh補完
function print_known_hosts (){
if [ -f $HOME/.ssh/known_hosts ]; then
		cat $HOME/.ssh/known_hosts | tr ',' ' ' | cut -d' ' -f1
fi  
}

# 新paneを作成してvimを起動(横幅が狭いときは分割しない)
function split_vim() {
    tmux has-session &> /dev/null
    if [ $? = 0 ] && [ $COLUMNS -ge 120 ];
    then
        tmux split-window -h -p 70 "vim $1"
    else
        vim $1
    fi
}

# tmuxの起動
function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
		if is_screen_or_tmux_running; then
				! is_exists 'tmux' && return 1

				if is_tmux_runnning; then
						echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
						echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
						echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
						echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
						echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
				elif is_screen_running; then
						echo "This is on screen."
				fi
		else
				if shell_has_started_interactively && ! is_ssh_running; then
						if ! is_exists 'tmux'; then
								echo 'Error: tmux command not found' 2>&1
								return 1
						fi

						if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
								# detached session exists
								tmux list-sessions
								echo -n "Tmux: attach? (y/N/num) "
								read
								if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
										tmux attach-session
										if [ $? -eq 0 ]; then
												echo "$(tmux -V) attached session"
												return 0
										fi
								elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
										tmux attach -t "$REPLY"
										if [ $? -eq 0 ]; then
												echo "$(tmux -V) attached session"
												return 0
										fi
								fi
						fi

						if is_osx && is_exists 'reattach-to-user-namespace'; then
								# on OS X force tmux's default command
								# to spawn a shell in the user's namespace
								tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
								tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
						else
								tmux new-session  \; source-file ~/.tmux/session && echo "tmux created new session"
						fi
				fi
		fi
}

# --- /function -----------------------------------------------------------------------------------------

# ssh補完
_cache_hosts=($( print_known_hosts ))

# tmuxの起動
tmux_automatically_attach_session


