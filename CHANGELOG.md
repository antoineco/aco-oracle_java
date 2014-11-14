###2.1.0

* Added checksum check on downloaded archive
  * Java 7u60+ only for now. Contact me if you want to **HELP** me supporting older versions :)
* New `check_checksum` parameter
* Refactoring
* Better support of Mageia Linux

###2.0.0

* Support tar.gz format
  * now multiplatform!
* Dropped support for Java 6
  * it relied on dirty hacks to work properly, and that's not the direction I want this module to take
  * nobody uses JSE6 anymore ... right?
* Major refactoring
  * splitted the old bulky init class
* Use nanliu/archive for download and extraction
  * reliable module, multiplatform, well supported

###1.1.5

* Add support for Java '7u71', '7u72' and '8u25'

###1.1.4

* Fix bug in package name for Java 8u20
* Renamed exec resources to something less generic (avoid conflicts)

###1.1.3

* Add support for Java '8u20'

###1.1.2

* Add support for Java '7u67'
* Make Puppet Doc compliant with RDoc markup language

###1.1.1

* Add parameters validation
* Updated documentation
* Minor refactoring

###1.1.0

* Add support for Java SE 6 series

###1.0.1

* Add support for Java '7u65' and '8u11'

###1.0.0

First forge release
