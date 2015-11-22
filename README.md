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
6. [Credits](#credits)
7. [To Do](#to-do)

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

Install the latest release of the Java 7 SE JRE

```puppet
class { 'oracle_java':
  version => 7
}
```

Install the latest available JDK

```puppet
class { 'oracle_java':
  type => 'jdk'
}
```

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

Force installation from standard tar.gz archive

```puppet
class { 'oracle_java':
  …
  format => 'tar.gz'
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

#####`check_checksum`

Enable checksum validation on downloaded archives. Boolean value. Defaults to `true`

#####`add_alternative`

Add Oracle Java to the system alternatives on compatible platforms (Debian/RHEL/SuSE families). Boolean value. Defaults to `false`

#####`add_system_env`

Add `JAVA_HOME` environment variable to the `/etc/environment` file. Boolean value. Defaults to `false`

#####`check_checksum`

See [oracle_java::check_checksum](#check_checksum)

#####`custom_checksum`

Checks against a custom MD5 checksum

#####`custom_archive_path`

Use an alternative path as target for the untarred Oracle Java package. Needs `format` set to `tar.gz`

#####`custom_download_url`

Do not download the Oracle Java package from java, instead use a alternative URL (example: `http://repo.mycompany.com/jdk-8u66-linux-x64.tar.gz`). Needs `format` set to `tar.gz`

####Define: `oracle_java::installation`

Installs an extra version of Oracle Java in `/usr/java`

**Parameters within `oracle_java::installation`:**

#####`version`

Namevar. See [oracle_java::version](#version)

#####`type`

See [oracle_java::type](#type)

#####`custom_checksum`

Checks against a custom MD5 checksum

#####`custom_download_url`

Do not download the Oracle Java package from java, instead use a alternative URL (example: `http://repo.mycompany.com/jdk-8u66-linux-x64.tar.gz`). Needs `format` set to `tar.gz`

#####`add_alternative`

See [oracle_java::add_alternative](#add_alternative)

##Limitations

Prior to Java 8u20, two different releases of the same Java series could not cohabit on the same system when installed from RPM. Each new version would override the previous one. This does not happen with tar.gz archives however.

##Credits

The cookie manipulation used by this module to download its installation packages directly from Oracle's page was found on [Ivan Dyedov's Blog](https://ivan-site.com/2012/05/download-oracle-java-jre-jdk-using-a-script/)

##To Do

* Allow the manipulation of Java related environment variables

Features request and contributions are always welcome!
