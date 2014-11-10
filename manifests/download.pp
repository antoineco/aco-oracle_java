# == Class: oracle_java::download
class oracle_java::download {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  if !defined(Class['archive']) {
    include archive
  }

  $require_extraction = $oracle_java::format ? {
    'tar.gz' => true,
    default  => false
  }

  # make sure install/download directory exists
  file { '/usr/java':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root'
  } ->
  # download archive
  archive { 'java archive':
    ensure       => present,
    path         => '/usr/java',
    cookie       => "oraclelicense=accept-securebackup-cookie",
    source       => $oracle_java::downloadurl,
    extract      => $require_extraction,
    extract_path => '/usr/java',
    creates      => "/usr/java/${oracle_java::longversion}",
    cleanup      => true
  }
}