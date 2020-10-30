# Maintainer: Tad <tad@spotco.us>
pkgname=brace
pkgver=20201030
pkgrel=2
pkgdesc="Increases privacy/security through various configs."
arch=('any')
license=('GPLv3')
optdepends=('arch-audit: check for insecure packages'
	'scrub: erase drive freespace'
	'firejail: sandbox programs'
	'linux-hardened: harden against kernel exploits'
	'rkhunter: scan for rootkits'
	'ufw: seal your ports'
	'firefox: browser')
source=('00-brace-gnome'
	'00-brace-mate'
	'00-brace-cinnamon'
	'00-brace-pantheon'
	'00-brace-extra'
	'dconf-profile-user'
	'30-nm-privacy.conf'
	'60-restrict.conf'
	'restic-backup@.service'
	'restic-backup@.timer'
	'blacklist-dma.conf'
	'blacklist-usbnet.conf'
	'brace-supplemental-changes.sh'
	'brace-installer.sh'
	'wireless-perf.conf'
	'chromium-brace.json'
	'firefox-brace.json'
	'brace-env-overrides.sh'
	'brace-helpers.sh'
	'userjs-brace.js'
	'userjs-brace-perf.js'
	'userjs-arkenfox.js'
	'userjs-pyllyukko.js')
sha512sums=('1f56a15df0002d0f55c5847249e2be287e465cc707d596a0a81fdc34aa07569a3f39b3a24826fa0c5ff2a61b73919de1898f1f39cbfc9fc5ce3afe2d20bcf1dd'
            '01c27019944d377ab8dc4e39986ffff1e03f49ed3e1958902836c81aa6e117ac1b30da8edaaa6397f7a24f3fb83b6f1a69641b89a33861739fb99885da032981'
            '7704320c2887b33e7ca02832c6d137aa610921281ed915c23c3ef4999ef35b96840733290b393a017066c3e610e6439bc88da8b1d2d82a945dbe0da3f1b06f31'
            'ecf9a3951359519f157e1bf2a433b4753e2cbb8b2dc921bd0349903ba09360b5938a017cc4dbd859040ae851c6be6ed12903eca2aaee3c7367e47dac6da30e2d'
            '2990c212bc0b3be152d72703fc3c8717ec18423016f798ac1f3156df0e51a5125e264406eb96f4cd776c470c9289ef8ebe071dd06beaf2cc430d472ff0513ec9'
            '1314c63c629f5970820718aacab764457fbd51dd3dafa091b437bb5cf0ebde8448668dfe2ff7f7d659bd1b005cbb41cd0b65e978e48915b04ea43ae772364633'
            '6e585be661b1494f285356b56eafe9a501674e5d8502f8562d2ee7e33715c50a67c5eca178bef69d602d407cdd309a5ef7bbddc6e0a33002ebb7ca6598b79528'
            'c13b4dc3af72fd33972029491927bf42c50faa4677d1f4ad268e12a2196f5c7a49122083a767709ee1a70472a5ee90fbfc876d97f876982e7a429674575e1abd'
            'b6bf26fe2bab314685cbb1d0568675d57bd1ef7dcec09b9d824400d6e83bee28bbf3b9247ce797a2fff6a2a021d40e3fe25b91b52db54bf482d49575f3daa37f'
            '39e44e8c7bf9f173d2f057adcdeeddc9137dc716de9ad8e005d5c2aebad052949e8bfa1db6e299baa3eaab1944f35323a5f71f44cfb636dfc5d9b27510a03bc2'
            'ba57603a85b3e25f8146269cadbb4953b6b3d66a25e251b1478fc85704c884eb56ef8b1cd17a547631d5778ffab37fd212c9cf0eb0525e4c46b9c7418836146a'
            '7f7d833f4b1437a99e0f30e6dd3b474ac75a52f830864f88b2d1337845daa59e46b4558437568067a7040c7d6bb72bdecc5490fedb71ac8049dccafb334bdda1'
            'dcce61eaeeca07e4dc5fa18521b226d0744dae2961fcc64173707e02dff09630ec3e140796172e28a45a228f01a8f65c6fa129432dad464302e6f6514545f3a3'
            '72db725c82db947e2ac5b683761132d06a9dd6032769445474bf3df0bef7948de34a3e5093168f934287f9f3801052fd1a108ef3ebf9567052cf112887f14e53'
            'd60121d7746936387e058287008ba720c7b389c25cb9654527ccc81a2ce2523ce343fc89f61005a6376e814319c959a794ada076addbe2639971ff0bbee001c5'
            'd41501a809efb33bb3225667468cad44025509350f30614bcc4693bf53329d86f681ad6b44e78cc4a98b21ecd2b97a39511587d0c7fdd21d38fb70cd75d66a66'
            '24b4f92440316f4515b82396d63e85ed926837a16cb84d90e8fd8111527b55282527ceea1c4745efaa6684d44870c3f000e222047bde14870c363dbcb3dbf4d3'
            'ca60082f96bb6c02583f774dd6fa384bcb8ccc65286c8f3cb51d7570a281057a8b44ffabb05c588d717934aaf27498235d7abd5c6d7136844b425f8140f4d6f8'
            'f0e76695a172adcbcfa0093308894165e45d4ce8834115c3727d5bcddcd3304572a7a208317add97a703fdb4aac7aaefd2444baf5e4cc0cda49fec2d6608cb71'
            '6a2e9b714cdc5207d81779dce622ce1ca9a7335e7194b7fb4d70187fcdcf195e21a8e0e549ba00fabc14da7c83f9f8826860afa7c00dd3381a07bef6eb941ef4'
            'df5f83c87ab6b8d504fc723745cfbdd466eef73588a336aa36ea2138a8774bda6f4e5d5962d29be8f7c49cda338077c77f9cd0f4ad9d229a708e299d20bc0bce'
            'c16c382baa61067cb94f56cf2561f4b23c99c83154a817814deb162ac94a8cb6fdd6af83bd42396487a97a056150dcab9c023befa52fd35b9667764292fde4ca'
            'b168818030095032e1d7c417c1bd1dcce494751df2f78ed5193c07ad120bac8de4aac876d01446642295c6ef4603ac5cf97c53ca17a95cc6e971ec554f6610c1')
install=brace.install

package() {
  cd "$srcdir"
  install -Dm644 00-brace-gnome "$pkgdir"/etc/dconf/db/local.d/00-brace-gnome
  install -Dm644 00-brace-mate "$pkgdir"/etc/dconf/db/local.d/00-brace-mate
  install -Dm644 00-brace-cinnamon "$pkgdir"/etc/dconf/db/local.d/00-brace-cinnamon
  install -Dm644 00-brace-pantheon "$pkgdir"/etc/dconf/db/local.d/00-brace-pantheon
  install -Dm644 00-brace-extra "$pkgdir"/etc/dconf/db/local.d/00-brace-extra
  install -Dm644 dconf-profile-user "$pkgdir"/etc/dconf/profile/user
  install -Dm755 brace-env-overrides.sh "$pkgdir"/etc/profile.d/brace-env-overrides.sh
  install -Dm755 brace-helpers.sh "$pkgdir"/etc/profile.d/brace-helpers.sh
  install -Dm755 brace-supplemental-changes.sh "$pkgdir"/usr/bin/brace-supplemental-changes
  install -Dm755 brace-installer.sh "$pkgdir"/usr/bin/brace-installer
  install -Dm644 blacklist-dma.conf "$pkgdir"/usr/lib/modprobe.d/blacklist-dma.conf
  install -Dm644 blacklist-usbnet.conf "$pkgdir"/usr/lib/modprobe.d/blacklist-usbnet.conf
  install -Dm644 wireless-perf.conf "$pkgdir"/usr/lib/modprobe.d/wireless-perf.conf
  install -Dm644 30-nm-privacy.conf "$pkgdir"/usr/lib/NetworkManager/conf.d/30-nm-privacy.conf
  install -Dm644 60-restrict.conf "$pkgdir"/usr/lib/sysctl.d/60-restrict.conf
  install -Dm644 restic-backup@.service "$pkgdir"/usr/lib/systemd/user/restic-backup@.service
  install -Dm644 restic-backup@.timer "$pkgdir"/usr/lib/systemd/user/restic-backup@.timer
  mkdir -p "$pkgdir"/etc/chromium/policies/managed/
  install -Dm644 chromium-brace.json "$pkgdir"/etc/chromium/policies/managed/brace.json
  mkdir -p "$pkgdir"/etc/opt/chrome/policies/managed/
  install -Dm644 chromium-brace.json "$pkgdir"/etc/opt/chrome/policies/managed/brace.json
  install -Dm644 firefox-brace.json "$pkgdir"/usr/lib/firefox/distribution/policies.json
  mkdir -p "$pkgdir"/usr/lib/firefox/browser/defaults/preferences/
  install -Dm644 userjs-*.js "$pkgdir"/usr/lib/firefox/browser/defaults/preferences/
  mkdir -p "$pkgdir"/usr/lib/thunderbird/defaults/preferences/
  install -Dm644 userjs-*.js "$pkgdir"/usr/lib/thunderbird/defaults/preferences/
}
