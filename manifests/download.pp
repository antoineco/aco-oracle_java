# == Class: oracle_java::download
#
# This class is used to download and check the appropriate Java archive file
#
class oracle_java::download {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # dependency
  if !defined(Class['archive']) {
    include archive
  }

  # make sure install/download directory exists
  file { '/usr/java':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root'
  }

  # download archive
  Archive {
    cookie  => 'oraclelicense=accept-securebackup-cookie',
    source  => $oracle_java::downloadurl,
    cleanup => false,
    require => File['/usr/java']
  }

  # WITH checksum check
  if $oracle_java::check_checksum {
    include oracle_java::checksums # get checksums list
    archive { "/usr/java/${oracle_java::filename}":
      checksum      => $oracle_java::checksums::checksum,
      checksum_type => 'md5'
    }
  } else {
    # WITHOUT checksum check
    archive { "/usr/java/${oracle_java::filename}": }
  }
}