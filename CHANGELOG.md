### 2.9.4

Add support for Java '8u171/8u172' ([mtron](https://github.com/mtron))

### 2.9.3

* Add support for Java 9.0.4
* Fix "package is already installed" errors on RPM-based Linux distributions

### 2.9.2

* Add support for Java '8u161/8u162' ([mtron](https://github.com/mtron))
* Fix Oracle SSO in client/server setups

### 2.9.1

* Add support for Java '8u151/8u152'
* Add support for Java 9.0.1

### 2.9.0

* Add Oracle.com Single Sign-on authentication
  - re-enables downloads from the Oracle Java Archive
  - new parameters `ssousername`, `ssopassword`

### 2.8.3

* Add support for Java '8u144' ([mtron](https://github.com/mtron))
* Add support for Java 9

### 2.8.2

* Add support for Java '8u141' ([mtron](https://github.com/mtron))
* Tested on Debian 9, Ubuntu 17.10 and Mageia 6

### 2.8.1

* Add support for Java '8u131'
* Tested on Ubuntu 17.04 and SuSE 12 SP2

### 2.8.0

* Add support for Java '8u121'
* Ease the installation of new Java SE releases using optional parameters (without updating the module)
  - `build`
  - `urlcode`
* **Warning** the following parameters were replaced:
  - `custom_download_url`: renamed to `download_url` and complemented by a new `filename` parameter
  - `custom_checksum`: renamed to `checksum`

### 2.7.4

* Add proxy support via new parameters `proxy_server` and `proxy_type`
* Replace or remove calls to deprecated `validate_*` stdlib functions

### 2.7.3

* Unset `provider` parameter on all `archive` resources (from `puppet-archive` module)
  - quick and dirty workaround until [SERVER-94](https://tickets.puppetlabs.com/browse/SERVER-94) gets fixed
  - **Warning:** may break behind a HTTP proxy (untested)
* Tested on Fedora 25, Amazon Linux 2016.09

### 2.7.2

* Add support for Java '8u111'/'8u112' ([mtron](https://github.com/mtron))
* Contain included classes ([claytononeill](https://github.com/claytononeill))
* Tested on Ubuntu 16.10

### 2.7.1

Support Java 6 as extra installation

### 2.7.0

* Add support for Java '8u101'/'8u102'
* Restore support for Java '6u45' (main installation only)
* Tested on Fedora 24, OpenSUSE 42.1/42.2, Mageia 5

### 2.6.3

Add support for Java '8u91'/'8u92'

### 2.6.2

Add support for Java '8u77'

### 2.6.1

Add support for Java '8u71'/'8u72'

### 2.6.0

* Replace deprecated module dependency [nanliu-archive](https://forge.puppetlabs.com/nanliu/archive) with [puppet-archive](https://forge.puppetlabs.com/puppet/archive)
* Use *curl* as download provider instead of *faraday*

### 2.5.1

Fix regression that forced `format` to be set manually on non-RPM OS

### 2.5.0

New parameters ([angrox](https://github.com/angrox)):
* `install_path`: set Java installation path
* `custom_download_url`: download the Java package/archive from a custom URL
* `custom_checksum`: custom MD5 checksum for package/archive integrity verification

### 2.4.2

Add support for Java '8u65'/'8u66'

### 2.4.1

Add support for Java '8u60'

### 2.4.0

* New parameter `add_system_env` to set `JAVA_HOME` as system-wide environment variable
* Fix dependency issue when installing multiple Java alternatives
* Merge missing changes to `installation` defined type

### 2.3.0

Support multiple installations of Oracle Java with a new defined type: `oracle_java::installation`

### 2.2.7

Add support for Java '8u51'

### 2.2.6

Fix conflict introduced by [nanliu-archive](https://forge.puppetlabs.com/nanliu/archive/changelog) v0.3.0

### 2.2.4

* Add support for Java '7u79', '7u80' and '8u45'
* Minor Puppet 4.0 compatibility fix

### 2.2.3

Add support for Java '8u40'

### 2.2.2

Add support for Java '7u75', '7u76' and '8u31'

### 2.2.1

Improve code quality, doc and metadata

### 2.2.0

* Support adding Oracle Java as a java alternative
* New `add_alternative` parameter
* List of checksums now complete

### 2.1.0

* Added checksum check on downloaded archive
* New `check_checksum` parameter
* Refactoring
* Better support of Mageia Linux

### 2.0.0

* Support tar.gz format - now multiplatform!
* Dropped support for Java 6
* Major refactoring
* Use `nanliu/archive` module for download and extraction

### 1.1.5

Add support for Java '7u71', '7u72' and '8u25'

### 1.1.4

* Fix bug in package name for Java 8u20
* Renamed exec resources to something less generic (avoid conflicts)

### 1.1.3

Add support for Java '8u20'

### 1.1.2

* Add support for Java '7u67'
* Make Puppet Doc compliant with RDoc markup language

### 1.1.1

* Add parameters validation
* Updated documentation
* Minor refactoring

### 1.1.0

Add support for Java SE 6 series

### 1.0.1

Add support for Java '7u65' and '8u11'

### 1.0.0

First forge release
