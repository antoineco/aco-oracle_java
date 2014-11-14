# == Class: oracle_java::javalist
class oracle_java::javalist {
  # get major/minor version numbers
  $array_version = split($oracle_java::version_real, 'u')
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
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
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
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
      }
    }
    default : {
      fail("oracle_java module does not support Java SE version ${maj_version} (yet)")
    }
  }

  # remove extra particle if minor version is 0
  $version_final = delete($oracle_java::version_real, 'u0')
  $longversion = $min_version ? {
    '0'       => "${oracle_java::type}1.${maj_version}.0",
    /^[0-9]$/ => "${oracle_java::type}1.${maj_version}.0_0${min_version}",
    default   => "${oracle_java::type}1.${maj_version}.0_${min_version}"
  }
}