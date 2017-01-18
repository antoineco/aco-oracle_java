# == Class: oracle_java
#
# This module installs Oracle Java from official RPM packages
#
# === Parameters:
#
# [*version*]
#   Java SE version to install (valid format: 'major'u'minor' or just 'major')
# [*build*]
#   build number associated to the requested Java SE version (valid format: '-b###')
# [*type*]
#   envionment type to install (valid: 'jre'|'jdk')
# [*format*]
#   archive format (valid: 'rpm'|'tar.gz')
# [*install_path*]
#   defines the root path where the Java archives are extracted. Requires 'tar.gz' format
# [*check_checksum*]
#   enable checksum validation on downloaded archives (boolean)
# [*checksum*]
#   use a custom checksum to verify the archive integrity
# [*add_alternative*]
#   add java alternative (boolean)
# [*add_system_env*]
#   add system-wide Java environment variables (boolean)
# [*download_url*]
#   base url of a custom location to fetch the installation package from
# [*filename*]
#   custom file name to use when downloading the installation package
# [*proxy_server*]
#   proxy server url
# [*proxy_type*]
#   proxy server type (valid: 'none'|'http'|'https'|'ftp')
# [*urlcode*]
#   complex code oracle started adding to the 'download_url' starting from java 8u121
#
# === Actions:
#
# - Install Oracle jre/jdk
#
# === Requires:
#
# * puppetlabs/stdlib module
# * puppet/archive module
#
# === Sample Usage:
#
#  class { 'oracle_java':
#    version         => '8u5',
#    type            => 'jdk',
#    format          => 'rpm',
#    add_alternative => true
#  }
#
class oracle_java (
  $version         = '8',
  $build           = undef,
  $type            = 'jre',
  $format          = undef,
  $check_checksum  = true,
  $checksum        = undef,
  $add_alternative = false,
  $add_system_env  = false,
  $install_path    = '/usr/java',
  $download_url    = undef,
  $filename        = undef,
  $proxy_server    = undef,
  $proxy_type      = undef,
  $urlcode         = undef) {
  if !$format {
    if $::osfamily =~ /RedHat|Suse/ or $::operatingsystem == 'Mageia' {
      case $install_path {
        '/usr/java' : { $format_real = 'rpm' }
        default     : {
          notice("'install_path' set to custom location on RPM platform, falling back to tar.gz installation")
          $format_real = 'tar.gz'
        }
      }
    } else {
      $format_real = 'tar.gz'
    }
  } else {
    $format_real = $format
  }

  # parameters validation
  if $version !~ /^([0-9]|[0-9]u[0-9]{1,3})$/ {
    fail('$version must be formated as \'major\'u\'minor\' or just \'major\'')
  }
  if $type !~ /^(jre|jdk)$/ {
    fail('$type must be either \'jre\' or \'jdk\'')
  }
  if $format_real !~ /^(rpm|tar\.gz)$/ {
    fail('$format must be either \'rpm\' or \'tar.gz\'')
  }

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u121'
  } elsif $version == '7' {
    $version_real = '7u80'
  } elsif $version == '6' {
    $version_real = '6u45'
  } else {
    $version_real = $version
  }

  # translate system architecture to expected value
  case $::architecture {
    /x86_64|amd64/ : { $arch = 'x64' }
    'x86'          : { $arch = 'i586' }
    default        : { fail("oracle_java does not support architecture ${::architecture} (yet)") }
  }

  # get major/minor version numbers
  $array_version = split($version_real, 'u')
  $maj_version = $array_version[0]
  $min_version = $array_version[1]

  # remove extra particle if minor version is 0
  $version_final = delete($oracle_java::version_real, 'u0')
  $longversion = $min_version ? {
    '0'       => "${oracle_java::type}1.${maj_version}.0",
    /^[0-9]$/ => "${oracle_java::type}1.${maj_version}.0_0${min_version}",
    default   => "${oracle_java::type}1.${maj_version}.0_${min_version}"
  }

  # define installer filename
  if !$filename {
    case $maj_version {
      '6'     : {
        case $format_real {
          'rpm'   : { $filename_real = "${type}-${version_final}-linux-${arch}-rpm.bin" }
          default : { $filename_real = "${type}-${version_final}-linux-${arch}.bin" }
        }
      }
      default : { $filename_real = "${type}-${version_final}-linux-${arch}.${format_real}" }
    }
  } else {
    $filename_real = $filename
  }

  # used for installing Java 6 RPM only
  # determine filename once .bin is extracted
  if $maj_version == '6' and $format_real == 'rpm' {
    case $arch {
      'x64'   : { $filename_extracted = "${type}-${version_final}-linux-amd64.rpm" }
      default : { $filename_extracted = "${type}-${version_final}-linux-${arch}.rpm" }
    }
  }

  # define build number and url code
  if !$build {
    contain oracle_java::javalist # get build numbers, url codes
    $build_real = $oracle_java::javalist::buildnumber
    $urlcode_real = $oracle_java::javalist::urlcode
  } else {
    $build_real = $build
    $urlcode_real = $urlcode
  }

  # define checksum
  if $check_checksum {
    if !$checksum {
      contain oracle_java::checksums # get checksums list
      $checksum_real = $oracle_java::checksums::md5checksum
    } else {
      $checksum_real = $checksum
    }
  }

  # define download URL
  if !$download_url {
    $download_url_real = "http://download.oracle.com/otn-pub/java/jdk/${version_final}${build_real}${urlcode_real}"
  } else {
    $download_url_real = $download_url
  }

  # define package name
  if versioncmp($version_final, '8u20') >= 0 {
    $packagename = $longversion
  } else {
    $packagename = $type
  }

  # annnnd... let's go
  contain oracle_java::download
  contain oracle_java::install
  Class['oracle_java::download'] ~> Class['oracle_java::install']

  if $add_alternative {
    contain oracle_java::alternative
    Class['oracle_java::install'] -> Class['oracle_java::alternative']
  }

  if $add_system_env {
    contain oracle_java::env
  }
}
