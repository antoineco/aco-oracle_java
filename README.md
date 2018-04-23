# oracle_java
[![Build Status](https://travis-ci.org/antoineco/aco-oracle_java.svg?branch=master)](https://travis-ci.org/antoineco/aco-oracle_java)

*By using this module you acknowledge that you have read and accepted the terms of the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/).*

*Downloads from the Oracle Java Archive require an [Oracle.com account](https://login.oracle.com/mysso/signon.jsp).*

#### Table of Contents

1. [Overview - What is the oracle_java module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with tomcat](#setup)
4. [Usage - The classes and defined types available for configuration](#usage)
  * [Classes and Defined Types](#classes-and-defined-types)
    * [Class: oracle_java](#class-oracle_java)
    * [Define: oracle_java::installation](#define-oracle_javainstallation)
    * [Common parameters](#common-parameters)
5. [Limitations](#limitations)
6. [Contributors](#contributors)
7. [Credits](#credits)

## Overview

The oracle_java module allows you to install the Oracle JRE or JDK of your choice from the official archives provided by Oracle.

## Module description

This module downloads the desired Java version from Oracle's website and installs it on the target system. On [RPM-based distributions](http://en.wikipedia.org/wiki/List_of_Linux_distributions#RPM-based) the RPM version will be used by default. On all other platforms a tar.gz archive will be retrieved and extracted. Multiple versions of Oracle Java can be installed on the same system using a defined type.

Java SE archives are available from the Oracle [Java SE Downloads](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and Oracle [Java Archive](http://www.oracle.com/technetwork/java/archive-139210.html) pages.

This module is suitable for pretty much any Linux system. It currently supports all released Java SE versions from JSE 7 on.

## Setup

oracle_java will affect the following parts of your system:

* jre/jdk packages and/or archives
* java alternatives (and slaves)

Including the main class is enough to install the latest version of the Oracle JRE.

```puppet
include oracle_java
```

#### A couple of examples

Install a specific version of the JDK

```puppet
class { 'oracle_java':
  version     => '7u45',
  type        => 'jdk',
  ssousername => 'me@example.com',	# only for packages from the Oracle Java Archive
  ssopassword => 'mypassword'		#
}
```

Install multiple Java versions

```puppet
class { 'oracle_java':
  version => '8u45',
  type    => 'jdk'
}
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

Install a Java version not (yet) supported by this module

```puppet
class { 'oracle_java':
  …
  version  => '8u122',
  build    => '-b04',
  checksum => '436fc6772eb961b07b7b3414ab111857',
  urlcode  => '/e9e7ea248e2c4826b92b3f075a80e441'
}
```

Install from custom archive and URL

```puppet
class { 'oracle_java':
  …
  download_url => 'http://myrepo.com',
  filename     => 'my-jdk-8u66.tar.gz',
  checksum     => '380e6d224f5c8c8eba37c97439f09eb4'
}
```

Download Java archives behind a proxy server

```puppet
class { 'oracle_java':
  …
  proxy_server => 'http://user:password@proxy.example.com:8080'
}
```

## Usage

### Classes and Defined Types

#### Class: `oracle_java`

Primary class and entry point of the module. Installs Java in `/usr/java`

**Parameters within `oracle_java`:**

##### `version`
Java version to install, formatted as '*major_version*'u'*minor_version*' or simply '*major_version*' for the latest available release in the selected Java SE series. Defaults to `8`  
*Note*: a minor version of '0' (for example `8u0`) matches the initial release of the selected Java SE series. 

##### `format`
What format of installation archive to retrieve. Valid values are `rpm` and `tar.gz`. Default depends on the platform.

##### `ssousername`
Oracle account username. Used to authenticate against Oracle.com Single Sign-on service and download packages from the Oracle Java Archive.

##### `ssopassword`
Oracle account password.

##### `install_path`
Absolute root path where the Oracle Java archives are extracted. Requires `format` set to `tar.gz`. Defaults to `/usr/java`.

##### `proxy_server`
URL of a proxy server used for downloading Java archives.

##### `proxy_type`
Type of the proxy server. Valid values are `none`, `http`, `https` and `ftp`. Default determined by the scheme used in `proxy_server`.

##### `add_system_env`
Add `JAVA_HOME` environment variable to the `/etc/environment` file. Boolean value. Defaults to `false`.

See also [Common parameters](#common-parameters)

#### Define: `oracle_java::installation`
Installs an extra version of Oracle Java in `install_path`.

**Parameters within `oracle_java::installation`:**

##### `version`

Namevar. See [oracle_java::version](#version)

See also [Common parameters](#common-parameters)

#### Common parameters

Parameters common to both `oracle_java` and `oracle_java::installation`.

##### `build`
Build number associated to the requested Java SE version, formatted as `-b## `. Default determined automatically.  
*Note*: this parameter is mandatory when installing a Java SE release which is not currently supported by this module.

##### `type`
What envionment type to install. Valid values are `jre` and `jdk`. Defaults to `jre`.

##### `check_checksum`
Enable checksum validation on downloaded archives. Boolean value. Defaults to `true`.

##### `checksum`
MD5 checksum used to verify the archive integrity. Defaults to the checksum provided by Oracle.

##### `add_alternative`
Add Oracle Java to the system alternatives on compatible platforms (Debian/RHEL/SuSE families). Boolean value. Defaults to `false`.

##### `download_url`
Base URL of an alternative location to download the Java archive from. Defaults to Oracle servers.

##### `filename`
File name of the installation package to retrieve at `${download_url}`. Defaults to the file name provided by Oracle.

##### `urlcode`
Complex code Oracle adds to the download URL since Java SE 8u121. Default determined automatically.

## Limitations

Prior to Java 8u20, two different releases of the same Java series could not cohabit on the same system when installed from RPM. Each new version would override the previous one. This does not happen with tar.gz archives.

## Contributors

* [Martin Zehetmayer](https://github.com/angrox)
* [Clayton O'Neill](https://github.com/claytononeill)
* [Michael Hoertnagl](https://github.com/mtron)

## Credits

The cookie manipulation used by this module to download installation packages directly from Oracle's page was found on [Ivan Dyedov's Blog](https://ivan-site.com/2012/05/download-oracle-java-jre-jdk-using-a-script/)

Features request and contributions are always welcome!
