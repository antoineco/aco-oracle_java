# == Class: oracle_java::install::rpm
#
# This class is used to install the RPM version of Java
#
class oracle_java::install::rpm {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # install package
  package { $oracle_java::packagename:
    ensure   => latest,
    source   => "${oracle_java::custom_archive_path}/${oracle_java::filename}",
    provider => rpm
  }
}
