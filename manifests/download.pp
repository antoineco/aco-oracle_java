# == Class: oracle_java::download
#
# This class is used to download and check the appropriate Java archive file
#
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
  }

  # get checksums list
  include oracle_java::checksums

  # download archive
  # WITH checksum check
  if $oracle_java::check_checksum {
    # TEMPORARY CONDITIONAL BLOCK, until I finally gather checksums for all supported Java versions
    if $oracle_java::maj_version == '8' or ($oracle_java::maj_version == '7' and $oracle_java::min_version >= '60') {
      archive { "/usr/java/${oracle_java::filename}":
        cookie        => "oraclelicense=accept-securebackup-cookie",
        source        => $oracle_java::downloadurl,
        checksum      => $oracle_java::checksums::checksum,
        checksum_type => 'md5',
        cleanup       => false,
        require       => File['/usr/java']
      }
    } else {
      archive { "/usr/java/${oracle_java::filename}":
        cookie  => "oraclelicense=accept-securebackup-cookie",
        source  => $oracle_java::downloadurl,
        cleanup => false,
        require => File['/usr/java']
      }
    }
  } else {
    # WITHOUT checksum check
    archive { "/usr/java/${oracle_java::filename}":
      cookie  => "oraclelicense=accept-securebackup-cookie",
      source  => $oracle_java::downloadurl,
      cleanup => false,
      require => File['/usr/java']
    }
  }
}