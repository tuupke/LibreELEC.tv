# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inputattach"
PKG_VERSION="1.8.1"
PKG_SHA256="4da29745c782b7db18f5f37c49e77bf163121dd3761e2fc7636fa0cbf35c2456"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="https://sourceforge.net/projects/linuxconsole/"
PKG_URL="https://sourceforge.net/projects/linuxconsole/files/linuxconsoletools-${PKG_VERSION}.tar.bz2/download"
PKG_SOURCE_NAME="linuxconsoletools-${PKG_VERSION}.tar.bz2"
PKG_SOURCE_DIR="linuxconsoletools-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_LONGDESC="inputattach: attaches serial-line input devices to the kernel input layer. Built here only for its pulse8-cec line discipline, which turns a Pulse-Eight-protocol USB CEC adapter into a standard kernel CEC device (/dev/cecX) so libcec/Kodi can use it without USB VID:PID auto-detection."
PKG_TOOLCHAIN="manual"

# Only inputattach itself: skip the joystick calibration tools (jstest/jscal/...)
# and force-feedback tools (need SDL2), neither of which apply to CEC dongles.
make_target() {
  make -C utils compile \
       CC="${CC}" \
       CFLAGS="${CFLAGS}" \
       LDFLAGS="${LDFLAGS}" \
       PKG_CONFIG="${PKG_CONFIG}" \
       DISABLE_JOYSTICK=1 \
       DISABLE_FORCEFEEDBACK=1 \
       SYSTEMD_SUPPORT=1
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp utils/inputattach ${INSTALL}/usr/bin
}
