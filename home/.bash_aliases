#echo bash init run
EDITOR=mcedit;		export EDITOR
LANG=en_US.UTF-8;	export LANG
PATH="$PATH:$HOME/bin";	export PATH
CCACHE_PREFIX=distcc;	export CCACHE_PREFIX

nice="nice -n20"
screen_opt="-a -h 100000 -U"

alias mc="mc -x"
alias me="mcedit"
alias g="git"
alias s="svn"
alias m="$nice make"
alias gm="$nice gmake"
alias mj="time env CCACHE_PREFIX=distcc $nice make -j $(nproc || sysctl -n hw.ncpu || echo 2)"
alias mjv="mj V=1 VERBOSE=1"
alias ml="time env CCACHE_PREFIX=distcc $nice make -j -l $(nproc || sysctl -n hw.ncpu || echo 2)"
alias ml2="time env CCACHE_PREFIX=distcc $nice make -j -l $((`nproc || sysctl -n hw.ncpu || echo 2`*2))"
alias mjd="time env CCACHE_PREFIX=distcc $nice make -j `distcc -j || nproc || sysctl -n hw.ncpu || echo 4` -l $((`nproc || sysctl -n hw.ncpu || echo 2`*2))"
alias mjdz="time env CCACHE_PREFIX=distcc $nice make -j $((`distcc -j` >> 2)) -l $((`nproc || sysctl -n hw.ncpu || echo 2`*2))"

alias q='exit'
alias sc='screen -DR'
alias tf='tail -F'
alias jf='json_xs <'
alias dut='du | sort -rn | head -n 20'
ssc() { /usr/local/bin/ssh -t $* screen $screen_opt -DR || ssh -t $* screen $screen_opt -DR || ssh $*; }
#ssc() { /usr/local/bin/ssh -z $* screen -DR || ssh -t $* screen -DR; }
ssz() { /usr/local/bin/ssh -o "UserKnownHostsFile ~/.ssh/known_hosts_sctp" -z -t $* screen $screen_opt -DR; }
t() { perl -E "say map {scalar localtime \$_, qq{\n}} qw( $* )"; }
p() { perl -E "say q{}, sub{ $* }->()"; }
kd() { KDevelop.AppImage $* > /dev/null 2>&1 < /dev/null & }
cf() { cmd=`bash -c "compgen -c clang-format | grep 'clang-format-[[:digit:]]' | sort --version-sort --reverse | head -n1"`; $cmd -i $*; }
cmcc() { cmake -DCMAKE_C_COMPILER_LAUNCHER=`which ccache` -DCMAKE_CXX_COMPILER_LAUNCHER=`which ccache` $*; }


export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it
# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#alias postcmd 'echo -ne "^[k\!#:0^[\\"'

# If runing in screen, set the window title to the command about to be executed
#preexec () { :; }
#preexec_invoke_exec () {
#preexec() {
#echo preexec
#    [ -n "$WINDOW" ] && print -Pn "^[k$2^[\\"
#if [[ "$TERM" == "screen" ]]; then
   #local CMD=${1[(wr)^(*=*|sudo|-*)]}
   #local CMD=${1}
   #echo -n "\ek$CMD\e\\"
#    printf "\033k$1\033\\"
#fi
#}
#trap 'preexec_invoke_exec' DEBUG

# If in screen, blank the window title when displaying the prompt
#premd() {
#echo precmd
#    [ -n "$WINDOW" ] && print -Pn "^[k ^[\\"
#}


#case "$TERM" in
#  screen)
#      set -o functrace
#      trap 'echo -ne "\ek\$:${BASH_COMMAND:0:20}\e\\"' DEBUG
#      export PS1='\[\033k$:\W\033\\\]\u@\h:\w\$ '
#    ;;
#  *)
#    ;;
#esac

#LC_CTYPE=ru_RU.UTF-8;   export LC_CTYPE
#LC_ALL="ru_RU.UTF-8";   export LC_ALL
#LANG=ru_RU.UTF-8;       export LANG

#echo bash inited
#sleep 1