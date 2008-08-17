# -*- shell-script -*-
# dbg-edit.sh - Bourne Again Shell Debugger Edit routines

#   Copyright (C) 2008 Rocky Bernstein rocky@gnu.org
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
#   with Bash; see the file COPYING.  If not, write to the Free Software
#   Foundation, 59 Temple Place, Suite 330, Boston, MA 02111 USA.

#================ VARIABLE INITIALIZATIONS ====================#

_Dbg_help_add edit \
"edit [LINESPEC]	- Edit specified file at location given.
If no location is given use the current location."

_Dbg_do_edit() {
  local -i line_number
  local editor=${EDITOR:-ex}
  if [[ -z "$1" ]] ; then
    line_number=$_curline
    full_filename=$_cur_source_file
  else
    _Dbg_linespec_setup $1
  fi
  if [[ ! -r $full_filename ]]  ; then 
      _Dbg_msg "File $full_filename is not readable"
  fi
  $($editor +$line_number $full_filename)
}
