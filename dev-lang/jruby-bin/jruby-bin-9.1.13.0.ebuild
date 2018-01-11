# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="100% pure-Java implementation of the Ruby programming language"
HOMEPAGE="http://www.jruby.org/"
SRC_URI="http://jruby.org.s3.amazonaws.com/downloads/${PV}/${P}.tar.gz"
S="${WORKDIR}/jruby-${PV}"

LICENSE="EPL GPL2 LGPL2.1 custom"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	app-shells/bash
	>=virtual/jre-1.8
"
src_install() {
	local installpath="${ED}/opt/${PN}"
	dodir /opt/${PN}
	mv "${S}"/* "$installpath"
	find "$installpath" -type f -regextype posix-extended -regex '.*\.(bat|dll|exe)' -delete
	rm -r "$installpath"/lib/jni/{Darwin,*-SunOS,*-Windows,*-AIX,*-*BSD} || die "rm failed"
	rm -r "$installpath"/lib/ruby/stdlib/ffi/platform/{*-darwin,*-solaris,*-windows,*-aix,*-*bsd,*-cygwin} || die "rm failed"

	for f in jruby{,c} jirb{,_swing} jgem; do
		dosym /opt/${PN}/bin/${f} /usr/bin/${f}
	done
}
