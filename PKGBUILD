# Maintainer: Jack Spencer <alisamki@proton.me>
pkgname=archwiz
pkgver=1.0
pkgrel=1
pkgdesc="A CLI tool for managing Arch Linux packages with extra features"
arch=('any')
url="https://alisamki.github.io/archwiz"
license=('GPL3')
depends=('pacman' 'flatpak')
source=("archwiz.sh")
sha256sums=('SKIP')

package() {
    install -Dm755 "$srcdir/archwiz.sh" "$pkgdir/usr/bin/archwiz"
}