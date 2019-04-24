#!/bin/sh
#
# This script is based on:
# https://docs.google.com/document/d/1Pvf9Yxorcd3sbgs8WcomcTl3J4bmX6e1UE0ROCefR88

set -e

usage() {
	echo "This script converts a flat file into an ELF, that can be passed"
	echo "to SPIKE, the RISC-V reference emulator."
	echo ""
	echo "Usage: $0 coreboot.rom coreboot.elf"
}

if [ $# -ne 2 ]; then
	usage
	exit 1
fi

FLAT_FILE="$1"
OBJECT_FILE=$(mktemp /tmp/coreboot-spike.XXXXXX)
ELF_FILE="$2"
TOOL_PATH="$(dirname "$0")"
CROSS_COMPILE=${CROSS_COMPILE:="$TOOL_PATH/../crossgcc/xgcc/bin/riscv64-elf-"}
TARGET=${TARGET:=elf64-littleriscv}

"${CROSS_COMPILE}objcopy" -I binary -O $TARGET -B riscv "$FLAT_FILE" "$OBJECT_FILE"

"${CROSS_COMPILE}ld" -b $TARGET "$OBJECT_FILE" -T "$TOOL_PATH/spike-elf.ld" -o "$ELF_FILE"

rm "$OBJECT_FILE"
