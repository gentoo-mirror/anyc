# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="https://libcoap.net/"
SRC_URI="https://github.com/obgm/libcoap/archive/refs/tags/v${PV}.tar.gz"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
#S="${WORKDIR}/${P}"

LICENSE="BSD-1 BSD-2 BSD public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+examples +openssl tests"

RDEPEND="openssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_EXAMPLES="$(usex examples)"
		-DENABLE_TESTS="$(usex tests)"
	)
	
	if use openssl; then
		mycmakeargs+=("-DDTLS_BACKEND=openssl")
	fi
	
	cmake_src_configure
}
