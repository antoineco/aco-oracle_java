# == Class: oracle_java::alternative
#
# This class calls the appropriate subclass to install a new java alternative
#
class oracle_java::alternative {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  case $::osfamily {
    /RedHat|Suse/ : {
      contain oracle_java::alternative::rpm
    }
    'Debian'      : {
      contain oracle_java::alternative::deb
    }
    default       : {
      notice("\"${::operatingsystem}\" does not support alternatives, you should explicitly disable it for this host")
    }
  }
}