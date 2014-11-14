# == Class: oracle_java::install::targz
#
# This class is used to extract the tar.gz version of Java
#
class oracle_java::install::targz {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # extract archive
  archive { 'extract java archive':
    path         => "/usr/java/${oracle_java::filename}",
    extract      => true,
    extract_path => '/usr/java',
    creates      => "/usr/java/${oracle_java::longversion}"
  } ->
  # fix permissions
  file { "/usr/java/${oracle_java::longversion}":
    recurse  => true,
    owner    => 'root',
    group    => 'root',
    loglevel => debug
  }

  # mimic RPM behaviour
  file { '/usr/java/default':
    ensure => link,
    target => "/usr/java/${oracle_java::longversion}"
  }
}