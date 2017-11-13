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

  Archive {
    proxy_server => $oracle_java::proxy_server,
    proxy_type   => $oracle_java::proxy_type,
    require      => File[$oracle_java::install_path]
  }

  # pass credentials to Oracle SSO for authenticated downloads
  if $oracle_java::oracle_url {
    Archive {
      source => oracle_sso("${oracle_java::download_url_real}/${oracle_java::filename_real}", $oracle_java::ssousername, $oracle_java::ssopassword, $oracle_java::proxy_server, $oracle_java::proxy_type)
    }
  } else {
    Archive {
      source => "${oracle_java::download_url_real}/${oracle_java::filename_real}"
    }
  }

  # with checksum check
  if $oracle_java::check_checksum {
    Archive {
      checksum      => $oracle_java::checksum_real,
      checksum_type => 'md5'
    }
  }

  # download archive
  if $oracle_java::format_real == 'rpm' or $oracle_java::maj_version == '6' {
    archive { "${oracle_java::install_path}/${oracle_java::filename_real}":
      cleanup => false,
      extract => false
    }
  } else {
    # also extract and clean up if tar.gz
    archive { "${oracle_java::install_path}/${oracle_java::filename_real}":
      cleanup      => true,
      extract      => true,
      extract_path => $oracle_java::install_path,
      creates      => "${oracle_java::install_path}/${oracle_java::longversion}"
    }
  }
}
