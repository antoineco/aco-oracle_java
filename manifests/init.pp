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
class oracle_java ($version = '8', $type = 'jre', $format = 'rpm') {
  # parameters validation
  validate_re($version, '^([0-9]|[0-9]u[0-9]{1,2})$', '$version must be formated as \'major\'u\'minor\' or just \'major\'')
  validate_re($type, '^(jre|jdk)$', '$type must be either \'jre\' or \'jdk\'')
  validate_re($format, '^(rpm|tar.gz)$', '$format must be either \'rpm\' or \'tar.gz\'')

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u25'
  } elsif $version == '7' {
    $version_real = '7u72'
  } elsif $version == '6' {
    $version_real = '6u45'
  } else {
    $version_real = $version
  }

  # get major/minor version numbers
  $array_version = split($version_real, 'u')
  $maj_version = $array_version[0]
  $min_version = $array_version[1]

  # associate build number to release version
  case $maj_version {
    8       : {
      case $min_version {
        '25'    : { $build = '-b17' }
        '20'    : { $build = '-b26' }
        '11'    : { $build = '-b12' }
        '5'     : { $build = '-b13' }
        '0'     : { $build = '-b132' }
        default : { fail("Unexisting Java SE ${maj_version} update number ${min_version}") }
      }
    }
    7       : {
      case $min_version {
        '72'    : { $build = '-b14' }
        '71'    : { $build = '-b14' }
        '67'    : { $build = '-b01' }
        '65'    : { $build = '-b17' }
        '60'    : { $build = '-b19' }
        '55'    : { $build = '-b13' }
        '51'    : { $build = '-b13' }
        '45'    : { $build = '-b18' }
        '40'    : { $build = '-b43' }
        '25'    : { $build = '-b15' }
        '21'    : { $build = '-b11' }
        '17'    : { $build = '-b02' }
        '15'    : { $build = '-b03' }
        '13'    : { $build = '-b20' }
        '11'    : { $build = '-b21' }
        '10'    : { $build = '-b18' }
        '9'     : { $build = '-b05' }
        '7'     : { $build = '-b10' }
        '6'     : { $build = '-b24' }
        '5'     : { $build = '-b06' }
        '4'     : { $build = '-b20' }
        '3'     : { $build = '-b04' }
        '2'     : { $build = '-b13' }
        '1'     : { $build = '-b08' }
        '0'     : { $build = '' }
        default : { fail("Unexisting Java SE ${maj_version} update number ${min_version}") }
      }
    }
    6       : {
      case $min_version {
        '45'    : { $build = '-b06' }
        '43'    : { $build = '-b01' }
        '41'    : { $build = '-b02' }
        '39'    : { $build = '-b04' }
        '38'    : { $build = '-b05' }
        '37'    : { $build = '-b06' }
        '35'    : { $build = '-b10' }
        '34'    : { $build = '-b04' }
        '33'    : { $build = '-b04' }
        '32'    : { $build = '-b05' }
        '31'    : { $build = '-b04' }
        '30'    : { $build = '-b12' }
        '29'    : { $build = '-b11' }
        '27'    : { $build = '-b07' }
        '26'    : { $build = '-b03' }
        '25'    : { $build = '-b06' }
        '24'    : { $build = '-b07' }
        '23'    : { $build = '-b05' }
        '22'    : { $build = '-b04' }
        '21'    : { $build = '-b07' }
        '20'    : { $build = '-b02' }
        '19'    : { $build = '-b04' }
        '18'    : { $build = '-b07' }
        '17'    : { $build = '-b04' }
        '16'    : { $build = '-b01' }
        '15'    : { $build = '-b03' }
        '14'    : { $build = '-b08' }
        '13'    : { $build = '-b03' }
        '12'    : { $build = '-b04' }
        '11'    : { $build = '-b03' }
        '10'    : { $build = '' }
        '7'     : { $build = '' }
        '6'     : { $build = '' }
        '5'     : { $build = 'b' }
        '4'     : { $build = '-b12' }
        '3'     : { $build = '' }
        '2'     : { $build = '' }
        '1'     : { $build = '' }
        '0'     : { $build = '' }
        default : { fail("Unexisting Java SE ${maj_version} update number ${min_version}") }
      }
    }
    default : {
      fail("oracle_java module does not support Java SE version ${maj_version} (yet)")
    }
  }

  # remove extra particle if minor version is 0
  $version_final = delete($version_real, 'u0')
  $longversion = $min_version ? {
    '0'     => "${type}1.${maj_version}.0",
    default => "${type}1.${maj_version}.0_${min_version}"
  }

  # translate system architecture to expected value
  case $::architecture {
    'x86_64' : {
      if $maj_version == '6' and $min_version < '4' {
        $arch = 'amd64'
      } else {
        $arch = 'x64'
      }
    }
    'x86'    : {
      $arch = 'i586'
    }
    default  : {
      fail("oracle_java does not support architecture ${arch} (yet)")
    }
  }

  # define installer filename and download URL
  $filename = $maj_version ? {
    '6'     => "${type}-${version_final}-linux-${arch}-rpm.bin",
    default => "${type}-${version_final}-linux-${arch}.rpm"
  }
  $downloadurl = "http://download.oracle.com/otn-pub/java/jdk/${version_final}${build}/${filename}"

  # used for installing Java 6
  # translate system architecture one more time
  $arch_extracted = $::architecture ? {
    'x86_64' => 'amd64',
    default  => $arch
  }
  $filename_extracted = "${type}-${version_final}-linux-${arch_extracted}.rpm"

  # define package name
  if $maj_version == '8' and $min_version >= '20' {
    $packagename = $longversion
  } else {
    $packagename = $type
  }

  include oracle_java::download
  include oracle_java::install
}