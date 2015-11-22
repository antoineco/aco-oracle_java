# == Class: oracle_java::install::targz
#
# This class is used to extract the tar.gz version of Java
#
class oracle_java::install::targz {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # fix permissions
  file { "$::oracle_java::custom_archive_path/${oracle_java::longversion}":
    recurse  => true,
    owner    => 'root',
    group    => 'root',
    loglevel => debug
  }

  # mimic RPM behaviour
  file { "$::oracle_java::custom_archive_path/default":
    ensure => link,
    target => "$::oracle_java::custom_archive_path/${oracle_java::longversion}"
  }
}
