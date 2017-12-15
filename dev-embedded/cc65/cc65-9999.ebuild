# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6


DESCRIPTION="It's a complete cross development package for 65(C)02 systems."
HOMEPAGE="http://www.cc65.org"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

GIT_ECLASS="git-r3"
S="${WORKDIR}/${MY_P}"
EGIT_CHECKOUT_DIR=${S}
EXPERIMENTAL="true"

inherit eutils toolchain-funcs multilib ${GIT_ECLASS}

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

DEPEND="doc? ( app-text/linuxdoc-tools )"
RDEPEND=""

src_compile() {
	# the build needs to be split otherwise we can't specify CC
	# these makefiles are not parallel build aware
	emake -C src PREFIX=/usr bin || die "src build fail"
	emake -C libsrc PREFIX=/usr lib || die "libsrc build fail"
	if use doc; then emake -C doc PREFIX=/usr doc || die "doc build fail"; fi
}

src_install() {
	emake -C src PREFIX="${D}/usr" install || die 'Could not install binaries'
	emake -C libsrc PREFIX="${D}/usr" install || die 'Could not install libraries'
	if use doc; then emake -C doc PREFIX="${D}/usr" install || die 'Could not install docs'; fi
}
