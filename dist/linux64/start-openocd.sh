#!/bin/sh
topdir=$(readlink -f $(dirname $0))

$topdir/bin/openocd -f "$topdir/scripts/interface/ftdi/flyswatter2.cfg" -f "$topdir/scripts/board/quark_se.cfg"
