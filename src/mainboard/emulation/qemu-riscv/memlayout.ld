/*
 * This file is part of the coreboot project.
 *
 * Copyright 2014 Google Inc.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#include <memlayout.h>
#include <arch/header.ld>

#define START 0x80000000

SECTIONS
{
	DRAM_START(START)
	BOOTBLOCK(START, 64K)
	STACK(START + 4M, 4K)
	ROMSTAGE(START + 4M + 64K, 128K)
	PRERAM_CBMEM_CONSOLE(START + 4M + 192K, 8K)
	RAMSTAGE(START + 4M + 200K, 16M)
}
