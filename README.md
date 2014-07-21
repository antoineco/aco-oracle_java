#oracle_java

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Limitations](#limitations)
6. [Credits](#credits)
7. [To Do](#to-do)

##Overview

The oracle_java module allows you to install the Oracle JRE or JDK of your choice from the official RPM archives provided by Oracle.

##Module description

Oracle provides a RPM version of both its JRE and JDK for every Java release. These packages are available from the Oracle [Java SE Downloads](http://www.oracle.com/technetwork/java/javase/downloads/index.html) and Oracle [Java Archive](http://www.oracle.com/technetwork/java/archive-139210.html) pages. This module simply downloads the desired Java version and installs it on the target system. It is especially intended for systems which do not need to have several Java versions installed in parallel and for users looking for an easy way to update their Java environment.

##Setup

oracle_java will affect the following parts of your system:

* jre/jdk package

Including the main class is enough to install the latest version of the Oracle JRE.

```puppet
include ::oracle_java
```

####A couple of examples

Install the latest release of the Java 7 SE JRE

```puppet
class { '::oracle_java':
  version => 7
}
```

Install the latest available JDK

```puppet
class { '::oracle_java':
  type => 'jdk'
}
```

Install a specific version of the JDK

```puppet
class { '::oracle_java':
  version => '7u45',
  type    => 'jdk'
}
```

##Usage

####Class: `oracle_java`

Primary class and entry point of the module.

**Parameters within `oracle_java`:**

#####`version`

Java version to install, formated as 'major_version'u'minor_version' or simply 'major_version' for the latest available release in the selected Java SE series. Defaults to '8'

Note: a minor version of '0' (for example '8u0') matches the initial release of the selected Java SE series. 

#####`type`

What envionment type to install. Valid values are 'jre' and 'jdk'. Defaults to 'jre'

##Limitations

* 2 different versions of Oracle Java can not cohabit on the same system when installed from RPM. Each new version will override the previous one.
* Works only on [RPM-based distributions](http://en.wikipedia.org/wiki/List_of_Linux_distributions#RPM-based)

##Credits

This module relies almost entirely on all the nice information found on [Ivan Dyedov's Blog](https://ivan-site.com/2012/05/download-oracle-java-jre-jdk-using-a-script/)

##To Do

* Allow the manipulation of Java related environment variables
* Propose an alternative based on tar.gz archives, also available from Oracle's archives

Features request and contributions are always welcome!