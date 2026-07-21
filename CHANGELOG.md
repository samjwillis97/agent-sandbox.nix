# Changelog

## [3.0.0](https://github.com/samjwillis97/agent-sandbox.nix/compare/v2.2.1...v3.0.0) (2026-07-21)


### ⚠ BREAKING CHANGES

* declared rwDirs/rwFiles must exist before launch
* fail closed on git identity instead of fabricating one
* Renamed extraEnv → env. Pure rename; semantics unchanged.

### Features

* add _proxyRedirects private arg to sandbox ([a1000ce](https://github.com/samjwillis97/agent-sandbox.nix/commit/a1000ce130f03d47f5e00eeaf93f7f54437b6a3e))
* add /bin/sh to path ([b5989f8](https://github.com/samjwillis97/agent-sandbox.nix/commit/b5989f89b814648e3cb075a262ee47dc7f5e56e3))
* add claude-nix shell.nix ([76dae03](https://github.com/samjwillis97/agent-sandbox.nix/commit/76dae037721b1e9fc83f483631fa84af60acc34d))
* **allowLocalPorts:** Add cross-platform localNetworkAccess targets ([#68](https://github.com/samjwillis97/agent-sandbox.nix/issues/68)) ([3a0930a](https://github.com/samjwillis97/agent-sandbox.nix/commit/3a0930a2dc9e24d9f93d4c7998f36b1a0a5d272d))
* bash non interactive warning on darwin ([2c187f6](https://github.com/samjwillis97/agent-sandbox.nix/commit/2c187f62f2d646f7d7a528267d9f6123ef877923))
* bind symlinked state files on linux ([f2c39b9](https://github.com/samjwillis97/agent-sandbox.nix/commit/f2c39b9d8b898d21658f3a2b9dba61a72e19c5cb))
* bindRepoRoot param ([0bda54c](https://github.com/samjwillis97/agent-sandbox.nix/commit/0bda54c1c784fbeafe5dc4fe3db17a79ba8a6fb6))
* block dns resolution on linux when restrictNetwork=true ([fa26718](https://github.com/samjwillis97/agent-sandbox.nix/commit/fa26718aee3186c60f492ea84676e19931766da6))
* CI for PRs into main ([45a5a50](https://github.com/samjwillis97/agent-sandbox.nix/commit/45a5a5070603e93aeed90dae1074818715f4d607))
* ci on PRs to main ([51d1323](https://github.com/samjwillis97/agent-sandbox.nix/commit/51d13239300fd51c5fcff084d466b45ad1f4c860))
* **darwin:** add opt-in listener binding ([d1bae0d](https://github.com/samjwillis97/agent-sandbox.nix/commit/d1bae0d9bc2da4189e1d0e18c67791f7235f712b))
* **darwin:** add opt-in listener binding ([0941e98](https://github.com/samjwillis97/agent-sandbox.nix/commit/0941e9809b89a8860d6dab68dfd91f45faea3cc4))
* **darwin:** allow optional Unix socket connects ([79b6c02](https://github.com/samjwillis97/agent-sandbox.nix/commit/79b6c02c6915029ad3e0a16ea8565da7417699c0))
* **darwin:** allowNix ([6cea43e](https://github.com/samjwillis97/agent-sandbox.nix/commit/6cea43e701186fd8d636bf39f871f06a1f5af0bc))
* debug steps ([85b7e7e](https://github.com/samjwillis97/agent-sandbox.nix/commit/85b7e7e19f9010f23f05a2f74b687143d2136879))
* declared rwDirs/rwFiles must exist before launch ([1342f80](https://github.com/samjwillis97/agent-sandbox.nix/commit/1342f808651dd3fe71b28a033158dd76b1df0117))
* fail closed on git identity instead of fabricating one ([f1122d1](https://github.com/samjwillis97/agent-sandbox.nix/commit/f1122d1b920831ee6463420eefd8b8206f46a14e))
* go proxy ([10d8ecb](https://github.com/samjwillis97/agent-sandbox.nix/commit/10d8ecbd6968771ee3d9b77aac137521333be37f))
* license ([4d5b41e](https://github.com/samjwillis97/agent-sandbox.nix/commit/4d5b41eced852c916b135ba7217576e6e0887dec))
* **linux:** allowNix ([9f0219d](https://github.com/samjwillis97/agent-sandbox.nix/commit/9f0219da1156a206573dcf5ddd117bf10c43aee5))
* make bash required ([a7d1399](https://github.com/samjwillis97/agent-sandbox.nix/commit/a7d1399a726008afb0d3281456af5f2dc6f499d0))
* network restrictions ([7dd28bf](https://github.com/samjwillis97/agent-sandbox.nix/commit/7dd28bf695aee4b4b45df8ace075299dd9b7d332))
* **proxy:** add tls tunnel (passthrough) domain policy ([15f96b9](https://github.com/samjwillis97/agent-sandbox.nix/commit/15f96b91c2c4ce831debf6e00cf127743980d0b5))
* **README:** allowNix ([bcea1b2](https://github.com/samjwillis97/agent-sandbox.nix/commit/bcea1b28f4ed2c4aff2d2672152d6963f0e5604d))
* rename API args and replace restrictNetwork with allowedDomains ([a2ee921](https://github.com/samjwillis97/agent-sandbox.nix/commit/a2ee921d1ff2b158d8391fb5f22ca5774d5955f8))
* restrict nix/store access to allowedPackages ([2ef361a](https://github.com/samjwillis97/agent-sandbox.nix/commit/2ef361a87c3919055dcd4bb999fd994c9df342ed))
* roDirs and roFiles read-only bind primitives ([54066d0](https://github.com/samjwillis97/agent-sandbox.nix/commit/54066d013545451f1bda2974497ef000c4ae2608))
* roDirs and roFiles read-only bind primitives ([5f8ce44](https://github.com/samjwillis97/agent-sandbox.nix/commit/5f8ce44c26c0cfca299f9ac9c534dfe9d1be4773))
* templates ([0fea2e9](https://github.com/samjwillis97/agent-sandbox.nix/commit/0fea2e99e120fd9a31d9f032b22d0217b7bd5d5f))
* templates ([0d53dfd](https://github.com/samjwillis97/agent-sandbox.nix/commit/0d53dfdf4d175b26ac2e382c274f7c96916d06a3))
* tests and CI ([8be5e02](https://github.com/samjwillis97/agent-sandbox.nix/commit/8be5e02e082c5a6a396f074224bdf93f0bd74250))
* timestampt network logs ([4b4f14f](https://github.com/samjwillis97/agent-sandbox.nix/commit/4b4f14fd567eda14e5915c6f79f9b60364ce3edd))
* update README.md ([83f018a](https://github.com/samjwillis97/agent-sandbox.nix/commit/83f018aeaf09c9ad091d310285a4b537ec0e5892))
* use ephemeral HOME on macOS ([f6c7ac5](https://github.com/samjwillis97/agent-sandbox.nix/commit/f6c7ac58338752ea9fb567813566ff1db210d2f1))
* write proxy port to fifo ([e1a9202](https://github.com/samjwillis97/agent-sandbox.nix/commit/e1a92023aa35a6dc4e15122c2305302dd4d255f1))
* write proxy port to fifo ([5ee023e](https://github.com/samjwillis97/agent-sandbox.nix/commit/5ee023e3f8a98fd96f65dc8da46fbec316cd1094))


### Bug Fixes

* add cacert to closure ([41199ee](https://github.com/samjwillis97/agent-sandbox.nix/commit/41199eec4867e79878995d62e76a39f8a10b9c8f))
* add intermediate symlinks to bubblewrap sandbox ([95d80d8](https://github.com/samjwillis97/agent-sandbox.nix/commit/95d80d8b539508afdcd0ead5cacbda967b5f37b1))
* add retries to curl tests ([1773656](https://github.com/samjwillis97/agent-sandbox.nix/commit/1773656f417e213850f34ddc213351fc7d80866a))
* block TCP to pasta gateway on non-proxy ports ([84828d6](https://github.com/samjwillis97/agent-sandbox.nix/commit/84828d6d04ff1cc660bf91cdd55b69f31ab38b67))
* CLAUDE_CONFIG_DIR update ([3a701d8](https://github.com/samjwillis97/agent-sandbox.nix/commit/3a701d86d93cc58572e181e92ea15fa9ff5575d8))
* **claude:** add .claude.json.lock ([eeba61b](https://github.com/samjwillis97/agent-sandbox.nix/commit/eeba61bc4bee4db503db3ac484d9090e97097218))
* **darwin:** allow IPv4 loopback binds ([0f71e8e](https://github.com/samjwillis97/agent-sandbox.nix/commit/0f71e8eef5f22681ecb3a909e8251f8397693f90))
* **darwin:** allow subshell exec ([6d8b239](https://github.com/samjwillis97/agent-sandbox.nix/commit/6d8b239b7bd57f5d27366ef63eec6ebfc96df0be))
* **darwin:** deny kern.proc* sysctls ([436436a](https://github.com/samjwillis97/agent-sandbox.nix/commit/436436a69adf422883d516bdde0e6c9c1e5e6225))
* **darwin:** don't load bash profile ([8673940](https://github.com/samjwillis97/agent-sandbox.nix/commit/867394086f4de95317c41c8270200264f07e1a4f))
* **darwin:** dummy private/etc/passwwd ([7bfa770](https://github.com/samjwillis97/agent-sandbox.nix/commit/7bfa770296d7722a35fa4893f6a2a459dd7a0e2d))
* **darwin:** file-read-metadata not file-read* for traversal ([f7fb67b](https://github.com/samjwillis97/agent-sandbox.nix/commit/f7fb67be3d600c47de73320fdb894e99899b7494))
* **darwin:** file-read-metadata not file-read* for traversal ([5fc2886](https://github.com/samjwillis97/agent-sandbox.nix/commit/5fc2886008d162ab25596987011f587e0b513640))
* **darwin:** file-read-metadata traversal + process-exec sandbox HOME ([9d35012](https://github.com/samjwillis97/agent-sandbox.nix/commit/9d35012e9bdec268388d0a47988c50d970ef2e47))
* **Darwin:** fix whitespace string issue for allowedLocalPort seatbelt str ([637511e](https://github.com/samjwillis97/agent-sandbox.nix/commit/637511e5fc7613804e6a4643eea9c73494e35c53))
* **darwin:** grant file-read-metadata on ancestor dirs between HOME and CWD ([bd10d4f](https://github.com/samjwillis97/agent-sandbox.nix/commit/bd10d4f1f0fb2d57261e11bc7996b2b9c5dbf10a))
* **darwin:** limit outbound localhost to proxy ([90b848b](https://github.com/samjwillis97/agent-sandbox.nix/commit/90b848b5d7ccdbc1469970d325f9cbd14ea16fac))
* **darwin:** make .git/hooks and .git/config read-only in sandbox ([ac3616e](https://github.com/samjwillis97/agent-sandbox.nix/commit/ac3616ec6732694e2aec0553a28cd55c701517d5))
* **darwin:** max private/var unreachable ([d5d10be](https://github.com/samjwillis97/agent-sandbox.nix/commit/d5d10becb74ae4366ce48a82323cb0935eae0dc7))
* **darwin:** process exec plutil ([8083620](https://github.com/samjwillis97/agent-sandbox.nix/commit/80836207c84783f73239411662c967e3ed85a719))
* **darwin:** process-exec sandbox home ([e4ee582](https://github.com/samjwillis97/agent-sandbox.nix/commit/e4ee58222ce266c11965f5c51993544063240daf))
* **darwin:** process-exec sandbox home ([f7742d1](https://github.com/samjwillis97/agent-sandbox.nix/commit/f7742d145236d6250c55e4118c222420337fdeb9))
* **darwin:** resolve real nix daemon socket path ([2e9dd51](https://github.com/samjwillis97/agent-sandbox.nix/commit/2e9dd5171b70bb0c727b16f21bdf2351fd285f6c))
* **darwin:** rm /Library/Preferences read + plutil exec ([33ad129](https://github.com/samjwillis97/agent-sandbox.nix/commit/33ad129495ccd43e641f77a1038afb88e7edf493))
* **darwin:** rm unix socket access ([74a28c3](https://github.com/samjwillis97/agent-sandbox.nix/commit/74a28c3f495ec904e4fa20b5ab8be78d4550d8a9))
* **darwin:** test-unix-socket* - use nix provided python3 ([89abb40](https://github.com/samjwillis97/agent-sandbox.nix/commit/89abb40ff8e5ea49d664746acce0ae9747aea101))
* **default.nix:** missing ; ([297df91](https://github.com/samjwillis97/agent-sandbox.nix/commit/297df919ab7b3d7afbefef41b9e240fe919f845a))
* disable .git discovery when $HOME==$REPO_ROOT ([72ac65c](https://github.com/samjwillis97/agent-sandbox.nix/commit/72ac65c108761af326e8403c40a736ae755a6b92))
* ensure etc/hosts exists on linux ([d4d1993](https://github.com/samjwillis97/agent-sandbox.nix/commit/d4d19939aff52b3334b3315ff26e5836f8ab074d))
* ensure traversal from cwd to stateDirs and stateFiles ([d91aa0c](https://github.com/samjwillis97/agent-sandbox.nix/commit/d91aa0c0685514f6a4bd89de40f3826f98ba131f))
* ensure usr/bin/env on linux ([30e6ce7](https://github.com/samjwillis97/agent-sandbox.nix/commit/30e6ce7715ccb67bc1461b062deddaa37f1b6079))
* example / debug shells ([eaebac0](https://github.com/samjwillis97/agent-sandbox.nix/commit/eaebac002ca802dee898316a37b607d50f6cc41a))
* **example.shell.nix:** config.allowUnfree=true ([f72a30d](https://github.com/samjwillis97/agent-sandbox.nix/commit/f72a30dbb3311fd923f63bd5082bd8069c6f1bad))
* exec froms state dirs ([3ca33b8](https://github.com/samjwillis97/agent-sandbox.nix/commit/3ca33b8d2f1eeff2d3e544de403b1b9127e51b1f))
* **linux:** bind proxy on 127.0.0.1 and route via pasta gateway to avoid leaking host LAN IP ([15e6725](https://github.com/samjwillis97/agent-sandbox.nix/commit/15e67255c95de9987ece24a0449e3c5d25d9f1f8))
* **linux:** bind proxy to host IP instead of 0.0.0.0 ([08bd8a6](https://github.com/samjwillis97/agent-sandbox.nix/commit/08bd8a62b4fefee7244c4bf427ba53160091fb63))
* **linux:** bind roFile/rwFile symlinks at their declared paths ([4c9cac0](https://github.com/samjwillis97/agent-sandbox.nix/commit/4c9cac00437dbfcdf26cf013e434da53a7954fa2))
* **linux:** clear bwrap environ to prevent host env leak via /proc/1/environ ([1a53cb6](https://github.com/samjwillis97/agent-sandbox.nix/commit/1a53cb617ac2b950bd042559d75eeedec81e7194))
* **linux:** don't follow symlinks when binding files ([67e7018](https://github.com/samjwillis97/agent-sandbox.nix/commit/67e70185e91eb98983a2dbeea73d870d57ef5477))
* **linux:** dummy private/etc/passwwd ([4362548](https://github.com/samjwillis97/agent-sandbox.nix/commit/43625485dd3949866bb0abd9adea1ab4427ce943))
* **linux:** isolate sandbox network from host local services ([c3be4b2](https://github.com/samjwillis97/agent-sandbox.nix/commit/c3be4b22ab45d32a2b4a02d78d51fbc5593a4869))
* **linux:** make .git/hooks and .git/config read-only in sandbox ([5e33e9b](https://github.com/samjwillis97/agent-sandbox.nix/commit/5e33e9b443c6e6a08ea8989b546b65ec67b1bb37))
* **linux:** make nftables deny default ([9eb1ee2](https://github.com/samjwillis97/agent-sandbox.nix/commit/9eb1ee2bdd27d6d73de49134e070a2222d4a4389))
* **linux:** mask /proc/cmdline and /proc/sys/kernel/random/boot_id ([ee715f5](https://github.com/samjwillis97/agent-sandbox.nix/commit/ee715f54f4de7ae63d9e04f175930ca7ee2cfc5e))
* **linux:** set neutral hostname in UTS namespace to prevent host leak ([2d164b7](https://github.com/samjwillis97/agent-sandbox.nix/commit/2d164b74b6b82c00fbdd6f8177f4595fe6003690))
* make nix store readable on darwin ([ddbd3c7](https://github.com/samjwillis97/agent-sandbox.nix/commit/ddbd3c7422af16809192d7a5e79761efe1c8f7f8))
* make nix store readable on darwin ([82f6c74](https://github.com/samjwillis97/agent-sandbox.nix/commit/82f6c74ca8dae3fa68d4185a52bbb1ea70789e5d))
* max-depth=1 for symlink search ([2fb9b6f](https://github.com/samjwillis97/agent-sandbox.nix/commit/2fb9b6f10588c98b6ab2459d0e7e0b5059bd9936))
* max-depth=1 for symlink search ([19407a0](https://github.com/samjwillis97/agent-sandbox.nix/commit/19407a0dfc5321a5d248e83db6535aab519996da))
* only allow state symlinks to nix store ([2523711](https://github.com/samjwillis97/agent-sandbox.nix/commit/25237110a6580ccad25e3cd80163c0c1e605a5be))
* **pasta:** use ipv4 ([f1f55e9](https://github.com/samjwillis97/agent-sandbox.nix/commit/f1f55e9702c97b380e7bc41dbf9472b3d006a77d))
* **proxy:** reject non-443 CONNECT and non-80 plaintext requests ([4880cf4](https://github.com/samjwillis97/agent-sandbox.nix/commit/4880cf43463c10235da9a74e3d7cf098ab538172))
* read dirname(/) bug ([f0263e3](https://github.com/samjwillis97/agent-sandbox.nix/commit/f0263e3eeb7320020a20b262a166533eabdbccc0))
* README.md ([2786343](https://github.com/samjwillis97/agent-sandbox.nix/commit/2786343b2175fd8996215993a56da060b12e2525))
* **README:** macos keychain workaround ([6350246](https://github.com/samjwillis97/agent-sandbox.nix/commit/6350246267c94f86ed0f876bb11ef651ef50e510))
* remove inheritPath ([2222a8c](https://github.com/samjwillis97/agent-sandbox.nix/commit/2222a8cc11d829a0523c49d33b2c7ce3702204a3))
* remove now redundant nix/store tests ([2070e1d](https://github.com/samjwillis97/agent-sandbox.nix/commit/2070e1de7ff533a40f8680cec7722ba27e600165))
* remove read access to real HOME directory in macOS sandbox ([b804a7b](https://github.com/samjwillis97/agent-sandbox.nix/commit/b804a7b982e895c292ea063ce8badfdf72dc19ce))
* resolve resolv.conf on ubuntu ([cc2d145](https://github.com/samjwillis97/agent-sandbox.nix/commit/cc2d1453b43269dc8c3869e4cee160cb7a1d385c))
* restrict /dev/tty access on macos ([471aae2](https://github.com/samjwillis97/agent-sandbox.nix/commit/471aae2d5e7c2e5b5bdd89d7d24711c6e80e10be))
* restrict /dev/tty access on macos ([aaf06d3](https://github.com/samjwillis97/agent-sandbox.nix/commit/aaf06d3a6378db22ee23877931a42e5eb3a6bcbf))
* rm .pem suffixes from mktemp calls ([97676d5](https://github.com/samjwillis97/agent-sandbox.nix/commit/97676d554e7d03079ac856ac58f43cae8003a5b0))
* rm python dependency in darwin tests ([76af178](https://github.com/samjwillis97/agent-sandbox.nix/commit/76af178967dd2caae3423578e954a3373b2b5612))
* **seatbelt:** various additions ([136841e](https://github.com/samjwillis97/agent-sandbox.nix/commit/136841e438b74e9d08a74317671819a4099db3c5))
* symlink test ([89d5d77](https://github.com/samjwillis97/agent-sandbox.nix/commit/89d5d7731ae3b1ed01c363639b2a5473a32a4984))
* **symlinks:** only skip seen dirs / files with real content ([287c68a](https://github.com/samjwillis97/agent-sandbox.nix/commit/287c68a2ff95cb8428b96feccb10e8e1a1648cd2))
* test module rename ([96161f7](https://github.com/samjwillis97/agent-sandbox.nix/commit/96161f709c47ffa4ba0e74b9fd70552dc7005675))
* **test-deep-cwd:** inverse system conditional ([d0ae4d9](https://github.com/samjwillis97/agent-sandbox.nix/commit/d0ae4d9bd6969bd603c57bbfe1f234543d999a2a))
* **tests:** use local proxy for tests ([a3cec8f](https://github.com/samjwillis97/agent-sandbox.nix/commit/a3cec8f60f61eaa9c4f2014d01d1ff127a528f65))
* use bashInteractive ([2dc4550](https://github.com/samjwillis97/agent-sandbox.nix/commit/2dc455059b18efbbdb93c94507e849efad08dc2c))
* use bashInteractive ([6050b01](https://github.com/samjwillis97/agent-sandbox.nix/commit/6050b0192e8987a21038fe780ca8443437557ef2))
* wrap bash with --norc and --noprofile ([7884844](https://github.com/samjwillis97/agent-sandbox.nix/commit/788484461495bf3aaaf6d99b32478a577b7e708c))
* write test output to repo ([204f895](https://github.com/samjwillis97/agent-sandbox.nix/commit/204f895ef65df0d3185599c1cfb9193fa2b66783))

## [2.2.1](https://github.com/archie-judd/agent-sandbox.nix/compare/v2.2.0...v2.2.1) (2026-07-13)


### Bug Fixes

* **Darwin:** fix whitespace string issue for allowedLocalPort seatbelt str ([637511e](https://github.com/archie-judd/agent-sandbox.nix/commit/637511e5fc7613804e6a4643eea9c73494e35c53))

## [2.2.0](https://github.com/archie-judd/agent-sandbox.nix/compare/v2.1.0...v2.2.0) (2026-07-10)


### Features

* **allowLocalPorts:** Add cross-platform localNetworkAccess targets ([#68](https://github.com/archie-judd/agent-sandbox.nix/issues/68)) ([3a0930a](https://github.com/archie-judd/agent-sandbox.nix/commit/3a0930a2dc9e24d9f93d4c7998f36b1a0a5d272d))

## [2.1.0](https://github.com/archie-judd/agent-sandbox.nix/compare/v2.0.1...v2.1.0) (2026-06-18)


### Features

* add claude-nix shell.nix ([76dae03](https://github.com/archie-judd/agent-sandbox.nix/commit/76dae037721b1e9fc83f483631fa84af60acc34d))
* **darwin:** allowNix ([6cea43e](https://github.com/archie-judd/agent-sandbox.nix/commit/6cea43e701186fd8d636bf39f871f06a1f5af0bc))
* **linux:** allowNix ([9f0219d](https://github.com/archie-judd/agent-sandbox.nix/commit/9f0219da1156a206573dcf5ddd117bf10c43aee5))
* **README:** allowNix ([bcea1b2](https://github.com/archie-judd/agent-sandbox.nix/commit/bcea1b28f4ed2c4aff2d2672152d6963f0e5604d))


### Bug Fixes

* **darwin:** resolve real nix daemon socket path ([2e9dd51](https://github.com/archie-judd/agent-sandbox.nix/commit/2e9dd5171b70bb0c727b16f21bdf2351fd285f6c))

## [2.0.1](https://github.com/archie-judd/agent-sandbox.nix/compare/v2.0.0...v2.0.1) (2026-06-16)


### Bug Fixes

* **linux:** bind roFile/rwFile symlinks at their declared paths ([4c9cac0](https://github.com/archie-judd/agent-sandbox.nix/commit/4c9cac00437dbfcdf26cf013e434da53a7954fa2))
* **linux:** don't follow symlinks when binding files ([67e7018](https://github.com/archie-judd/agent-sandbox.nix/commit/67e70185e91eb98983a2dbeea73d870d57ef5477))

## [2.0.0](https://github.com/archie-judd/agent-sandbox.nix/compare/v1.0.0...v2.0.0) (2026-06-13)


### ⚠ BREAKING CHANGES

* declared rwDirs/rwFiles must exist before launch
* fail closed on git identity instead of fabricating one

### Features

* declared rwDirs/rwFiles must exist before launch ([1342f80](https://github.com/archie-judd/agent-sandbox.nix/commit/1342f808651dd3fe71b28a033158dd76b1df0117))
* fail closed on git identity instead of fabricating one ([f1122d1](https://github.com/archie-judd/agent-sandbox.nix/commit/f1122d1b920831ee6463420eefd8b8206f46a14e))
* roDirs and roFiles read-only bind primitives ([54066d0](https://github.com/archie-judd/agent-sandbox.nix/commit/54066d013545451f1bda2974497ef000c4ae2608))
* roDirs and roFiles read-only bind primitives ([5f8ce44](https://github.com/archie-judd/agent-sandbox.nix/commit/5f8ce44c26c0cfca299f9ac9c534dfe9d1be4773))


### Bug Fixes

* resolve resolv.conf on ubuntu ([cc2d145](https://github.com/archie-judd/agent-sandbox.nix/commit/cc2d1453b43269dc8c3869e4cee160cb7a1d385c))

## [1.0.0](https://github.com/archie-judd/agent-sandbox.nix/compare/v0.1.1...v1.0.0) (2026-06-12)


### ⚠ BREAKING CHANGES

* Renamed extraEnv → env. Pure rename; semantics unchanged.

### Features

* rename API args and replace restrictNetwork with allowedDomains ([a2ee921](https://github.com/archie-judd/agent-sandbox.nix/commit/a2ee921d1ff2b158d8391fb5f22ca5774d5955f8))

## [0.1.1](https://github.com/archie-judd/agent-sandbox.nix/compare/v0.1.0...v0.1.1) (2026-06-10)


### Bug Fixes

* disable .git discovery when $HOME==$REPO_ROOT ([72ac65c](https://github.com/archie-judd/agent-sandbox.nix/commit/72ac65c108761af326e8403c40a736ae755a6b92))
