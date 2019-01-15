# $Header: $

EAPI="2"

inherit eutils toolchain-funcs multilib

DESCRIPTION="complete cross development package for 65(C)02 systems"
HOMEPAGE="https://cc65.github.io/cc65/"
SRC_URI="https://github.com/cc65/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

