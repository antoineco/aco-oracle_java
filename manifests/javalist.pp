# == Class: oracle_java::javalist
#
# This class associates a Java version number to its expected build number and URL code (Java 8u121 onwards)
#
class oracle_java::javalist {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # associate build number to release version
  case $oracle_java::maj_version {
    '9'     : {
      case $oracle_java::min_version {
        '0'     : { $buildnumber = '+181' }
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
      }
    }
    '8'     : {
      case $oracle_java::min_version {
        '144'   : { $buildnumber   = '-b01'
                    $urlcodeoracle = '/090f390dda5b47b9b721c7dfaa008135' }
        '141'   : { $buildnumber   = '-b15'
                    $urlcodeoracle = '/336fa29ff2bb4ef291e347e091f7f4a7' }
        '131'   : { $buildnumber   = '-b11'
                    $urlcodeoracle = '/d54c1d3a095b4ff2b6607d096fa80163' }
        '121'   : { $buildnumber   = '-b13'
                    $urlcodeoracle = '/e9e7ea248e2c4826b92b3f075a80e441' }
        '112'   : { $buildnumber = '-b15' }
        '111'   : { $buildnumber = '-b14' }
        '102'   : { $buildnumber = '-b14' }
        '101'   : { $buildnumber = '-b13' }
        '92'    : { $buildnumber = '-b14' }
        '91'    : { $buildnumber = '-b14' }
        '77'    : { $buildnumber = '-b03' }
        '72'    : { $buildnumber = '-b15' }
        '71'    : { $buildnumber = '-b15' }
        '66'    : { $buildnumber = '-b17' }
        '65'    : { $buildnumber = '-b17' }
        '60'    : { $buildnumber = '-b27' }
        '51'    : { $buildnumber = '-b16' }
        '45'    : { $buildnumber = '-b14' }
        '40'    : { $buildnumber = '-b25' }
        '31'    : { $buildnumber = '-b13' }
        '25'    : { $buildnumber = '-b17' }
        '20'    : { $buildnumber = '-b26' }
        '11'    : { $buildnumber = '-b12' }
        '5'     : { $buildnumber = '-b13' }
        '0'     : { $buildnumber = '-b132' }
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
      }
    }
    '7'     : {
      case $oracle_java::min_version {
        '80'    : { $buildnumber = '-b15' }
        '79'    : { $buildnumber = '-b15' }
        '76'    : { $buildnumber = '-b13' }
        '75'    : { $buildnumber = '-b13' }
        '72'    : { $buildnumber = '-b14' }
        '71'    : { $buildnumber = '-b14' }
        '67'    : { $buildnumber = '-b01' }
        '65'    : { $buildnumber = '-b17' }
        '60'    : { $buildnumber = '-b19' }
        '55'    : { $buildnumber = '-b13' }
        '51'    : { $buildnumber = '-b13' }
        '45'    : { $buildnumber = '-b18' }
        '40'    : { $buildnumber = '-b43' }
        '25'    : { $buildnumber = '-b15' }
        '21'    : { $buildnumber = '-b11' }
        '17'    : { $buildnumber = '-b02' }
        '15'    : { $buildnumber = '-b03' }
        '13'    : { $buildnumber = '-b20' }
        '11'    : { $buildnumber = '-b21' }
        '10'    : { $buildnumber = '-b18' }
        '9'     : { $buildnumber = '-b05' }
        '7'     : { $buildnumber = '-b10' }
        '6'     : { $buildnumber = '-b24' }
        '5'     : { $buildnumber = '-b06' }
        '4'     : { $buildnumber = '-b20' }
        '3'     : { $buildnumber = '-b04' }
        '2'     : { $buildnumber = '-b13' }
        '1'     : { $buildnumber = '-b08' }
        '0'     : { $buildnumber = '' }
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
      }
    }
    '6'     : {
      case $oracle_java::min_version {
        '45'    : { $buildnumber = '-b06' }
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
      }
    }
    default : {
      fail("oracle_java module does not support Java SE version ${oracle_java::maj_version} (yet)")
    }
  }

  #set url code
  $urlcode = defined('$urlcodeoracle') ? {
    true    => $urlcodeoracle,
    default => ''
  }
}
