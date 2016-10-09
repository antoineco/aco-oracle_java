# == Class: oracle_java
#
# This module installs Oracle Java from official RPM packages
#
# === Parameters:
#
# [*version*]
#   Java SE version to install (valid format: 'major'u'minor' or just 'major')
# [*type*]
#   envionment type to install (valid: 'jre'|'jdk')
# [*format*]
#   archive format (valid: 'rpm'|'tar.gz')
# [*install_path*]
#   defines the root path where the Java archives are extracted. Requires 'tar.gz' format
# [*check_checksum*]
#   enable checksum validation on downloaded archives (boolean)
# [*add_alternative*]
#   add java alternative (boolean)
# [*add_system_env*]
#   add system-wide Java environment variables (boolean)
# [*custom_download_url*]
#   fetch the package from an alternative URL
# [*custom_checksum*]
#   use a custom checksum to verify the archive integrity
#
# === Actions:
#
# - Install Oracle jre/jdk
#
# === Requires:
#
# * puppetlabs/stdlib module
# * nanliu/archive module
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
  $version             = '8',
  $type                = 'jre',
  $format              = undef,
  $check_checksum      = true,
  $add_alternative     = false,
  $add_system_env      = false,
  $install_path        = '/usr/java',
  $custom_download_url = undef,
  $custom_checksum     = undef
  ) {
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
  validate_re($version, '^([0-9]|[0-9]u[0-9]{1,3})$', '$version must be formated as \'major\'u\'minor\' or just \'major\'')
  validate_re($type, '^(jre|jdk)$', '$type must be either \'jre\' or \'jdk\'')
  validate_re($format_real, '^(rpm|tar\.gz)$', '$format must be either \'rpm\' or \'tar.gz\'')
  validate_bool($check_checksum, $add_alternative)
  validate_absolute_path($install_path)

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u102'
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
  case $maj_version {
    '6'     : {
      case $format_real {
        'rpm'   : { $filename = "${type}-${version_final}-linux-${arch}-rpm.bin" }
        default : { $filename = "${type}-${version_final}-linux-${arch}.bin" }
      }
    }
    default : { $filename = "${type}-${version_final}-linux-${arch}.${format_real}" }
  }

  # used for installing Java 6 RPM only
  # determine filename once .bin is extracted
  if $maj_version == '6' and $format_real == 'rpm' {
    case $arch {
      'x64'   : { $filename_extracted = "${type}-${version_final}-linux-amd64.rpm" }
      default : { $filename_extracted = "${type}-${version_final}-linux-${arch}.rpm" }
    }
  }

  # define download URL
  contain oracle_java::javalist
  if $custom_download_url == undef {
    $downloadurl = "http://download.oracle.com/otn-pub/java/jdk/${version_final}${oracle_java::javalist::build}/${filename}"
  } else {
    $downloadurl = $custom_download_url
  }

  # define package name
  if $maj_version == '8' and $min_version >= '20' {
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
