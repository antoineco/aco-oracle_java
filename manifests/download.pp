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
  file { $oracle_java::install_path:
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
  if $oracle_java::format_real == 'rpm' or $oracle_java::maj_version == '6' {
    archive { "${oracle_java::install_path}/${oracle_java::filename}":
      #provider => 'curl',
      cookie  => 'oraclelicense=accept-securebackup-cookie',
      source  => $oracle_java::downloadurl,
      cleanup => false,
      require => File[$oracle_java::install_path]
    }
  } else {
    # also extract and clean up if tar.gz
    archive { "${oracle_java::install_path}/${oracle_java::filename}":
      #provider     => 'curl',
      cookie       => 'oraclelicense=accept-securebackup-cookie',
      source       => $oracle_java::downloadurl,
      cleanup      => true,
      require      => File[$oracle_java::install_path],
      extract      => true,
      extract_path => $oracle_java::install_path,
      creates      => "${oracle_java::install_path}/${oracle_java::longversion}"
    }
  }
}
