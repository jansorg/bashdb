#!/bin/bash
# Towers of Hanoi
set -u

init() {
  _Dbg_debugger; :
}

hanoi() { 
  local -i n=$1
  local -r a=$2
  local -r b=$3
  local -r c=$4

  _Dbg_set_trace
  if (( n > 0 )) ; then
    (( n-- ))
    hanoi $n $a $c $b
    ((disc_num=max-n))
    echo "Move disk $n on $a to $b"
    if (( n > 0 )) ; then
       hanoi $n $c $b $a
    fi
  fi
}

if (( $# > 0 )) ; then
  builddir=$1
elif [[ -z ${builddir:-''} ]] ; then
  builddir=$PWD/..
fi

if (( $# > 1 )); then
  cmdfile=$2
else
  srcdir=${srcdir:-'.'}
  cmdfile=${srcdir}/data/settrace.cmd
fi

source ${builddir}/bashdb-trace -q -L .. -B  -x $cmdfile
typeset -i max=1
init
hanoi $max 'a' 'b' 'c'
_Dbg_debugger 1 _Dbg_do_quit
