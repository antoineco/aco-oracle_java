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
#
# === Actions:
#
# - Install Oracle jre/jdk
#
# === Requires:
#
# * puppetlabs/stdlib module
# * 'wget' and 'sed' packages
#
# === Sample Usage:
#
#  class { '::oracle_java':
#    version => '8u5',
#    type    => 'jdk'
#  }
#
class oracle_java ($version = '8', $type = 'jre') {
  # parameters validation
  validate_re($version, '^([0-9]|[0-9]u[0-9][0-9])$', '$version must be formated as \'major\'u\'minor\' or just \'major\'')
  validate_re($type, '^(jre|jdk)$', '$type must be either \'jre\' or \'jdk\'')

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u11'
  } elsif $version == '7' {
    $version_real = '7u65'
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
        '11'    : { $build = '-b12' }
        '5'     : { $build = '-b13' }
        '0'     : { $build = '-b132' }
        default : { fail("Unexisting Java SE ${maj_version} update number ${min_version}") }
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

  # translate system architecture to expected value
  case $::architecture {
    'x86_64' : { $arch = 'x64' }
    'x86'    : { $arch = 'i586' }
    default  : { fail("oracle_java does not support architecture ${arch} (yet)") }
  }

  # define installer filename and download URL
  $filename = $maj_version ? {
    '6'     => "${type}-${version_final}-linux-${arch}-rpm.bin",
    default => "${type}-${version_final}-linux-${arch}.rpm"
  }
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
    timeout => 0,
    require => Package['wget']
  }

  # install package
  if $maj_version >= 7 {
    package { $type:
      ensure   => latest,
      source   => "/usr/java/${filename}",
      provider => rpm,
      require  => Exec['downloadRPM']
    }
  }
  # the procedure is a bit more complicated for older versions...
  # RPM files are packaged into a BIN archive which needs to be extracted
  else {
    # translate system architecture one more time
    $arch_final = $::architecture ? {
      'x86_64' => 'amd64',
      default  => $arch
    }

    # the extracted file includes the 'new' arch string
    $filename_extract = "${type}-${version_final}-linux-${arch_final}.rpm"

    exec { 'unpackRPM':
      path    => '/bin',
      cwd     => '/usr/java',
      creates => "/usr/java/${filename_extract}",
      command => "sed -ni '/exit 0/,\${//!p}' ${filename}; chmod +x ${filename}; ./${filename}",
      require => [Package['sed'], Exec['downloadRPM']]
    } ~>
    # remove undesired extra RPMs
    exec { 'cleanupRPM':
      path        => '/bin',
      cwd         => '/usr/java',
      refreshonly => true,
      command     => 'rm -f sun-javadb-*.rpm'
    } ->
    package { $type:
      ensure   => latest,
      source   => "/usr/java/${filename_extract}",
      provider => rpm
    }
  }
  
  # define required packages, they are be required by exec resources
  if !defined(Package['wget']) {
    package { 'wget': ensure => present }
  }
  if $maj_version < 7 {
    if !defined(Package['sed']) {
      package { 'sed': ensure => present }
    }
  }
}