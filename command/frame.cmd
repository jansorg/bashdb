# -*- shell-script -*-
# frame.cmd - gdb-like "frame" debugger command
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

# Move default values down $1 or one in the stack. 
_Dbg_do_down() {
  _Dbg_not_running && return 1
  local -i count=${1:-1}
  _Dbg_adjust_frame $count -1
}

_Dbg_do_frame() {
  _Dbg_not_running && return 1
  local -i pos=${1:-0}
  _Dbg_adjust_frame $pos 0
}

# Move default values up $1 or one in the stack. 

_Dbg_do_up() {
  _Dbg_not_running && return 1
  local -i count=${1:-1}
  _Dbg_adjust_frame $count +1
}
