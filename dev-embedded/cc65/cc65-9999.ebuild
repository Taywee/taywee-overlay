# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils toolchain-funcs multilib

DESCRIPTION="It's a complete cross development package for 65(C)02 systems."
HOMEPAGE="http://www.cc65.org"
SRC_URI="https://github.com/${PN}/${PN}/archive/master.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( app-text/linuxdoc-tools )"
RDEPEND=""

src_compile() {
	cd ${WORKDIR}/${PN}-master
	# the build needs to be split otherwise we can't specify CC
	# these makefiles are not parallel build aware
	emake -j1 -C src prefix=/usr bin || die "src build fail"
	emake -j1 -C libsrc prefix=/usr lib || die "libsrc build fail"
	if use doc; then emake -j1 -C doc prefix=/usr doc || die "doc build fail"; fi
}

src_install() {
	cd ${WORKDIR}/${PN}-master
	emake -C src prefix="${D}/usr" install || die 'Could not install binaries'
	emake -C libsrc prefix="${D}/usr" install || die 'Could not install libraries'
	if use doc; then emake -C doc prefix="${D}/usr" install || die 'Could not install docs'; fi
}
