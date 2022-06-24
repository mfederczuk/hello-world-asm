# A Hello World program in Assembly.
# Copyright (C) 2022  Michael Federczuk
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

.global _start

.section .rodata
hello_world_msg:
	.ascii "Hello, World!\n"
	hello_world_msg_size = . - hello_world_msg

.text
hello_world:
	movl $1, %eax # syscall: write
	movl $1, %edi # arg: fd
	movq $hello_world_msg, %rsi # arg: buf
	movq $hello_world_msg_size, %rdx # arg: count
	syscall
	ret

main:
	call hello_world
	movl $0, %eax
	ret

_start:
	call main
	movl %eax, %edi # arg: status
	movl $60, %eax # syscall: exit
	syscall
