# -*- shell-script -*-
# continue.sh - gdb-like "continue" debugger command
#
#   Copyright (C) 2002, 2003, 2004, 2005, 2006, 2008 Rocky Bernstein
#   rocky@gnu.org
#
#   bashdb is free software; you can redistribute it and/or modify it under
#   the terms of the GNU General Public License as published by the Free
#   Software Foundation; either version 2, or (at your option) any later
#   version.
#
#   bashdb is distributed in the hope that it will be useful, but WITHOUT ANY
#   WARRANTY; without even the implied warranty of MERCHANTABILITY or
#   FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
#   for more details.
#   
#   You should have received a copy of the GNU General Public License along
#   with bashdb; see the file COPYING.  If not, write to the Free Software
#   Foundation, 59 Temple Place, Suite 330, Boston, MA 02111 USA.

# Print a stack backtrace.  
# $1 is an additional offset correction - this routine is called from two
# different places and one routine has one more additional call on top.
# $2 is the maximum number of entries to include.
# $3 is which entry we start from; the "up", "down" and the "frame"
# commands may shift this.

_Dbg_help_add continue \
'continue [LOCSPEC | - ]	-- Continue execution until the next breakpoint or end of program or location specification LOCSPEC. 

If instead of a line specification you enter -, then debugging will be turned 
off after continuing causing your program to run at full speed.'

function _Dbg_help_continue {
    _Dbg_msg \
"c [linespec | - ]  Continue execution until the next breakpoint or end of 
                   program or linespec. 

If instead of a line specification you enter -, then debugging will be turned 
off after continuing causing your program to run at full speed.
Long command name: continue.
"
}

function _Dbg_do_continue {

  _Dbg_not_running && return 1

  [[ -z $1 ]] && return 0
  typeset filename
  typeset -i line_number
  typeset full_filename

  if [[ $1 == '-' ]] ; then
    _Dbg_restore_debug_trap=0
    return 0
  fi

  _Dbg_linespec_setup $1

  if [[ -n $full_filename ]] ; then 
    if (( $line_number ==  0 )) ; then 
      _Dbg_msg 'There is no line 0 to continue at.'
    else 
      _Dbg_check_line $line_number "$full_filename"
      (( $? == 0 )) && \
	_Dbg_set_brkpt "$full_filename" "$line_number" 1 1
      return 0
    fi
  else
    _Dbg_file_not_read_in $filename
  fi
  return 1
}

