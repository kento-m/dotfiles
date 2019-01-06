# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
#export LANG=ja_JP.UTF-8  # 文字コードをUTF-8に設定
export KCODE=u           # KCODEにUTF-8を設定
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
bindkey -e
bindkey '^U' backward-kill-line

setopt no_beep           # ビープ音を鳴らさないようにする
setopt auto_cd           # ディレクトリ名の入力のみで移動する 
setopt auto_pushd        # cd時にディレクトリスタックにpushdする
setopt correct           # コマンドのスペルを訂正する
setopt magic_equal_subst # =以降も補完する(--prefix=/usrなど)
setopt prompt_subst      # プロンプト定義内で変数置換やコマンド置換を扱う
setopt notify            # バックグラウンドジョブの状態変化を即時報告する
setopt equals            # =commandを`which command`と同じ処理にする

### Complement ###
autoload -U compinit; compinit # 補完機能を有効にする
setopt auto_list               # 補完候補を一覧で表示する(d)
setopt auto_menu               # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed             # 補完候補をできるだけ詰めて表示する
setopt list_types              # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete  # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt brace_ccl # 範囲指定できるようにする (例 : mkdir {1-3} で フォルダ1, 2, 3を作れる)
zstyle ':completion:*:default' menu select=2
# 補完関数の表示を強化する
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
# マッチ種別を別々に表示
zstyle ':completion:*' group-name ''
# セパレータを設定する
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true
# 名前で色を付けるようにする
autoload colors
colors
# LS_COLORSを設定しておく
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ファイル補完候補に色を付ける
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

### Glob ###
setopt extended_glob # グロブ機能を拡張する
unsetopt caseglob    # ファイルグロブで大文字小文字を区別しない

### History ###
HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数
setopt bang_hist          # !を使ったヒストリ展開を行う(d)
setopt extended_history   # ヒストリに実行時間も保存する
setopt hist_ignore_dups   # 直前と同じコマンドはヒストリに追加しない
setopt share_history      # 他のシェルのヒストリをリアルタイムで共有する
setopt hist_reduce_blanks # 余分なスペースを削除してヒストリに保存する

# マッチしたコマンドのヒストリを表示できるようにする
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# すべてのヒストリを表示する
function history-all { history -E 1 }

# ------------------------------
# Look And Feel Settings
# ------------------------------
### Ls Color ###
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true
# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
# プロンプトに色を付ける
autoload -U colors; colors
#
## 一般ユーザ時
#tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
#tmp_rprompt="%{${fg[green]}%}[%~]%{${reset_color}%}"
#tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"
#
## rootユーザ時(太字にし、アンダーバーをつける)
#if [ ${UID} -eq 0 ]; then
#	tmp_prompt2="%B%U${tmp_prompt2}%u%b"
#	tmp_rprompt="%B%U${tmp_rprompt}%u%b"
#	tmp_sprompt="%B%U${tmp_sprompt}%u%b"
#fi
#
#PROMPT="%{${fg[cyan]}%}[%n@${HOST%%.*}]%# %{${reset_color}%}" # 通常のプロンプト
#PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
#RPROMPT=$tmp_rprompt  # 右側のプロンプト
#SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト
#
#### Title (user@hostname) ###
#case "${TERM}" in
#	kterm*|xterm*)
#		precmd() {
#		echo -ne "\033]0;${USER}@${HOST%%.*}\007"
#		}
#	;;
#esac
# ------------------------------
# Powerline
# ------------------------------
function powerline_precmd() {
  PS1="$(~/.local/bin/powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

# ------------------------------
# Other Settings
# ------------------------------
### RVM ###
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

### Aliases ###
alias ll='ls -l'

# ------------------------------
# For Mac
# ------------------------------
# MacPortsとHomebrew用の環境変数
case ${OSTYPE} in
    darwin*)
        export PATH=/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:$PATH
        export MANPATH=/opt/local/man:$MANPATH
        ;;
esac

# ------------------------------
# For World
# ------------------------------
# set SSH_AUTH_SOCK
#if [ -n "${TMUX}" ]; then
#    NEWVAL=`tmux show-environment | grep "^SSH_AUTH_SOCK" | cut -d"=" -f2`
#    if [ -n "${NEWVAL}" ]; then
#        export SSH_AUTH_SOCK=${NEWVAL}
#    fi
#fi
#
#AGENT="$HOME/.ssh/auth_sock_$YROOT_NAME"
#if [ -z "$TMUX" ]; then
#    if [ ! -z "$SSH_TTY" ]; then
#        if [ "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$AGENT" ]; then
#            if [ ! -S $AGENT ]; then
#                rm -f $AGENT
#                ln -fs $SSH_AUTH_SOCK $AGENT
#                export SSH_AUTH_SOCK=$AGENT
#            fi
#            if [ "$SSH_AUTH_SOCK" != "$AGENT" ]; then
#                if [ -S $AGENT ]; then
#                    export SSH_AUTH_SOCK=$AGENT
#                fi
#            fi
#        fi
#    fi
#fi

# ------------------------------
# For golang
# ------------------------------
export GOPATH=$HOME/go
export PATH=$PATH:$HOME/.goenv/bin:$GOPATH/bin
export GO15VENDOREXPERIMENT=1
eval "$(goenv init -)"

# ------------------------------
# For java
# ------------------------------
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# ------------------------------
# For python
# ------------------------------
export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# ------------------------------
# For Ruby
# ------------------------------
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# ------------------------------
# For GCP
# ------------------------------
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kentomatsui/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/kentomatsui/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kentomatsui/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/kentomatsui/google-cloud-sdk/completion.zsh.inc'; fi

# ------------------------------
# For Node.js
# ------------------------------
export PATH=$HOME/.nodebrew/current/bin:$PATH

# ------------------------------
# For docker
# ------------------------------
fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh/vendor-completions $fpath)

#autoload -Uz compinit && compinit -i
autoload -U compinit
compinit
