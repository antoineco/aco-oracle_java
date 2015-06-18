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

  # with checksum check
  if $oracle_java::check_checksum {
    include oracle_java::checksums # get checksums list
    Archive {
      checksum      => $oracle_java::checksums::checksum,
      checksum_type => 'md5'
    }
  }

  # download archive
  if $oracle_java::format_real == 'rpm' {
    archive { "/usr/java/${oracle_java::filename}":
      cookie  => 'oraclelicense=accept-securebackup-cookie',
      source  => $oracle_java::downloadurl,
      cleanup => false,
      require => File['/usr/java'],
    }
  } else {
    # also extract if tar.gz
    archive { "/usr/java/${oracle_java::filename}":
      cookie       => 'oraclelicense=accept-securebackup-cookie',
      source       => $oracle_java::downloadurl,
      cleanup      => false,
      require      => File['/usr/java'],
      extract      => true,
      extract_path => '/usr/java',
      creates      => "/usr/java/${oracle_java::longversion}"
    }
  }
}
