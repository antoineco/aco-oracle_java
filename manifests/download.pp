# == Class: oracle_java::download
class oracle_java::download {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # define packages required by the exec resources
  if !defined(Package['wget']) {
    package { 'wget': ensure => present }
  }

  # make sure install/download directory exists
  file { '/usr/java':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root'
  } ->
  # download RPM
  exec { 'download java RPM':
    path    => '/usr/bin',
    cwd     => '/usr/java',
    creates => "/usr/java/${oracle_java::filename}",
    command => "wget --no-cookies --no-check-certificate --header \"Cookie: oraclelicense=accept-securebackup-cookie\" \"${oracle_java::downloadurl}\"",
    timeout => 0, # Oracle's servers can sometimes be (very) slow
    require => Package['wget']
  }
}