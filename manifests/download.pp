# == Class: oracle_java::download
class oracle_java::download {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # make sure install/download directory exists
  file { '/usr/java':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root'
  } ->
  # download archive
  archive { "/usr/java/${oracle_java::filename}":
    cookie  => "oraclelicense=accept-securebackup-cookie",
    source  => $oracle_java::downloadurl
  }
}