# zshの起動が遅くなったときにプロファイルを見る用
#zmodload zsh/zprof && zprof

alias vim='nvim'
alias vi='nvim'

# ------------------------------
# General Settings
# ------------------------------
export EDITOR=vim        # エディタをvimに設定
export LC_ALL=ja_JP.UTF-8 # 文字コードをUTF-8に設定
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
fpath=(/usr/local/share/zsh-completions /usr/local/share/zsh/vendor-completions $fpath)
autoload -Uz compinit && compinit                   # 補完機能を有効にする
setopt auto_list                                    # 補完候補を一覧で表示する(d)
setopt auto_menu                                    # 補完キー連打で補完候補を順に表示する(d)
setopt list_packed                                  # 補完候補をできるだけ詰めて表示する
setopt list_types                                   # 補完候補にファイルの種類も表示する
bindkey "^[[Z" reverse-menu-complete                # Shift-Tabで補完候補を逆順する("\e[Z"でも動作する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # 補完時に大文字小文字を区別しない
setopt auto_param_slash                             # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs                                    # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt auto_param_keys                              # カッコの対応などを自動的に補完
setopt complete_in_word                             # 語の途中でもカーソル位置で補完
setopt always_last_prompt                           # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt brace_ccl                                    # 範囲指定できるようにする (例 : mkdir {1-3} で フォルダ1, 2, 3を作れる)
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
# プロンプトに色を付ける
autoload -U colors; colors
# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
# ファイル補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# 色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad
# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS
# lsコマンド時、自動で色がつく
export CLICOLOR=true
# オブジェクトファイルとか中間ファイルとかはfileとして補完させない
zstyle ':completion:*:*files' ignored-patterns '*?.o' '*?~' '*\#'

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

### PATH ###
export PATH=/usr/local/sbin:$PATH

### Aliases ###
alias ll='ls -l'

# ------------------------------
# For golang
# ------------------------------
export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$HOME/go/bin:$PATH
eval "$(goenv init -)"

# ------------------------------
# For Rust
# ------------------------------
export PATH="$HOME/.cargo/bin:$PATH"

# ------------------------------
# For java
# ------------------------------
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# ------------------------------
# For python
# ------------------------------
export PYENV_ROOT=/usr/local/var/pyenv
eval "$(pyenv init -)"

# ------------------------------
# For Ruby
# ------------------------------
eval "$(rbenv init -)"

# ------------------------------
# For docker
# ------------------------------
alias use-minikube-docker='eval $(minikube docker-env)'

# ------------------------------
# For k8s
# ------------------------------
source <(kubectl completion zsh)

# zshの起動が遅くなったときにプロファイルを見る用
#if (which zprof > /dev/null 2>&1) ;then
#  zprof
#fi
