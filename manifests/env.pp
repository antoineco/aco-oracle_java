# == Class: oracle_java::env
#
# This class adds Java environment variables to the /etc/environment file
#
class oracle_java::env {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  augeas { 'environment':
    context => '/files/etc/environment',
    changes => [ "set JAVA_HOME /usr/java/${oracle_java::longversion}" ]
  }
}
