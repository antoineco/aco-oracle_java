# === Class: oracle_java
#
# This module installs Oracle Java from official RPM packages
#
# == Parameters
#
# $version:
#   Java SE version to install (valid format: 'major'u'minor' or just 'major')
# $type:
#   envionment type to install (valid: 'jre'|'jdk')
#
# === Actions
#
# - Install Oracle jre/jdk
#
# === Requires
#
# - puppetlabs/stdlib module
#
# === Sample Usage:
#
# class { '::oracle_java':
#   version => '8u5',
#   type    => 'jdk'
# }
#
class oracle_java ($version = '8', $type = 'jre') {
  # translate system architecture to expected value
  case $::architecture {
    'x86_64' : { $arch = 'x64' }
    'x86'    : { $arch = 'i586' }
    default  : { fail("Unsupported architecture ${arch}") }
  }

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u11'
  } elsif $version == '7' {
    $version_real = '7u65'
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
        '11'    : { $build = '-b12' }
        '5'     : { $build = '-b13' }
        '0'     : { $build = '-b132' }
        default : { fail("Unexisting update number ${min_version}") }
      }
    }
    7       : {
      case $min_version {
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
        default : { fail("Unexisting update number ${min_version}") }
      }
    }
    default : {
      fail("Unsupported or unexisting version ${version}")
    }
  }

  # remove extra particle if minor version is 0
  $version_final = delete($version_real, 'u0')

  # define installer filename and download URL
  $filename = "${type}-${version_final}-linux-${arch}.rpm"
  $downloadurl = "http://download.oracle.com/otn-pub/java/jdk/${version_final}${build}/${filename}"

  # make sure install/download directory exists
  file { '/usr/java':
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root'
  } ->
  # download RPM
  exec { 'downloadRPM':
    path    => '/usr/bin',
    cwd     => '/usr/java',
    creates => "/usr/java/${filename}",
    command => "wget --no-cookies --no-check-certificate --header \"Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie\" \"${downloadurl}\"",
    timeout => 0
  } ->
  # install package
  package { $type:
    ensure   => latest,
    source   => "/usr/java/${filename}",
    provider => rpm
  }
}
