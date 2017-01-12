# == Define: oracle_java::installation
#
# Installs an extra version of Oracle Java
#
# === Parameters:
#
# [*version*]
#   Java SE version to install (valid format: 'major'u'minor' or just 'major'). Namevar
# [*type*]
#   envionment type to install (valid: 'jre'|'jdk')
# [*check_checksum*]
#   enable checksum validation on downloaded archives (boolean)
# [*add_alternative*]
#   add java alternative (boolean)
# [*custom_download_url*]
#   fetch the package from an alternative URL
# [*custom_checksum*]
#   use a custom checksum to verify the archive integrity
# [*proxy_server*]
#   proxy server url
# [*proxy_type*]
#   proxy server type (valid: 'none'|'http'|'https'|'ftp')
#
# === Actions:
#
# - Install Oracle jre/jdk
#
# === Requires:
#
# * oracle_java class
#
# === Sample Usage:
#
#  oracle_java::installation { '7u65':
#    type            => 'jre',
#    add_alternative => true
#  }
#
define oracle_java::installation (
  $version             = $name,
  $type                = 'jre',
  $check_checksum      = true,
  $add_alternative     = false,
  $custom_download_url = undef,
  $custom_checksum     = undef,
  $proxy_server        = undef,
  $proxy_type          = undef
  ) {

  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java defined resources')
  }

  # The install_path is taken from the main class
  $install_path = $oracle_java::install_path

  # parameters validation
  validate_re($version, '^([0-9]|[0-9]u[0-9]{1,3})$', '$version must be formated as \'major\'u\'minor\' or just \'major\'')
  validate_re($type, '^(jre|jdk)$', '$type must be either \'jre\' or \'jdk\'')
  validate_bool($check_checksum, $add_alternative)

  # set to latest release if no minor version was provided
  if $version == '8' {
    $version_real = '8u112'
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
  $version_final = delete($version_real, 'u0')
  $longversion = $min_version ? {
    '0'       => "${type}1.${maj_version}.0",
    /^[0-9]$/ => "${type}1.${maj_version}.0_0${min_version}",
    default   => "${type}1.${maj_version}.0_${min_version}"
  }

  # define installer filename
  case $maj_version {
    '6'     : { $filename = "${type}-${version_final}-linux-${arch}.bin" }
    default : { $filename = "${type}-${version_final}-linux-${arch}.tar.gz" }
  }

  # define download URL
  #-- start javalist --#
  # associate build number to release version
  case $maj_version {
    '8'     : {
      case $min_version {
        '112'   : { $build = '-b15' }
        '111'   : { $build = '-b14' }
        '102'   : { $build = '-b14' }
        '101'   : { $build = '-b13' }
        '92'    : { $build = '-b14' }
        '91'    : { $build = '-b14' }
        '77'    : { $build = '-b03' }
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
        default : { fail("Unreleased Java SE version ${version_real}") }
      }
    }
    '7'     : {
      case $min_version {
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
        default : { fail("Unreleased Java SE version ${version_real}") }
      }
    }
    '6'     : {
      case $min_version {
        '45'    : { $build = '-b06' }
        default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
      }
    }
    default : {
      fail("oracle_java module does not support Java SE version ${maj_version} (yet)")
    }
  }
  #-- end javalist --#
  if !$custom_download_url {
    $downloadurl = "http://download.oracle.com/otn-pub/java/jdk/${version_final}${build}/${filename}"
  } else {
    $downloadurl = $custom_download_url
  }

  # define package name
  if $maj_version == '8' and $min_version >= '20' {
    $packagename = $longversion
  } else {
    $packagename = $type
  }

  # -------------#
  # installation #
  # -------------#

  # dependency
  if !defined(Class['archive']) {
    include archive
  }

  # with checksum check
  if $check_checksum {
    #-- start checksum --#
    if !$custom_checksum {
      case $filename {
        # 8u112
        'jdk-8u112-linux-i586.tar.gz' : { $checksum = '66ccf8e7c28969d56863034d030134bf' }
        'jdk-8u112-linux-x64.tar.gz'  : { $checksum = 'de9b7a90f0f5a13cfcaa3b01451d0337' }
        'jre-8u112-linux-i586.tar.gz' : { $checksum = 'ff4e17ebd082b5c5bad457751468769d' }
        'jre-8u112-linux-x64.tar.gz'  : { $checksum = '5ccc09b2cbbf715b583fad72b070b69d' }
        # 8u111
        'jdk-8u111-linux-i586.tar.gz' : { $checksum = 'f3399a2c00560a8f5f9a652f7c67e493' }
        'jdk-8u111-linux-x64.tar.gz'  : { $checksum = '2d48badebe05c848cc3b4d6e0c53a457' }
        'jre-8u111-linux-i586.tar.gz' : { $checksum = '1f4844c81c6d6c5c24270054638f7628' }
        'jre-8u111-linux-x64.tar.gz'  : { $checksum = '38f7d7a29fd7346350da5a12179d05e7' }
        # 8u102
        'jdk-8u102-linux-i586.tar.gz' : { $checksum = '13ca2f1c15a71dde4e57436d5ce671f8' }
        'jdk-8u102-linux-x64.tar.gz'  : { $checksum = 'bac58dcec9bb85859810a2a6acba740b' }
        'jre-8u102-linux-i586.tar.gz' : { $checksum = '77199a65cc3dd11e6a5dbb3144fad968' }
        'jre-8u102-linux-x64.tar.gz'  : { $checksum = '18f4cfa3ad7b10dea718e74fd06e5f19' }
        # 8u101
        'jdk-8u101-linux-i586.tar.gz' : { $checksum = '4f4600815aa1adb5294278d471e890e3' }
        'jdk-8u101-linux-x64.tar.gz'  : { $checksum = 'a7ab8014716b0dac3adcaf5342167699' }
        'jre-8u101-linux-i586.tar.gz' : { $checksum = '70b99858124b1de5fe7b9bf484f1c735' }
        'jre-8u101-linux-x64.tar.gz'  : { $checksum = '967b7a0c51be657ec79ca27c559943d1' }
        # 8u92
        'jdk-8u92-linux-i586.tar.gz'  : { $checksum = '0f2839ff1066438123dac3404702a3ef' }
        'jdk-8u92-linux-x64.tar.gz'   : { $checksum = '65a1cc17ea362453a6e0eb4f13be76e4' }
        'jre-8u92-linux-i586.tar.gz'  : { $checksum = 'e2157870ce7f0484f347b8374da863a0' }
        'jre-8u92-linux-x64.tar.gz'   : { $checksum = 'df1371cec5c66c1039ccc3e7a433c1de' }
        # 8u91
        'jdk-8u91-linux-i586.tar.gz'  : { $checksum = 'f18cbe901f2c77630f1e301cea32b259' }
        'jdk-8u91-linux-x64.tar.gz'   : { $checksum = '3f3d7d0cd70bfe0feab382ed4b0e45c0' }
        'jre-8u91-linux-i586.tar.gz'  : { $checksum = '705521705f0ddaa150f64090e56ae96c' }
        'jre-8u91-linux-x64.tar.gz'   : { $checksum = 'cc48b4cacfeda1f699b43ea77ddfaa95' }
        # 8u77
        'jdk-8u77-linux-i586.tar.gz'  : { $checksum = 'e5bac32e2a7ab5cf9068ba92ba084472' }
        'jdk-8u77-linux-x64.tar.gz'   : { $checksum = 'ee501bef73ba7fac255f0593e595d8eb' }
        'jre-8u77-linux-i586.tar.gz'  : { $checksum = '2a92cc0efa5e087230b0b77cef8a569e' }
        'jre-8u77-linux-x64.tar.gz'   : { $checksum = '7e7d8d0918b4f81f6adde9fcb853a036' }
        # 8u72
        'jdk-8u72-linux-i586.tar.gz'  : { $checksum = '19e3ad9a6c8dc6d4ff042f459c06b6c4' }
        'jdk-8u72-linux-x64.tar.gz'   : { $checksum = '54cde24fc0596f0f05b5d0d8f329053d' }
        'jre-8u72-linux-i586.tar.gz'  : { $checksum = '625a5caea29984d36640aa0e59e5e52c' }
        'jre-8u72-linux-x64.tar.gz'   : { $checksum = 'f45932f9a3a9c38e47a60504d21449f8' }
        # 8u71
        'jdk-8u71-linux-i586.tar.gz'  : { $checksum = 'b794964aa840745235bac1409c90a9ac' }
        'jdk-8u71-linux-x64.tar.gz'   : { $checksum = '12db05061f8816d01bb234bbdc40fefa' }
        'jre-8u71-linux-i586.tar.gz'  : { $checksum = '9991e271ec34395c60eed9ee0b393a7c' }
        'jre-8u71-linux-x64.tar.gz'   : { $checksum = '345029226fff96c52ac300c5e01b32f8' }
        # 8u66
        'jdk-8u66-linux-i586.tar.gz'  : { $checksum = '8a1f36b29152856a5dd2c3953a4c24a1' }
        'jdk-8u66-linux-x64.tar.gz'   : { $checksum = '88f31f3d642c3287134297b8c10e61bf' }
        'jre-8u66-linux-i586.tar.gz'  : { $checksum = '4656044616b97e4f578680d1ef5d55c0' }
        'jre-8u66-linux-x64.tar.gz'   : { $checksum = 'af82cfb37e139458ae6297ae1bfc4f5e' }
        # 8u65
        'jdk-8u65-linux-i586.tar.gz'  : { $checksum = '7b715e1fe2316c94aaa968b23ce49c9a' }
        'jdk-8u65-linux-x64.tar.gz'   : { $checksum = '196880a42c45ec9ab2f00868d69619c0' }
        'jre-8u65-linux-i586.tar.gz'  : { $checksum = '3c3deab4f2cc4df8b7f56a63dc541236' }
        'jre-8u65-linux-x64.tar.gz'   : { $checksum = 'abe147a99744b19df86e0e08010fff6c' }
        # 8u60
        'jdk-8u60-linux-i586.tar.gz'  : { $checksum = 'a46d706babbd63f459d7ca6d4057d80f' }
        'jdk-8u60-linux-x64.tar.gz'   : { $checksum = 'b8ca513d4f439782c019cb78cd7fd101' }
        'jre-8u60-linux-i586.tar.gz'  : { $checksum = '51512cfe055125570b5215a48a553d83' }
        'jre-8u60-linux-x64.tar.gz'   : { $checksum = 'e6e44f44b67c1a412f06694c9c30b77f' }
        # 8u51
        'jdk-8u51-linux-i586.tar.gz'  : { $checksum = '742b9151d9190a9ae7d8ed05c7d39850' }
        'jdk-8u51-linux-x64.tar.gz'   : { $checksum = 'b34ff02c5d98b6f372288c17e96c51cf' }
        'jre-8u51-linux-i586.tar.gz'  : { $checksum = 'f234dacdff97e6ac5ff3e85d58f2d158' }
        'jre-8u51-linux-x64.tar.gz'   : { $checksum = '3c4e3ed6b1c61fe18b9a88ea8b2d9384' }
        # 8u45
        'jdk-8u45-linux-i586.tar.gz'  : { $checksum = 'e68241caf30cb81ae4e985be7218bb6d' }
        'jdk-8u45-linux-x64.tar.gz'   : { $checksum = '1ad9a5be748fb75b31cd3bd3aa339cac' }
        'jre-8u45-linux-i586.tar.gz'  : { $checksum = 'def512ee71620662c7f4631bed7da183' }
        'jre-8u45-linux-x64.tar.gz'   : { $checksum = '58486d7b16d7b21fbea7374adc109233' }
        # 8u40
        'jdk-8u40-linux-i586.tar.gz'  : { $checksum = '1c4b119e7f25da30fa1d0ba62deb66f9' }
        'jdk-8u40-linux-x64.tar.gz'   : { $checksum = '159a3186bb88b77b4eb9ff9971222736' }
        'jre-8u40-linux-i586.tar.gz'  : { $checksum = 'b22953df20789fc199877ad7d615d51e' }
        'jre-8u40-linux-x64.tar.gz'   : { $checksum = '394d5dbd541691413e5b8d01f2e720d6' }
        # 8u31
        'jdk-8u31-linux-i586.tar.gz'  : { $checksum = '4e9aec24367672412c7d10105a2a2bbb' }
        'jdk-8u31-linux-x64.tar.gz'   : { $checksum = '173e24bc2d5d5ca3469b8e34864a80da' }
        'jre-8u31-linux-i586.tar.gz'  : { $checksum = '6cb48241523ad39862c05d8cf791ce92' }
        'jre-8u31-linux-x64.tar.gz'   : { $checksum = 'c81a3cdabe4a12439dae08d4311670ff' }
        # 8u25
        'jdk-8u25-linux-i586.tar.gz'  : { $checksum = 'b5b16247f66643727d9b6d4bc7c5efda' }
        'jdk-8u25-linux-x64.tar.gz'   : { $checksum = 'e145c03a7edc845215092786bcfba77e' }
        'jre-8u25-linux-i586.tar.gz'  : { $checksum = '22d970566c418499d331a2099d77c548' }
        'jre-8u25-linux-x64.tar.gz'   : { $checksum = 'f4f7f7335eaf2e7b5ff455abece9d5ed' }
        # 8u20
        'jdk-8u20-linux-i586.tar.gz'  : { $checksum = '5dafdef064e18468f21c65051a6918d7' }
        'jdk-8u20-linux-x64.tar.gz'   : { $checksum = 'ec7f89dc3697b402e2c851d0488f6299' }
        'jre-8u20-linux-i586.tar.gz'  : { $checksum = '488ebb6b67e2c822ad886c399e4255d6' }
        'jre-8u20-linux-x64.tar.gz'   : { $checksum = '01cd08eade026ba10d9748a66c2cbb8e' }
        # 8u11
        'jdk-8u11-linux-i586.tar.gz'  : { $checksum = '252bd6545d765ccf9d52ac3ef2ebf0aa' }
        'jdk-8u11-linux-x64.tar.gz'   : { $checksum = '13ee1d0bf6baaf2b119115356f234a48' }
        'jre-8u11-linux-i586.tar.gz'  : { $checksum = '329c93351f0fcbc832fdf76a406dfbc3' }
        'jre-8u11-linux-x64.tar.gz'   : { $checksum = '05b6ce6ce8133c390cd4c5df58434743' }
        # 8u5
        'jdk-8u5-linux-i586.tar.gz'   : { $checksum = 'fb0e8b5c0be11521bccec5d667559e76' }
        'jdk-8u5-linux-x64.tar.gz'    : { $checksum = 'adc3827532741873de9216a5aed883ed' }
        'jre-8u5-linux-i586.tar.gz'   : { $checksum = '14f8b937e76d30bf2904d343d126a4b4' }
        'jre-8u5-linux-x64.tar.gz'    : { $checksum = 'd0aab3d18f7ffe7310ed3a72a19efac1' }
        # 8u0
        'jdk-8-linux-i586.tar.gz'     : { $checksum = '45556e463a561b470bd9d0c07a73effb' }
        'jdk-8-linux-x64.tar.gz'      : { $checksum = '7e9e5e5229c6603a4d8476050bbd98b1' }
        'jre-8-linux-i586.tar.gz'     : { $checksum = '045a0309585e546fa2da2316309c09ea' }
        'jre-8-linux-x64.tar.gz'      : { $checksum = '1e024eb9b0f7f61722e10fc08c873543' }
        # 7u80
        'jdk-7u80-linux-i586.tar.gz'  : { $checksum = '0811a4045714bd8f1e1577e318528597' }
        'jdk-7u80-linux-x64.tar.gz'   : { $checksum = '6152f8a7561acf795ca4701daa10a965' }
        'jre-7u80-linux-i586.tar.gz'  : { $checksum = 'ff0f6847e51b6be5c241615a73043005' }
        'jre-7u80-linux-x64.tar.gz'   : { $checksum = 'c0e01ae8683b2d8924ce79cd6ce6a691' }
        # 7u79
        'jdk-7u79-linux-i586.tar.gz'  : { $checksum = 'b0ed59147c77a6d3e63a7b340e4e1d28' }
        'jdk-7u79-linux-x64.tar.gz'   : { $checksum = '9222e097e624800fdd9bfb568169ccad' }
        'jre-7u79-linux-i586.tar.gz'  : { $checksum = 'eba02bbd1dcb9546fed93a9854b84ed9' }
        'jre-7u79-linux-x64.tar.gz'   : { $checksum = 'fcd884a57920d90fa23240abb403fcf5' }
        # 7u76
        'jdk-7u76-linux-i586.tar.gz'  : { $checksum = '566dcbcedbb9ec5a26f08bd65b14746b' }
        'jdk-7u76-linux-x64.tar.gz'   : { $checksum = '5a98b1a3e4c48363d03f664f173bbb9a' }
        'jre-7u76-linux-i586.tar.gz'  : { $checksum = 'e7eb5d65eab8f57cbf0d5da804327f75' }
        'jre-7u76-linux-x64.tar.gz'   : { $checksum = 'a5ee5fd266453e0209e45fb8bb5acd6d' }
        # 7u75
        'jdk-7u75-linux-i586.tar.gz'  : { $checksum = 'e4371a4fddc049eca3bfef293d812b8e' }
        'jdk-7u75-linux-x64.tar.gz'   : { $checksum = '6f1f81030a34f7a9c987f8b68a24d139' }
        'jre-7u75-linux-i586.tar.gz'  : { $checksum = '3a2a94b9cd76fa1323dd9a5aaf48383b' }
        'jre-7u75-linux-x64.tar.gz'   : { $checksum = '1869f0d2dac96372e3c345105543ba3e' }
        # 7u72
        'jdk-7u72-linux-i586.tar.gz'  : { $checksum = '4a942a47a700e63e050dd66e8ca08a1f' }
        'jdk-7u72-linux-x64.tar.gz'   : { $checksum = 'cfa44b49e50ea06e5c6ab95ff79e5b2a' }
        'jre-7u72-linux-i586.tar.gz'  : { $checksum = 'a66052322c1a26c33bf6078cb4040dfb' }
        'jre-7u72-linux-x64.tar.gz'   : { $checksum = '4ae2ef732dfd309e86a182ca0f7681fe' }
        # 7u71
        'jdk-7u71-linux-i586.tar.gz'  : { $checksum = '54899d0733d9a8697da59de79a02cc8f' }
        'jdk-7u71-linux-x64.tar.gz'   : { $checksum = '22761b214b1505f1a9671b124b0f44f4' }
        'jre-7u71-linux-i586.tar.gz'  : { $checksum = '90a6b9e2a32d06c18a3f16b485f0d1ea' }
        'jre-7u71-linux-x64.tar.gz'   : { $checksum = '7605134662f6c87131eca5745895fe84' }
        # 7u67
        'jdk-7u67-linux-i586.tar.gz'  : { $checksum = '715b0e8ba2a06bded75f6a92427e2701' }
        'jdk-7u67-linux-x64.tar.gz'   : { $checksum = '81e3e2df33e13781e5fac5756ed90e67' }
        'jre-7u67-linux-i586.tar.gz'  : { $checksum = '2a256eb2a91f0084e58c612636342c2b' }
        'jre-7u67-linux-x64.tar.gz'   : { $checksum = '9007c79167be0177fb47e5313c53d5cb' }
        # 7u65
        'jdk-7u65-linux-i586.tar.gz'  : { $checksum = 'bfe1f792918aca2fbe53157061e2145c' }
        'jdk-7u65-linux-x64.tar.gz'   : { $checksum = 'c223bdbaf706f986f7a5061a204f641f' }
        'jre-7u65-linux-i586.tar.gz'  : { $checksum = 'd11d9f4488d75106fc8909b847efaeda' }
        'jre-7u65-linux-x64.tar.gz'   : { $checksum = '2f5c128568f697e918c5259d7bcf2fae' }
        # 7u60
        'jdk-7u60-linux-i586.tar.gz'  : { $checksum = 'b33c914b03e46c3e7c33e4bdddbec4bd' }
        'jdk-7u60-linux-x64.tar.gz'   : { $checksum = 'eba4b121b8a363f583679d7cb2e69d28' }
        'jre-7u60-linux-i586.tar.gz'  : { $checksum = '331a7ef8230de0939941d1e9b3b761fd' }
        'jre-7u60-linux-x64.tar.gz'   : { $checksum = '53a787c9a3170308641074cd86606a99' }
        # 7u55
        'jdk-7u55-linux-i586.tar.gz'  : { $checksum = 'fec08edfd805ffcc34a1c20f38a9cc65' }
        'jdk-7u55-linux-x64.tar.gz'   : { $checksum = '9e1fb7936f0e5aaa1e64d36ba640bc1f' }
        'jre-7u55-linux-i586.tar.gz'  : { $checksum = '9e363fb6fdd072d04aa5862a8e06e6c2' }
        'jre-7u55-linux-x64.tar.gz'   : { $checksum = '5dea1a4d745c55c933ef87c8227c4bd5' }
        # 7u51
        'jdk-7u51-linux-i586.tar.gz'  : { $checksum = '909d353c1caf6b3b54cc20767a7778ef' }
        'jdk-7u51-linux-x64.tar.gz'   : { $checksum = '764f96c4b078b80adaa5983e75470ff2' }
        'jre-7u51-linux-i586.tar.gz'  : { $checksum = 'f133f125ca93acef3f70d1912cc2f4b0' }
        'jre-7u51-linux-x64.tar.gz'   : { $checksum = '1f6a93cc5ef5f66bb01bc39fd731cd9f' }
        # 7u45
        'jdk-7u45-linux-i586.tar.gz'  : { $checksum = '66b47e77d963c5dd652f0c5d3b03cb52' }
        'jdk-7u45-linux-x64.tar.gz'   : { $checksum = 'bea330fcbcff77d31878f21753e09b30' }
        'jre-7u45-linux-i586.tar.gz'  : { $checksum = '7fa0cf09846e96b367526c95f33bb278' }
        'jre-7u45-linux-x64.tar.gz'   : { $checksum = 'e82743de29c6cb59ae09bbcb090ccbee' }
        # 7u40
        'jdk-7u40-linux-i586.tar.gz'  : { $checksum = '0079cecc8c4d0f088ace5d0ea99d0c5c' }
        'jdk-7u40-linux-x64.tar.gz'   : { $checksum = '511ea34e4a42955bc03c28afa4b8f6cf' }
        'jre-7u40-linux-i586.tar.gz'  : { $checksum = '3e7f53fb5a3a7a4ba57343b1160fe67f' }
        'jre-7u40-linux-x64.tar.gz'   : { $checksum = '0c775aa90b4c4919b000949f02e0ec5b' }
        # 7u25
        'jdk-7u25-linux-i586.tar.gz'  : { $checksum = '23176d0ebf9dedd21e3150b4bb0ee776' }
        'jdk-7u25-linux-x64.tar.gz'   : { $checksum = '83ba05e260813f7a9140b76e3d37ea33' }
        'jre-7u25-linux-i586.tar.gz'  : { $checksum = '0e9ccefe49e937e592dbb605f2e8e7d8' }
        'jre-7u25-linux-x64.tar.gz'   : { $checksum = '743ee0ebf73ce428c912866d84e374e0' }
        # 7u21
        'jdk-7u21-linux-i586.tar.gz'  : { $checksum = 'fc0241e1a3e243602698ac700abc94e9' }
        'jdk-7u21-linux-x64.tar.gz'   : { $checksum = '3ceef66377b6d87144b802960f5e715b' }
        'jre-7u21-linux-i586.tar.gz'  : { $checksum = 'd1df6cbb7c2b5cc7e9dd05b3e8e838f9' }
        'jre-7u21-linux-x64.tar.gz'   : { $checksum = 'ad983b63a4d342f2db249a37f1fd6cc3' }
        # 7u17
        'jdk-7u17-linux-i586.tar.gz'  : { $checksum = '694f9592d894b86a8a3cb56bf71768e6' }
        'jdk-7u17-linux-x64.tar.gz'   : { $checksum = 'd9b5870a94c47efa0282d6c1863d0667' }
        'jre-7u17-linux-i586.tar.gz'  : { $checksum = '1ff65703df3cffbe98a6bc477db58e81' }
        'jre-7u17-linux-x64.tar.gz'   : { $checksum = '23e2949c86471ef9bbdfaac525deccea' }
        # 7u15
        'jdk-7u15-linux-i586.tar.gz'  : { $checksum = '6ebab8e0942706af2f7f5e0195a96f2c' }
        'jdk-7u15-linux-x64.tar.gz'   : { $checksum = '118a16aab9ff2c3f7c7788658cc77734' }
        'jre-7u15-linux-i586.tar.gz'  : { $checksum = '5c29a3adfd166a56c306ac297ab554d6' }
        'jre-7u15-linux-x64.tar.gz'   : { $checksum = 'ecb902aec2e7aabe7d8dc41e0b716723' }
        # 7u13
        'jdk-7u13-linux-i586.tar.gz'  : { $checksum = '2e129b77f7c2640dde08c267ed000c49' }
        'jdk-7u13-linux-x64.tar.gz'   : { $checksum = '5286b7e752fb8814d85124cb623ff045' }
        'jre-7u13-linux-i586.tar.gz'  : { $checksum = 'e34988dda917e5bb6a134eb56d41215d' }
        'jre-7u13-linux-x64.tar.gz'   : { $checksum = 'ae24d12dc8b390be02fa3dc84f1bd9fd' }
        # 7u11
        'jdk-7u11-linux-i586.tar.gz'  : { $checksum = '22239a786477a7d21bc8a835455ca24a' }
        'jdk-7u11-linux-x64.tar.gz'   : { $checksum = 'd8f65419fa65f179382ae310237fd1f4' }
        'jre-7u11-linux-i586.tar.gz'  : { $checksum = '76b71067cacddbee8d78db99ffa3d075' }
        'jre-7u11-linux-x64.tar.gz'   : { $checksum = '78872a8326394b5aeb1ac58288db66ed' }
        # 7u10
        'jdk-7u10-linux-i586.tar.gz'  : { $checksum = 'd890ad93e1d48c17b980fa3ada65c1be' }
        'jdk-7u10-linux-x64.tar.gz'   : { $checksum = '2a75b5510bdb7360b9279a6f659d054a' }
        'jre-7u10-linux-i586.tar.gz'  : { $checksum = '09ad4d62e64cdcf116c4f86290a62f46' }
        'jre-7u10-linux-x64.tar.gz'   : { $checksum = '9ce426628b1cb2c16dd05fbd906440aa' }
        # 7u9
        'jdk-7u9-linux-i586.tar.gz'   : { $checksum = 'f66c309ab38d6ba6651f7d98cd58d9d5' }
        'jdk-7u9-linux-x64.tar.gz'    : { $checksum = '372b9dcde93230522672837e1820f939' }
        'jre-7u9-linux-i586.tar.gz'   : { $checksum = '56178ed00dab2ebd8268caf5575743f4' }
        'jre-7u9-linux-x64.tar.gz'    : { $checksum = '8e17fa7b2152ab11f915c6936542cc12' }
        # 7u7
        'jdk-7u7-linux-i586.tar.gz'   : { $checksum = '5a46b8e1904cc9f94e6102f3e9d3deb8' }
        'jdk-7u7-linux-x64.tar.gz'    : { $checksum = '15f4b80901111f002894c33a3d78124c' }
        'jre-7u7-linux-i586.tar.gz'   : { $checksum = 'ea99bedd9db33e9e2970f4b70abd1e4b' }
        'jre-7u7-linux-x64.tar.gz'    : { $checksum = '5aa9bd26cdf1fa6afd2b15826b4ba139' }
        # 7u6
        'jdk-7u6-linux-i586.tar.gz'   : { $checksum = '3ddb72969d92485e8ec9b32dc065130b' }
        'jdk-7u6-linux-x64.tar.gz'    : { $checksum = '2178f5f10dadaed75c1476805a3d04d8' }
        'jre-7u6-linux-i586.tar.gz'   : { $checksum = '094ea2232f9b19dd56683728b2de98ab' }
        'jre-7u6-linux-x64.tar.gz'    : { $checksum = 'f0339e3251c4acecdf824d5acce87c36' }
        # 7u5
        'jdk-7u5-linux-i586.tar.gz'   : { $checksum = 'b3cc5eabc8027529025e48270120429b' }
        'jdk-7u5-linux-x64.tar.gz'    : { $checksum = 'c3b4dc26274b86fc3cd4b77ef04fea83' }
        'jre-7u5-linux-i586.tar.gz'   : { $checksum = '621131c104d77c6ca5e58784861dd060' }
        'jre-7u5-linux-x64.tar.gz'    : { $checksum = '4c8850b82a536480cddd771012426f1b' }
        # 7u4
        'jdk-7u4-linux-i586.tar.gz'   : { $checksum = '8e271abb32ac6ce199ba15ee5beb758b' }
        'jdk-7u4-linux-x64.tar.gz'    : { $checksum = 'a5ebe416c83b64a68c463a4a65f9e882' }
        'jre-7u4-linux-i586.tar.gz'   : { $checksum = '8e6db43d9a7cac724be2cb9d1329e702' }
        'jre-7u4-linux-x64.tar.gz'    : { $checksum = '49da2f0c288f96ed255ed75b796a5455' }
        # 7u3
        'jdk-7u3-linux-i586.tar.gz'   : { $checksum = '99a0fa02b608985c271e55122f0621bf' }
        'jdk-7u3-linux-x64.tar.gz'    : { $checksum = '969927251b558ffbc09ede1e89200d40' }
        'jre-7u3-linux-i586.tar.gz'   : { $checksum = 'cfce10a05f8d152d39aef892f2cd4011' }
        'jre-7u3-linux-x64.tar.gz'    : { $checksum = '3d3e206cea84129f1daa8e62bf656a28' }
        # 7u2
        'jdk-7u2-linux-i586.tar.gz'   : { $checksum = '8a06141ffae6c96743ea405b75e54f84' }
        'jdk-7u2-linux-x64.tar.gz'    : { $checksum = 'a0bbb9265b4633cfd7823928649f450c' }
        'jre-7u2-linux-i586.tar.gz'   : { $checksum = '78923ef097586c36a6242c54cb20abd7' }
        'jre-7u2-linux-x64.tar.gz'    : { $checksum = 'c6d0aa62337148787795870a12c17974' }
        # 7u1
        'jdk-7u1-linux-i586.tar.gz'   : { $checksum = '7267759f93bc6fb23046dd42d40d1c2f' }
        'jdk-7u1-linux-x64.tar.gz'    : { $checksum = '9707049b591f47e5c3988a9f029c015e' }
        'jre-7u1-linux-i586.tar.gz'   : { $checksum = 'd9b73cc5ccaa4f0b36cd6b8b62d07142' }
        'jre-7u1-linux-x64.tar.gz'    : { $checksum = '07bd73571b7028b73fc8ed19bc85226d' }
        # 7u0
        'jdk-7-linux-i586.tar.gz'     : { $checksum = 'f97244a104f03731e5ff69f0dd5a9927' }
        'jdk-7-linux-x64.tar.gz'      : { $checksum = 'b3c1ef5faea7b180469c129a49762b64' }
        'jre-7-linux-i586.tar.gz'     : { $checksum = '1c368a19835834a08b9aabd806a1b2d6' }
        'jre-7-linux-x64.tar.gz'      : { $checksum = '27b14f437db6db6922c753472305c13c' }
        # 6u45
        'jdk-6u45-linux-i586.bin'     : { $checksum = '3269370b7c34e6cbfed8785d3d0c5cbd' }
        'jdk-6u45-linux-x64.bin'      : { $checksum = '40c1a87563c5c6a90a0ed6994615befe' }
        'jre-6u45-linux-i586.bin'     : { $checksum = '1d8001ef61a2e3a11fe7b9eec9f08948' }
        'jre-6u45-linux-x64.bin'      : { $checksum = '4a4569126f05f525f48bacf761f7185c' }
        default                       : { fail("Unknown checksum for file ${filename}") }
      }
    } else {
      $checksum = $custom_checksum
    }
    #-- end checksum --#
    Archive {
      checksum      => $checksum,
      checksum_type => 'md5'
    }
  }

  Archive {
    cookie       => 'oraclelicense=accept-securebackup-cookie',
    source       => $downloadurl,
    proxy_server => $proxy_server,
    proxy_type   => $proxy_type,
    require      => File[$install_path]
  }

  # download archive
  if $maj_version == '6' {
    archive { "${install_path}/${filename}":
      cleanup => false,
      extract => false
    }
  } else {
    # also extract and clean up if tar.gz
    archive { "${install_path}/${filename}":
      cleanup      => true,
      extract      => true,
      extract_path => $install_path,
      creates      => "${install_path}/${longversion}"
    }
  }

  # the procedure is a bit more complicated for Java 6...
  # files are packaged into an unzipsfx archive which has to be extracted
  if $maj_version == '6' {
    exec { "unpack java ${version_final} files":
      path    => '/bin',
      cwd     => $install_path,
      creates => "${install_path}/${longversion}",
      command => "chmod +x ${filename}; ./${filename}"
    }
  }

  # fix permissions
  file { "${install_path}/${longversion}":
    recurse  => true,
    owner    => 'root',
    group    => 'root',
    loglevel => debug
  }

  # -------------#
  # installation #
  # -------------#

  if $add_alternative {
    # priority based on java version
    $priority = 1000000 + $maj_version * 100000 + $min_version

    Exec {
      path    => '/bin:/sbin:/usr/bin:/usr/sbin',
      require => File["${install_path}/${longversion}"],
      unless  => "update-alternatives --display java | grep -e ${install_path}/${longversion}/bin/java.*${priority}\$"
    }

    case $::osfamily {
      /RedHat|Suse/ : {
        case $type {
          'jdk'   : {
            exec { "add java alternative ${version_final}":
              command => "update-alternatives --install /usr/bin/java java ${install_path}/${longversion}/bin/java ${priority} \
                         --slave /usr/bin/appletviewer appletviewer ${install_path}/${longversion}/bin/appletviewer \
                         --slave /usr/bin/extcheck extcheck ${install_path}/${longversion}/bin/extcheck \
                         --slave /usr/bin/idlj idlj ${install_path}/${longversion}/bin/idlj \
                         --slave /usr/bin/jar jar ${install_path}/${longversion}/bin/jar \
                         --slave /usr/bin/jarsigner jarsigner ${install_path}/${longversion}/bin/jarsigner \
                         --slave /usr/bin/javac javac ${install_path}/${longversion}/bin/javac \
                         --slave /usr/bin/javadoc javadoc ${install_path}/${longversion}/bin/javadoc \
                         --slave /usr/bin/javafxpackager javafxpackager ${install_path}/${longversion}/bin/javafxpackager \
                         --slave /usr/bin/javah javah ${install_path}/${longversion}/bin/javah \
                         --slave /usr/bin/javap javap ${install_path}/${longversion}/bin/javap \
                         --slave /usr/bin/javapackager javapackager ${install_path}/${longversion}/bin/javapackager \
                         --slave /usr/bin/java-rmi.cgi java-rmi.cgi ${install_path}/${longversion}/bin/java-rmi.cgi \
                         --slave /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws \
                         --slave /usr/bin/jcmd jcmd ${install_path}/${longversion}/bin/jcmd \
                         --slave /usr/bin/jconsole jconsole ${install_path}/${longversion}/bin/jconsole \
                         --slave /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol \
                         --slave /usr/bin/jdb jdb ${install_path}/${longversion}/bin/jdb \
                         --slave /usr/bin/jdeps jdeps ${install_path}/${longversion}/bin/jdeps \
                         --slave /usr/bin/jhat jhat ${install_path}/${longversion}/bin/jhat \
                         --slave /usr/bin/jinfo jinfo ${install_path}/${longversion}/bin/jinfo \
                         --slave /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs \
                         --slave /usr/bin/jmap jmap ${install_path}/${longversion}/bin/jmap \
                         --slave /usr/bin/jmc jmc ${install_path}/${longversion}/bin/jmc \
                         --slave /usr/bin/jps jps ${install_path}/${longversion}/bin/jps \
                         --slave /usr/bin/jrunscript jrunscript ${install_path}/${longversion}/bin/jrunscript \
                         --slave /usr/bin/jsadebugd jsadebugd ${install_path}/${longversion}/bin/jsadebugd \
                         --slave /usr/bin/jstack jstack ${install_path}/${longversion}/bin/jstack \
                         --slave /usr/bin/jstat jstat ${install_path}/${longversion}/bin/jstat \
                         --slave /usr/bin/jstatd jstatd ${install_path}/${longversion}/bin/jstatd \
                         --slave /usr/bin/jvisualvm jvisualvm ${install_path}/${longversion}/bin/jvisualvm \
                         --slave /usr/bin/keytool keytool ${install_path}/${longversion}/bin/keytool \
                         --slave /usr/bin/native2ascii native2ascii ${install_path}/${longversion}/bin/native2ascii \
                         --slave /usr/bin/orbd orbd ${install_path}/${longversion}/bin/orbd \
                         --slave /usr/bin/pack200 pack200 ${install_path}/${longversion}/bin/pack200 \
                         --slave /usr/bin/policytool policytool ${install_path}/${longversion}/bin/policytool \
                         --slave /usr/bin/rmic rmic ${install_path}/${longversion}/bin/rmic \
                         --slave /usr/bin/rmid rmid ${install_path}/${longversion}/bin/rmid \
                         --slave /usr/bin/rmiregistry rmiregistry ${install_path}/${longversion}/bin/rmiregistry \
                         --slave /usr/bin/schemagen schemagen ${install_path}/${longversion}/bin/schemagen \
                         --slave /usr/bin/serialver serialver ${install_path}/${longversion}/bin/serialver \
                         --slave /usr/bin/servertool servertool ${install_path}/${longversion}/bin/servertool \
                         --slave /usr/bin/tnameserv tnameserv ${install_path}/${longversion}/bin/tnameserv \
                         --slave /usr/bin/unpack200 unpack200 ${install_path}/${longversion}/bin/unpack200 \
                         --slave /usr/bin/wsgen wsgen ${install_path}/${longversion}/bin/wsgen \
                         --slave /usr/bin/wsimport wsimport ${install_path}/${longversion}/bin/wsimport \
                         --slave /usr/bin/xjc xjc ${install_path}/${longversion}/bin/xjc \
                         --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 ${install_path}/${longversion}/man/man1/appletviewer.1 \
                         --slave /usr/share/man/man1/extcheck.1 extcheck.1 ${install_path}/${longversion}/man/man1/extcheck.1 \
                         --slave /usr/share/man/man1/idlj.1 idlj.1 ${install_path}/${longversion}/man/man1/idlj.1 \
                         --slave /usr/share/man/man1/jar.1 jar.1 ${install_path}/${longversion}/man/man1/jar.1 \
                         --slave /usr/share/man/man1/jarsigner.1 jarsigner.1 ${install_path}/${longversion}/man/man1/jarsigner.1 \
                         --slave /usr/share/man/man1/java.1 java.1 ${install_path}/${longversion}/man/man1/java.1 \
                         --slave /usr/share/man/man1/javac.1 javac.1 ${install_path}/${longversion}/man/man1/javac.1 \
                         --slave /usr/share/man/man1/javadoc.1 javadoc.1 ${install_path}/${longversion}/man/man1/javadoc.1 \
                         --slave /usr/share/man/man1/javafxpackager.1 javafxpackager.1 ${install_path}/${longversion}/man/man1/javafxpackager.1 \
                         --slave /usr/share/man/man1/javah.1 javah.1 ${install_path}/${longversion}/man/man1/javah.1 \
                         --slave /usr/share/man/man1/javap.1 javap.1 ${install_path}/${longversion}/man/man1/javap.1 \
                         --slave /usr/share/man/man1/javapackager.1 javapackager.1 ${install_path}/${longversion}/man/man1/javapackager.1 \
                         --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1 \
                         --slave /usr/share/man/man1/jcmd.1 jcmd.1 ${install_path}/${longversion}/man/man1/jcmd.1 \
                         --slave /usr/share/man/man1/jconsole.1 jconsole.1 ${install_path}/${longversion}/man/man1/jconsole.1 \
                         --slave /usr/share/man/man1/jdb.1 jdb.1 ${install_path}/${longversion}/man/man1/jdb.1 \
                         --slave /usr/share/man/man1/jdeps.1 jdeps.1 ${install_path}/${longversion}/man/man1/jdeps.1 \
                         --slave /usr/share/man/man1/jhat.1 jhat.1 ${install_path}/${longversion}/man/man1/jhat.1 \
                         --slave /usr/share/man/man1/jinfo.1 jinfo.1 ${install_path}/${longversion}/man/man1/jinfo.1 \
                         --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1 \
                         --slave /usr/share/man/man1/jmap.1 jmap.1 ${install_path}/${longversion}/man/man1/jmap.1 \
                         --slave /usr/share/man/man1/jmc.1 jmc.1 ${install_path}/${longversion}/man/man1/jmc.1 \
                         --slave /usr/share/man/man1/jps.1 jps.1 ${install_path}/${longversion}/man/man1/jps.1 \
                         --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${install_path}/${longversion}/man/man1/jrunscript.1 \
                         --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 ${install_path}/${longversion}/man/man1/jsadebugd.1 \
                         --slave /usr/share/man/man1/jstack.1 jstack.1 ${install_path}/${longversion}/man/man1/jstack.1 \
                         --slave /usr/share/man/man1/jstat.1 jstat.1 ${install_path}/${longversion}/man/man1/jstat.1 \
                         --slave /usr/share/man/man1/jstatd.1 jstatd.1 ${install_path}/${longversion}/man/man1/jstatd.1 \
                         --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 ${install_path}/${longversion}/man/man1/jvisualvm.1 \
                         --slave /usr/share/man/man1/keytool.1 keytool.1 ${install_path}/${longversion}/man/man1/keytool.1 \
                         --slave /usr/share/man/man1/native2ascii.1 native2ascii.1 ${install_path}/${longversion}/man/man1/native2ascii.1 \
                         --slave /usr/share/man/man1/orbd.1 orbd.1 ${install_path}/${longversion}/man/man1/orbd.1 \
                         --slave /usr/share/man/man1/pack200.1 pack200.1 ${install_path}/${longversion}/man/man1/pack200.1 \
                         --slave /usr/share/man/man1/policytool.1 policytool.1 ${install_path}/${longversion}/man/man1/policytool.1 \
                         --slave /usr/share/man/man1/rmic.1 rmic.1 ${install_path}/${longversion}/man/man1/rmic.1 \
                         --slave /usr/share/man/man1/rmid.1 rmid.1 ${install_path}/${longversion}/man/man1/rmid.1 \
                         --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 ${install_path}/${longversion}/man/man1/rmiregistry.1 \
                         --slave /usr/share/man/man1/schemagen.1 schemagen.1 ${install_path}/${longversion}/man/man1/schemagen.1 \
                         --slave /usr/share/man/man1/serialver.1 serialver.1 ${install_path}/${longversion}/man/man1/serialver.1 \
                         --slave /usr/share/man/man1/servertool.1 servertool.1 ${install_path}/${longversion}/man/man1/servertool.1 \
                         --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 ${install_path}/${longversion}/man/man1/tnameserv.1 \
                         --slave /usr/share/man/man1/unpack200.1 unpack200.1 ${install_path}/${longversion}/man/man1/unpack200.1 \
                         --slave /usr/share/man/man1/wsgen.1 wsgen.1 ${install_path}/${longversion}/man/man1/wsgen.1 \
                         --slave /usr/share/man/man1/wsimport.1 wsimport.1 ${install_path}/${longversion}/man/man1/wsimport.1 \
                         --slave /usr/share/man/man1/xjc.1 xjc.1 ${install_path}/${longversion}/man/man1/xjc.1"
            }
          }
          default : {
            exec { "add java alternative ${version_final}":
              command => "update-alternatives --install /usr/bin/java java ${install_path}/${longversion}/bin/java ${priority} \
                         --slave /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws \
                         --slave /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol \
                         --slave /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs \
                         --slave /usr/bin/keytool keytool ${install_path}/${longversion}/bin/keytool \
                         --slave /usr/bin/orbd orbd ${install_path}/${longversion}/bin/orbd \
                         --slave /usr/bin/pack200 pack200 ${install_path}/${longversion}/bin/pack200 \
                         --slave /usr/bin/policytool policytool ${install_path}/${longversion}/bin/policytool \
                         --slave /usr/bin/rmid rmid ${install_path}/${longversion}/bin/rmid \
                         --slave /usr/bin/rmiregistry rmiregistry ${install_path}/${longversion}/bin/rmiregistry \
                         --slave /usr/bin/servertool servertool ${install_path}/${longversion}/bin/servertool \
                         --slave /usr/bin/tnameserv tnameserv ${install_path}/${longversion}/bin/tnameserv \
                         --slave /usr/bin/unpack200 unpack200 ${install_path}/${longversion}/bin/unpack200 \
                         --slave /usr/share/man/man1/java.1 java.1 ${install_path}/${longversion}/man/man1/java.1 \
                         --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1 \
                         --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1 \
                         --slave /usr/share/man/man1/keytool.1 keytool.1 ${install_path}/${longversion}/man/man1/keytool.1 \
                         --slave /usr/share/man/man1/orbd.1 orbd.1 ${install_path}/${longversion}/man/man1/orbd.1 \
                         --slave /usr/share/man/man1/pack200.1 pack200.1 ${install_path}/${longversion}/man/man1/pack200.1 \
                         --slave /usr/share/man/man1/policytool.1 policytool.1 ${install_path}/${longversion}/man/man1/policytool.1 \
                         --slave /usr/share/man/man1/rmid.1 rmid.1 ${install_path}/${longversion}/man/man1/rmid.1 \
                         --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 ${install_path}/${longversion}/man/man1/rmiregistry.1 \
                         --slave /usr/share/man/man1/servertool.1 servertool.1 ${install_path}/${longversion}/man/man1/servertool.1 \
                         --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 ${install_path}/${longversion}/man/man1/tnameserv.1 \
                         --slave /usr/share/man/man1/unpack200.1 unpack200.1 ${install_path}/${longversion}/man/man1/unpack200.1"
            }
          }
        } #-- case $type
      } #-- case $::osfamily == RedHat
      'Debian'      : {
        case $type {
          'jdk'   : {
            exec { "add java alternative ${version_final}":
              command => "update-alternatives --install /usr/bin/java java ${install_path}/${longversion}/bin/java ${priority} \
                           --slave /usr/share/man/man1/java.1 java.1 ${install_path}/${longversion}/man/man1/java.1;
                          update-alternatives --install /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws ${priority} \
                           --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1;
                          update-alternatives --install /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol ${priority};
                          update-alternatives --install /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs ${priority} \
                           --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1;
                          update-alternatives --install /usr/bin/keytool keytool ${install_path}/${longversion}/bin/keytool ${priority} \
                           --slave /usr/share/man/man1/keytool.1 keytool.1 ${install_path}/${longversion}/man/man1/keytool.1;
                          update-alternatives --install /usr/bin/orbd orbd ${install_path}/${longversion}/bin/orbd ${priority} \
                           --slave /usr/share/man/man1/orbd.1 orbd.1 ${install_path}/${longversion}/man/man1/orbd.1;
                          update-alternatives --install /usr/bin/pack200 pack200 ${install_path}/${longversion}/bin/pack200 ${priority} \
                           --slave /usr/share/man/man1/pack200.1 pack200.1 ${install_path}/${longversion}/man/man1/pack200.1;
                          update-alternatives --install /usr/bin/policytool policytool ${install_path}/${longversion}/bin/policytool ${priority} \
                           --slave /usr/share/man/man1/policytool.1 policytool.1 ${install_path}/${longversion}/man/man1/policytool.1;
                          update-alternatives --install /usr/bin/rmid rmid ${install_path}/${longversion}/bin/rmid ${priority} \
                           --slave /usr/share/man/man1/rmid.1 rmid.1 ${install_path}/${longversion}/man/man1/rmid.1;
                          update-alternatives --install /usr/bin/rmiregistry rmiregistry ${install_path}/${longversion}/bin/rmiregistry ${priority} \
                           --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 ${install_path}/${longversion}/man/man1/rmiregistry.1;
                          update-alternatives --install /usr/bin/servertool servertool ${install_path}/${longversion}/bin/servertool ${priority} \
                           --slave /usr/share/man/man1/servertool.1 servertool.1 ${install_path}/${longversion}/man/man1/servertool.1;
                          update-alternatives --install /usr/bin/tnameserv tnameserv ${install_path}/${longversion}/bin/tnameserv ${priority} \
                           --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 ${install_path}/${longversion}/man/man1/tnameserv.1;
                          update-alternatives --install /usr/bin/unpack200 unpack200 ${install_path}/${longversion}/bin/unpack200 ${priority} \
                           --slave /usr/share/man/man1/unpack200.1 unpack200.1 ${install_path}/${longversion}/man/man1/unpack200.1;
                          update-alternatives --install /usr/bin/appletviewer appletviewer ${install_path}/${longversion}/bin/appletviewer ${priority} \
                           --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 ${install_path}/${longversion}/man/man1/appletviewer.1;
                          update-alternatives --install /usr/bin/extcheck extcheck ${install_path}/${longversion}/bin/extcheck ${priority} \
                           --slave /usr/share/man/man1/extcheck.1 extcheck.1 ${install_path}/${longversion}/man/man1/extcheck.1;
                          update-alternatives --install /usr/bin/idlj idlj ${install_path}/${longversion}/bin/idlj ${priority} \
                           --slave /usr/share/man/man1/idlj.1 idlj.1 ${install_path}/${longversion}/man/man1/idlj.1;
                          update-alternatives --install /usr/bin/jar jar ${install_path}/${longversion}/bin/jar ${priority} \
                           --slave /usr/share/man/man1/jar.1 jar.1 ${install_path}/${longversion}/man/man1/jar.1;
                          update-alternatives --install /usr/bin/jarsigner jarsigner ${install_path}/${longversion}/bin/jarsigner ${priority} \
                           --slave /usr/share/man/man1/jarsigner.1 jarsigner.1 ${install_path}/${longversion}/man/man1/jarsigner.1;
                          update-alternatives --install /usr/bin/javac javac ${install_path}/${longversion}/bin/javac ${priority} \
                           --slave /usr/share/man/man1/javac.1 javac.1 ${install_path}/${longversion}/man/man1/javac.1;
                          update-alternatives --install /usr/bin/javadoc javadoc ${install_path}/${longversion}/bin/javadoc ${priority} \
                           --slave /usr/share/man/man1/javadoc.1 javadoc.1 ${install_path}/${longversion}/man/man1/javadoc.1;
                          update-alternatives --install /usr/bin/javafxpackager javafxpackager ${install_path}/${longversion}/bin/javafxpackager ${priority} \
                           --slave /usr/share/man/man1/javafxpackager.1 javafxpackager.1 ${install_path}/${longversion}/man/man1/javafxpackager.1;
                          update-alternatives --install /usr/bin/javah javah ${install_path}/${longversion}/bin/javah ${priority} \
                           --slave /usr/share/man/man1/javah.1 javah.1 ${install_path}/${longversion}/man/man1/javah.1;
                          update-alternatives --install /usr/bin/javap javap ${install_path}/${longversion}/bin/javap ${priority} \
                           --slave /usr/share/man/man1/javap.1 javap.1 ${install_path}/${longversion}/man/man1/javap.1;
                          update-alternatives --install /usr/bin/javapackager javapackager ${install_path}/${longversion}/bin/javapackager ${priority} \
                           --slave /usr/share/man/man1/javapackager.1 javapackager.1 ${install_path}/${longversion}/man/man1/javapackager.1;
                          update-alternatives --install /usr/bin/java-rmi.cgi java-rmi.cgi ${install_path}/${longversion}/bin/java-rmi.cgi ${priority} \
                          update-alternatives --install /usr/bin/jcmd jcmd ${install_path}/${longversion}/bin/jcmd ${priority} \
                           --slave /usr/share/man/man1/jcmd.1 jcmd.1 ${install_path}/${longversion}/man/man1/jcmd.1;
                          update-alternatives --install /usr/bin/jconsole jconsole ${install_path}/${longversion}/bin/jconsole ${priority} \
                           --slave /usr/share/man/man1/jconsole.1 jconsole.1 ${install_path}/${longversion}/man/man1/jconsole.1;
                          update-alternatives --install /usr/bin/jdb jdb ${install_path}/${longversion}/bin/jdb ${priority} \
                           --slave /usr/share/man/man1/jdb.1 jdb.1 ${install_path}/${longversion}/man/man1/jdb.1;
                          update-alternatives --install /usr/bin/jdeps jdeps ${install_path}/${longversion}/bin/jdeps ${priority} \
                           --slave /usr/share/man/man1/jdeps.1 jdeps.1 ${install_path}/${longversion}/man/man1/jdeps.1;
                          update-alternatives --install /usr/bin/jhat jhat ${install_path}/${longversion}/bin/jhat ${priority} \
                           --slave /usr/share/man/man1/jhat.1 jhat.1 ${install_path}/${longversion}/man/man1/jhat.1;
                          update-alternatives --install /usr/bin/jinfo jinfo ${install_path}/${longversion}/bin/jinfo ${priority} \
                           --slave /usr/share/man/man1/jinfo.1 jinfo.1 ${install_path}/${longversion}/man/man1/jinfo.1;
                          update-alternatives --install /usr/bin/jmap jmap ${install_path}/${longversion}/bin/jmap ${priority} \
                           --slave /usr/share/man/man1/jmap.1 jmap.1 ${install_path}/${longversion}/man/man1/jmap.1;
                          update-alternatives --install /usr/bin/jmc jmc ${install_path}/${longversion}/bin/jmc ${priority} \
                           --slave /usr/share/man/man1/jmc.1 jmc.1 ${install_path}/${longversion}/man/man1/jmc.1;
                          update-alternatives --install /usr/bin/jps jps ${install_path}/${longversion}/bin/jps ${priority} \
                           --slave /usr/share/man/man1/jps.1 jps.1 ${install_path}/${longversion}/man/man1/jps.1;
                          update-alternatives --install /usr/bin/jrunscript jrunscript ${install_path}/${longversion}/bin/jrunscript ${priority} \
                           --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${install_path}/${longversion}/man/man1/jrunscript.1;
                          update-alternatives --install /usr/bin/jsadebugd jsadebugd ${install_path}/${longversion}/bin/jsadebugd ${priority} \
                           --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 ${install_path}/${longversion}/man/man1/jsadebugd.1;
                          update-alternatives --install /usr/bin/jstack jstack ${install_path}/${longversion}/bin/jstack ${priority} \
                           --slave /usr/share/man/man1/jstack.1 jstack.1 ${install_path}/${longversion}/man/man1/jstack.1;
                          update-alternatives --install /usr/bin/jstat jstat ${install_path}/${longversion}/bin/jstat ${priority} \
                           --slave /usr/share/man/man1/jstat.1 jstat.1 ${install_path}/${longversion}/man/man1/jstat.1;
                          update-alternatives --install /usr/bin/jstatd jstatd ${install_path}/${longversion}/bin/jstatd ${priority} \
                           --slave /usr/share/man/man1/jstatd.1 jstatd.1 ${install_path}/${longversion}/man/man1/jstatd.1;
                          update-alternatives --install /usr/bin/jvisualvm jvisualvm ${install_path}/${longversion}/bin/jvisualvm ${priority} \
                           --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 ${install_path}/${longversion}/man/man1/jvisualvm.1;
                          update-alternatives --install /usr/bin/native2ascii native2ascii ${install_path}/${longversion}/bin/native2ascii ${priority} \
                           --slave /usr/share/man/man1/native2ascii.1 native2ascii.1 ${install_path}/${longversion}/man/man1/native2ascii.1;
                          update-alternatives --install /usr/bin/rmic rmic ${install_path}/${longversion}/bin/rmic ${priority} \
                           --slave /usr/share/man/man1/rmic.1 rmic.1 ${install_path}/${longversion}/man/man1/rmic.1;
                          update-alternatives --install /usr/bin/schemagen schemagen ${install_path}/${longversion}/bin/schemagen ${priority} \
                           --slave /usr/share/man/man1/schemagen.1 schemagen.1 ${install_path}/${longversion}/man/man1/schemagen.1;
                          update-alternatives --install /usr/bin/serialver serialver ${install_path}/${longversion}/bin/serialver ${priority} \
                           --slave /usr/share/man/man1/serialver.1 serialver.1 ${install_path}/${longversion}/man/man1/serialver.1;
                          update-alternatives --install /usr/bin/wsgen wsgen ${install_path}/${longversion}/bin/wsgen ${priority} \
                           --slave /usr/share/man/man1/wsgen.1 wsgen.1 ${install_path}/${longversion}/man/man1/wsgen.1;
                          update-alternatives --install /usr/bin/wsimport wsimport ${install_path}/${longversion}/bin/wsimport ${priority} \
                           --slave /usr/share/man/man1/wsimport.1 wsimport.1 ${install_path}/${longversion}/man/man1/wsimport.1;
                          update-alternatives --install /usr/bin/xjc xjc ${install_path}/${longversion}/bin/xjc ${priority} \
                           --slave /usr/share/man/man1/xjc.1 xjc.1 ${install_path}/${longversion}/man/man1/xjc.1"
            }
          }
          default : {
            exec { "add java alternative ${version_final}":
              command => "update-alternatives --install /usr/bin/java java ${install_path}/${longversion}/bin/java ${priority} \
                         --slave /usr/share/man/man1/java.1 java.1 ${install_path}/${longversion}/man/man1/java.1;
                          update-alternatives --install /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws ${priority} \
                           --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1;
                          update-alternatives --install /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol ${priority};
                          update-alternatives --install /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs${priority} \
                           --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1;
                          update-alternatives --install /usr/bin/keytool keytool ${install_path}/${longversion}/bin/keytool ${priority} \
                           --slave /usr/share/man/man1/keytool.1 keytool.1 ${install_path}/${longversion}/man/man1/keytool.1;
                          update-alternatives --install /usr/bin/orbd orbd ${install_path}/${longversion}/bin/orbd ${priority} \
                           --slave /usr/share/man/man1/orbd.1 orbd.1 ${install_path}/${longversion}/man/man1/orbd.1;
                          update-alternatives --install /usr/bin/pack200 pack200 ${install_path}/${longversion}/bin/pack200 ${priority} \
                           --slave /usr/share/man/man1/pack200.1 pack200.1 ${install_path}/${longversion}/man/man1/pack200.1;
                          update-alternatives --install /usr/bin/policytool policytool ${install_path}/${longversion}/bin/policytool ${priority} \
                           --slave /usr/share/man/man1/policytool.1 policytool.1 ${install_path}/${longversion}/man/man1/policytool.1;
                          update-alternatives --install /usr/bin/rmid rmid ${install_path}/${longversion}/bin/rmid ${priority} \
                           --slave /usr/share/man/man1/rmid.1 rmid.1 ${install_path}/${longversion}/man/man1/rmid.1;
                          update-alternatives --install /usr/bin/rmiregistry rmiregistry ${install_path}/${longversion}/bin/rmiregistry ${priority} \
                           --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 ${install_path}/${longversion}/man/man1/rmiregistry.1;
                          update-alternatives --install /usr/bin/servertool servertool ${install_path}/${longversion}/bin/servertool ${priority} \
                           --slave /usr/share/man/man1/servertool.1 servertool.1 ${install_path}/${longversion}/man/man1/servertool.1;
                          update-alternatives --install /usr/bin/tnameserv tnameserv ${install_path}/${longversion}/bin/tnameserv ${priority} \
                           --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 ${install_path}/${longversion}/man/man1/tnameserv.1;
                          update-alternatives --install /usr/bin/unpack200 unpack200 ${install_path}/${longversion}/bin/unpack200 ${priority} \
                           --slave /usr/share/man/man1/unpack200.1 unpack200.1 ${install_path}/${longversion}/man/man1/unpack200.1"
            }
          }
        } #-- case $type
      } #--case $::osfamily == Debian
      default       : {
        notice("\"${::operatingsystem}\" does not support alternatives, you should explicitly disable it for this host")
      }
    } #-- case $::osfamily
  } #-- if $add_alternative
}
