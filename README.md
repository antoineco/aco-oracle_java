#oracle_java

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
  * [Classes and Defined Types](#classes-and-defined-types)
    * [Class: oracle_java](#class-oracle_java)
    * [Define: oracle_java::installation](#define-oracle_javainstallation)
5. [Limitations](#limitations)
6. [Contributors](#contributors)
7. [Credits](#credits)

##Overview

The oracle_java module allows you to install the Oracle JRE or JDK of your choice from the official archives provided by Oracle.

##Module description

This module downloads the desired Java version from Oracle's website and installs it on the target system. On [RPM-based distributions](http://en.wikipedia.org/wiki/List_of_Linux_distributions#RPM-based) the RPM version will be used by default. On all other platforms a tar.gz archive will be retrieved and extracted. Multiple versions of Oracle Java can be installed on the same system using a defined type.

Java SE archives are available from the Oracle [Java SE Downloads](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and Oracle [Java Archive](http://www.oracle.com/technetwork/java/archive-139210.html) pages.

This module is suitable for pretty much any Linux system. It currently supports all released Java SE versions from JSE 7 on.

##Setup

oracle_java will affect the following parts of your system:

* jre/jdk packages and/or archives
* java alternatives (and slaves)

Including the main class is enough to install the latest version of the Oracle JRE.

```puppet
include oracle_java
```

####A couple of examples

Install a specific version of the JDK

```puppet
class { 'oracle_java':
  version => '7u45',
  type    => 'jdk'
}
```

Install multiple Java versions

```puppet
class { 'oracle_java':
  version => '8u45',
  type    => 'jdk'
} ->
oracle_java::installation { '7u65':
  type => 'jdk'
}
```

Force installation from standard tar.gz archive, in a custom location

```puppet
class { 'oracle_java':
  …
  format       => 'tar.gz',
  install_path => '/opt/java'
}
```

Disable checksum validation and add java alternative

```puppet
class { 'oracle_java':
  …
  check_checksum  => false,
  add_alternative => true
}
```

Install from custom archive and URL

```puppet
class { 'oracle_java':
  …
  custom_download_url => 'http://myrepo.com/jdk-8u66-linux-x64.tar.gz',
  custom_checksum     => 'abcdef0123456789abcdef0123456789'
}
```

##Usage

###Classes and Defined Types

####Class: `oracle_java`

Primary class and entry point of the module. Installs Java in `/usr/java`

**Parameters within `oracle_java`:**

#####`version`

Java version to install, formatted as '*major_version*'u'*minor_version*' or simply '*major_version*' for the latest available release in the selected Java SE series. Defaults to `8`  
*Note*: a minor version of '0' (for example `8u0`) matches the initial release of the selected Java SE series. 

#####`type`

What envionment type to install. Valid values are `jre` and `jdk`. Defaults to `jre`

#####`format`

What format of installation archive to retrieve. Valid values are `rpm` and `tar.gz`. Default depends on the platform

#####`install_path`

Absolute root path where the Oracle Java archives are extracted. Requires `format` set to `tar.gz`. Defaults to `/usr/java`

#####`check_checksum`

Enable checksum validation on downloaded archives. Boolean value. Defaults to `true`

#####`add_alternative`

Add Oracle Java to the system alternatives on compatible platforms (Debian/RHEL/SuSE families). Boolean value. Defaults to `false`

#####`add_system_env`

Add `JAVA_HOME` environment variable to the `/etc/environment` file. Boolean value. Defaults to `false`

#####`custom_download_url`

Do not download the Oracle Java archive from Oracle servers, instead use an alternative URL. Must but the full URL to the archive file or RPM package

#####`custom_checksum`

Custom MD5 checksum used to verify the archive integrity. Optional. Defaults to the checksum provided by Oracle

####Define: `oracle_java::installation`

Installs an extra version of Oracle Java in `install_path`

**Parameters within `oracle_java::installation`:**

#####`version`

Namevar. See [oracle_java::version](#version)

#####`type`

See [oracle_java::type](#type)

#####`check_checksum`

See [oracle_java::check_checksum](#check_checksum)

#####`add_alternative`

See [oracle_java::add_alternative](#add_alternative)

#####`custom_download_url`

See [oracle_java::custom_download_url](#custom_download_url)

#####`custom_checksum`

See [oracle_java::custom_checksum](#custom_checksum)

##Limitations

Prior to Java 8u20, two different releases of the same Java series could not cohabit on the same system when installed from RPM. Each new version would override the previous one. This does not happen with tar.gz archives.

##Contributors

* [Martin Zehetmayer](https://github.com/angrox)

##Credits

The cookie manipulation used by this module to download installation packages directly from Oracle's page was found on [Ivan Dyedov's Blog](https://ivan-site.com/2012/05/download-oracle-java-jre-jdk-using-a-script/)

Features request and contributions are always welcome!
