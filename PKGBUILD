# Maintainer: Tad <tad@spotco.us>
pkgname=brace
pkgver=1.8
pkgrel=4
pkgdesc="Increases privacy/security through various configs. Firefox hardening credit: @pyllyukko"
arch=('any')
license=('GPLv3')
optdepends=('arch-audit: check for insecure packages'
	'extirpater: erase drive freespace'
	'firejail: sandbox programs'
	'linux-hardened: harden against exploits'
	'rkhunter: scan for rootkits'
	'scfw: seal your ports'
	'firefox: browser')
source=('00-gnome_defaults'
	'21-disable-connectivity-check.conf'
	'30-mac-randomization.conf'
	'60-restrict.conf'
	'blacklist-dma.conf'
	'blacklist-usbnet.conf'
	'brace-supplemental-changes.sh'
	'brace-arch-installer.sh'
	'iwlwifi.conf'
	'dnu.service'
	'helpers.sh'
	'user.js.sh'
	'https://raw.githubusercontent.com/pyllyukko/user.js/master/user.js')
sha512sums=('3698215587472c6d96d4defb4275269f087ad9728f6b0e2b174caced0dd21c3f1eeda733b6563cc1666cb84660a7583a990052dd6ca8ddb3dffc0720955fc3ff'
            '8ec47524685a59ed1ca45d5ba5334248cc505c07d71f1340d77a20e96e647b32c7a10cac1f1a2e32b0477a53c7ce14c57e839057b2b4fe7191932001c5679364'
            'cd03db723b789e9084cc2474edb3bf3f878cc5a751b437f69dd6f06a8015070e7c3f6750b581c15524e869f9fd8dd7db7eff9dad0650930e04387f5a36b4510e'
            'a6aceec23666bc7788c43d649e89ed5da0eaf637671e456d12a6de593fff459601a7d4a2bd1ae7707260faea80cfba382f8a785bfecfffaec51b6e1be259ac2f'
            'fcee1964b26f4309f20c8917a71d448e26f0f2c340ccea0a67f99d704dd009249d09aa215bd2424e234bc9b7927e4679043c2dad78f3fe8e8d744b07485ae655'
            '7f7d833f4b1437a99e0f30e6dd3b474ac75a52f830864f88b2d1337845daa59e46b4558437568067a7040c7d6bb72bdecc5490fedb71ac8049dccafb334bdda1'
            'a9e9630fe35bee1a2b25116f666f476c63d8160112701261bf5e127b4b127f4bbab076182a604544c239ed495ff6620684af52e2a82438f56e48909e5c510434'
            'b242571cc0b23794a1d627ecae2d2bae5aa067cf169d1230c57c8257fc0b2b6bc32b9a47dbc0ad166065f86dd1cf9d952aa51ae26fc4324bf492588f7592ecf7'
            'c07d4f5d591a07db530deb77065e488e788fd964c081c2859cee07cb0820c69ab8236b8713425c77b47a75435907643cd9a021719f7389c09b20787df1b0860b'
            '2bb7c4306b94687583caf5db2a8c384ffeeedcbaba72acc96a686e91a49c48e7b73a34e2dba74f8532d59ee250560fc6bf819e1308e37d9028d2138297d18b94'
            '68f29b8c373a06ff4e8ed842717e7d7497d3f99f5ac68c6314534652d0080c64934e780c7c3ec324bcee84a1b905fe5db813589bcf9b37937a11810570a6611f'
            'e3933ab309cb9b26266283de62f067602f7483e58ea625b63959b2cc6bf8f6281ef7dc1ec2be88f3ca380eae397fcb748ced8ca6b4a9dd9fe4de84778be173e7'
            '6c7d60e6cb655e3b8931a1afeab7a39cfd37672eb639f0c93c7d6acffa5ed885ebf065cc5c1a18783f206dbb94f74ad4fad3292054511217727db320b1ff02d4')
install=brace.install

build() {
	sh user.js.sh user.js;
}

package() {
  cd "$srcdir"
  install -Dm644 00-gnome_defaults "$pkgdir"/etc/dconf/db/local.d/00-brace-gnome
  install -Dm755 helpers.sh "$pkgdir"/etc/profile.d/helpers.sh
  install -Dm755 brace-supplemental-changes.sh "$pkgdir"/usr/bin/brace-supplemental-changes
  install -Dm755 brace-arch-installer.sh "$pkgdir"/usr/bin/brace-installer
  install -Dm644 blacklist-dma.conf "$pkgdir"/usr/lib/modprobe.d/blacklist-dma.conf
  install -Dm644 blacklist-usbnet.conf "$pkgdir"/usr/lib/modprobe.d/blacklist-usbnet.conf
  install -Dm644 iwlwifi.conf "$pkgdir"/usr/lib/modprobe.d/iwlwifi.conf
  install -Dm644 21-disable-connectivity-check.conf "$pkgdir"/usr/lib/NetworkManager/conf.d/21-disable-connectivity-check.conf
  install -Dm644 30-mac-randomization.conf "$pkgdir"/usr/lib/NetworkManager/conf.d/30-mac-randomization.conf
  install -Dm644 60-restrict.conf "$pkgdir"/usr/lib/sysctl.d/60-restrict.conf
  install -Dm644 dnu.service "$pkgdir"/usr/lib/systemd/system/dnu.service
  install -Dm644 user.js "$pkgdir"/usr/lib/firefox/browser/defaults/preferences/all-brace.js
}
