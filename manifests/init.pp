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
#
# === Actions:
#
# - Install Oracle jre/jdk
#
# === Requires:
#
# * puppetlabs/stdlib module
# * nanliu/archive module
# * 'sed' package
#
# === Sample Usage:
#
#  class { '::oracle_java':
#    version => '8u5',
#    type    => 'jdk',
#    format  => 'rpm'
#  }
#
class oracle_java ($version = '8', $type = 'jre', $format = undef) {
  if !$format {
    case $::osfamily {
      /RedHat|Suse/ : { $format_real = 'rpm' }
      default       : { $format_real = 'tar.gz' }
    }
  } else {
    $format_real = $format
  }

  # parameters validation
  validate_re($version, '^([0-9]|[0-9]u[0-9]{1,2})$', '$version must be formated as \'major\'u\'minor\' or just \'major\'')
  validate_re($type, '^(jre|jdk)$', '$type must be either \'jre\' or \'jdk\'')
  validate_re($format_real, '^(rpm|tar\.gz)$', '$format must be either \'rpm\' or \'tar.gz\'')

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u25'
  } elsif $version == '7' {
    $version_real = '7u72'
  } else {
    $version_real = $version
  }
  
  # translate system architecture to expected value
  case $::architecture {
    /x86_64|amd64/ : { $arch = 'x64' }
    'x86'          : { $arch = 'i586' }
    default        : { fail("oracle_java does not support architecture ${::architecture} (yet)") }
  }

  # determine build numbers, checksums, etc.
  include oracle_java::javalist

  # define installer filename and download URL
  $filename = "${type}-${oracle_java::javalist::version_final}-linux-${arch}.${format_real}"
  $downloadurl = "http://download.oracle.com/otn-pub/java/jdk/${oracle_java::javalist::version_final}${oracle_java::javalist::build}/${filename}"

  # define package name
  if $oracle_java::javalist::maj_version == '8' and $oracle_java::javalist::min_version >= '20' {
    $packagename = $oracle_java::javalist::longversion
  } else {
    $packagename = $type
  }

  # include classes as required
  if !defined(Class['archive']) {
    include archive
  }

  include oracle_java::download
  include oracle_java::install
  Class['oracle_java::download'] ~> Class['oracle_java::install']
}