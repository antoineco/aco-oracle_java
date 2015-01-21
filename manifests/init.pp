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
# [*check_checksum*]
#   enable checksum validation on downloaded archives (boolean)
# [*add_alternative*]
#   add java alternative (boolean)
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
#    version => '8u5',
#    type    => 'jdk',
#    format  => 'rpm'
#  }
#
class oracle_java ($version = '8', $type = 'jre', $format = undef, $check_checksum = true, $add_alternative = false) {
  if !$format {
    if $::osfamily =~ /RedHat|Suse/ or $::operatingsystem == 'Mageia' {
      $format_real = 'rpm'
    } else {
      $format_real = 'tar.gz'
    }
  } else {
    $format_real = $format
  }

  # parameters validation
  validate_re($version, '^([0-9]|[0-9]u[0-9]{1,2})$', '$version must be formated as \'major\'u\'minor\' or just \'major\'')
  validate_re($type, '^(jre|jdk)$', '$type must be either \'jre\' or \'jdk\'')
  validate_re($format_real, '^(rpm|tar\.gz)$', '$format must be either \'rpm\' or \'tar.gz\'')
  validate_bool($check_checksum, $add_alternative)

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u31'
  } elsif $version == '7' {
    $version_real = '7u76'
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
  $filename = "${type}-${version_final}-linux-${arch}.${format_real}"

  # define download URL
  include oracle_java::javalist
  $downloadurl = "http://download.oracle.com/otn-pub/java/jdk/${version_final}${oracle_java::javalist::build}/${filename}"

  # define package name
  if $maj_version == '8' and $min_version >= '20' {
    $packagename = $longversion
  } else {
    $packagename = $type
  }

  # annnnd... let's go
  include oracle_java::download
  include oracle_java::install
  Class['oracle_java::download'] ~> Class['oracle_java::install']

  if $add_alternative {
    include oracle_java::alternative
    Class['oracle_java::install'] -> Class['oracle_java::alternative']
  }
}