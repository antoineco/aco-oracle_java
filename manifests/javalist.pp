# == Class: oracle_java::javalist
#
# This class associates a Java version number with its build number
#
class oracle_java::javalist {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # associate build number to release version
  case $oracle_java::maj_version {
    '8'     : {
      case $oracle_java::min_version {
        '72'    : { $build = '-b15' }
        '71'    : { $build = '-b15' }
        '66'    : { $build = '-b17' }
        '65'    : { $build = '-b17' }
        '60'    : { $build = '-b27' }
        '51'    : { $build = '-b16' }
        '45'    : { $build = '-b14' }
        '40'    : { $build = '-b25' }
        '31'    : { $build = '-b13' }
        '25'    : { $build = '-b17' }
        '20'    : { $build = '-b26' }
        '11'    : { $build = '-b12' }
        '5'     : { $build = '-b13' }
        '0'     : { $build = '-b132' }
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
      }
    }
    '7'     : {
      case $oracle_java::min_version {
        '80'    : { $build = '-b15' }
        '79'    : { $build = '-b15' }
        '76'    : { $build = '-b13' }
        '75'    : { $build = '-b13' }
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
      fail("oracle_java module does not support Java SE version ${oracle_java::maj_version} (yet)")
    }
  }
}
