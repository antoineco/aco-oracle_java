# == Define: oracle_java::installation
#
# Installs an extra version of Oracle Java
#
# === Parameters:
#
# [*version*]
#   Java SE version to install (valid format: 'major'u'minor' or just 'major'). Namevar
# [*build*]
#   build number associated to the requested Java SE version (valid format: '-b###')
# [*type*]
#   envionment type to install (valid: 'jre'|'jdk')
# [*check_checksum*]
#   enable checksum validation on downloaded archives (boolean)
# [*checksum*]
#   use a custom checksum to verify the archive integrity
# [*add_alternative*]
#   add java alternative (boolean)
# [*download_url*]
#   base url of a custom location to fetch the installation package from
# [*filename*]
#   custom file name to use when downloading the installation package
# [*proxy_server*]
#   proxy server url
# [*proxy_type*]
#   proxy server type (valid: 'none'|'http'|'https'|'ftp')
# [*urlcode*]
#   complex code oracle started adding to the 'download_url' starting from java 8u121
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
  $version         = $name,
  $build           = undef,
  $type            = 'jre',
  $check_checksum  = true,
  $checksum        = undef,
  $add_alternative = false,
  $download_url    = undef,
  $filename        = undef,
  $proxy_server    = undef,
  $proxy_type      = undef,
  $urlcode         = undef) {

  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java defined resources')
  }

  # The install_path is taken from the main class
  $install_path = $oracle_java::install_path

  # parameters validation
  if $version !~ /^([0-9]|[0-9]u[0-9]{1,3})$/ {
    fail('$version must be formated as \'major\'u\'minor\' or just \'major\'')
  }
  if $type !~ /^(jre|jdk)$/ {
    fail('$type must be either \'jre\' or \'jdk\'')
  }

  # set to latest release if no minor version was provided
  if $version == '9' {
    $version_real = '9.0.1'
  } elsif $version == '8' {
    $version_real = '8u162'
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
  if versioncmp($version_real, '9') >= 0 {
    $array_version = split($version_real, '\.')
    $maj_version = $array_version[0]
    $min_version = $array_version[2]
  } else {
    $array_version = split($version_real, 'u')
    $maj_version = $array_version[0]
    $min_version = $array_version[1]
  }

  # remove extra particle if minor version is 0
  $version_final = delete($version_real, 'u0')
  if versioncmp($version_final, '9') >= 0 {
    $longversion = "${type}-${version_final}"
  } else {
    $longversion = $min_version ? {
      '0'       => "${type}1.${maj_version}.0",
      /^[0-9]$/ => "${type}1.${maj_version}.0_0${min_version}",
      default   => "${type}1.${maj_version}.0_${min_version}"
    }
  }

  # define installer filename
  if !$filename {
    case $maj_version {
      '6'     : { $filename_real = "${type}-${version_final}-linux-${arch}.bin" }
      '9'     : { $filename_real = "${type}-${version_final}_linux-${arch}_bin.tar.gz" }
      default : { $filename_real = "${type}-${version_final}-linux-${arch}.tar.gz" }
    }
  } else {
    $filename_real = $filename
  }

  # define build number and url code
  if !$build {
    #-- start javalist --#
    # associate build number to release version
    case $maj_version {
      '9'     : {
        case $min_version {
          '1'     : { $buildnumber = '+11' }
          '0'     : { $buildnumber = '+181' }
          default : { fail("Unreleased Java SE version ${version_real}") }
        }
      }
      '8'     : {
        case $min_version {
          '162'   : { $buildnumber = '-b12'
                      $urlcodeoracle = '/0da788060d494f5095bf8624735fa2f1' }
          '161'   : { $buildnumber = '-b12'
                      $urlcodeoracle = '/2f38c3b165be4555a1fa6e98c45e0808' }
          '152'   : { $buildnumber = '-b16'
                      $urlcodeoracle = '/aa0333dd3019491ca4f6ddbe78cdb6d0' }
          '151'   : { $buildnumber = '-b12'
                      $urlcodeoracle = '/e758a0de34e24606bca991d704f6dcbf' }
          '144'   : { $buildnumber = '-b01'
                      $urlcodeoracle = '/090f390dda5b47b9b721c7dfaa008135' }
          '141'   : { $buildnumber = '-b15'
                      $urlcodeoracle = '/336fa29ff2bb4ef291e347e091f7f4a7' }
          '131'   : { $buildnumber = '-b11'
                      $urlcodeoracle = '/d54c1d3a095b4ff2b6607d096fa80163' }
          '121'   : { $buildnumber = '-b13'
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
          default : { fail("Unreleased Java SE version ${version_real}") }
        }
      }
      '7'     : {
        case $min_version {
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
          default : { fail("Unreleased Java SE version ${version_real}") }
        }
      }
      '6'     : {
        case $min_version {
          '45'    : { $buildnumber = '-b06' }
          default : { fail("Unreleased Java SE version ${oracle_java::version_real}") }
        }
      }
      default : {
        fail("oracle_java module does not support Java SE version ${maj_version} (yet)")
      }
    }

    #set url code
    $urlcode_real = defined('$urlcodeoracle') ? {
      true    => $urlcodeoracle,
      default => ''
    }
    #-- end javalist --#
    $build_real = $buildnumber
  } else {
    $build_real = $build
    $urlcode_real = $urlcode
  }

  # define download URL
  if !$download_url {
    $download_url_real = "http://download.oracle.com/otn-pub/java/jdk/${version_final}${build_real}${urlcode_real}"
    $oracle_url = true
  } else {
    $download_url_real = $download_url
    $oracle_url = false
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
    if !$checksum {
      #-- start checksum --#
      case $filename_real {
        # 9.0.1
        'jdk-9.0.1_linux-x64_bin.rpm'    : { $md5checksum = '86cce47a74dfff3e224abe7a35ee7420' }
        'jdk-9.0.1_linux-x64_bin.tar.gz' : { $md5checksum = 'f6a5d86a9d371e9c416c1f82213b326f' }
        'jre-9.0.1_linux-x64_bin.rpm'    : { $md5checksum = '72af66d314fce1d81fc399ea7c6cdf29' }
        'jre-9.0.1_linux-x64_bin.tar.gz' : { $md5checksum = '008913963c0c053d3c52bd6e3473010d' }
        # 9
        'jdk-9_linux-x64_bin.rpm'     : { $md5checksum = '5f2c490f08d6da7ce8807cdeea2f282d' }
        'jdk-9_linux-x64_bin.tar.gz'  : { $md5checksum = 'abe68b8ba280d11cb8f937410543750c' }
        'jre-9_linux-x64_bin.rpm'     : { $md5checksum = '3d0bd97925fa3d68746c2849c6aa1d2b' }
        'jre-9_linux-x64_bin.tar.gz'  : { $md5checksum = '113a784957235eb78ef418f89e3e6b88' }
        # 8u162
        'jdk-8u162-linux-i586.rpm'    : { $md5checksum = '9d988ab9a58b469b900a4dcd5620f51e' }
        'jdk-8u162-linux-i586.tar.gz' : { $md5checksum = '94e3be6c990e2866b87fb1b71bca6428' }
        'jdk-8u162-linux-x64.rpm'     : { $md5checksum = '822b097cdd85710b10074b8cf82f061f' }
        'jdk-8u162-linux-x64.tar.gz'  : { $md5checksum = '781e3779f0c134fb548bde8b8e715e90' }
        'jre-8u162-linux-i586.rpm'    : { $md5checksum = 'c79641b78f518dfcd63a9c32ed4d2cbc' }
        'jre-8u162-linux-i586.tar.gz' : { $md5checksum = '0ca76906eaff4735c5f19c83c9f48c0a' }
        'jre-8u162-linux-x64.rpm'     : { $md5checksum = '1daf54bd7bbb43fabceeed002f450462' }
        'jre-8u162-linux-x64.tar.gz'  : { $md5checksum = 'f013f8c00d7bfe1e5f0b6b94fb660ea7' }
        # 8u161
        'jdk-8u161-linux-i586.rpm'    : { $md5checksum = 'fdc8dc6d7474a204c0353adf04ec2122' }
        'jdk-8u161-linux-i586.tar.gz' : { $md5checksum = 'f3ab51b9c6b8d7c3aa7f816fccbb4e18' }
        'jdk-8u161-linux-x64.rpm'     : { $md5checksum = 'f396f618b7c059089240563d2c46b5fc' }
        'jdk-8u161-linux-x64.tar.gz'  : { $md5checksum = '99051574a0d90871ed24a91a5d321ed2' }
        'jre-8u161-linux-i586.rpm'    : { $md5checksum = 'b34512f9f0026089707eb9690f2b597b' }
        'jre-8u161-linux-i586.tar.gz' : { $md5checksum = '32db95dd417fd7949922206b2a61aa19' }
        'jre-8u161-linux-x64.rpm'     : { $md5checksum = 'ea94f2c881e06c01d6ff5255c560416b' }
        'jre-8u161-linux-x64.tar.gz'  : { $md5checksum = '4385bc121b085862be623f4a31e7e0b4' }
        # 8u152
        'jdk-8u152-linux-i586.rpm'    : { $md5checksum = '953f8cbdd09615c44545860d969d0937' }
        'jdk-8u152-linux-i586.tar.gz' : { $md5checksum = '0c70ea43ad5baf0349a16c734bc2fb41' }
        'jdk-8u152-linux-x64.rpm'     : { $md5checksum = 'b6979be30bdc4077dc93cd99134ad84d' }
        'jdk-8u152-linux-x64.tar.gz'  : { $md5checksum = '20dddd28ced3179685a5f58d3fcbecd8' }
        'jre-8u152-linux-i586.rpm'    : { $md5checksum = '52b57d4cec8d8f3e6bc7c82e87d18973' }
        'jre-8u152-linux-i586.tar.gz' : { $md5checksum = '1ea9344c8d223694e05865e32edc3656' }
        'jre-8u152-linux-x64.rpm'     : { $md5checksum = '865f94da68cb41faeddad894ffa01b49' }
        'jre-8u152-linux-x64.tar.gz'  : { $md5checksum = '32c9a36d3869b13db18e8bd5bfc14dcb' }
        # 8u151
        'jdk-8u151-linux-i586.rpm'    : { $md5checksum = '47116151056e99506e103c2fd84c2da4' }
        'jdk-8u151-linux-i586.tar.gz' : { $md5checksum = 'ecff0de91938a43b6efb312f6b2994f2' }
        'jdk-8u151-linux-x64.rpm'     : { $md5checksum = '7f09893e12aadef39e0751ec657cc7d8' }
        'jdk-8u151-linux-x64.tar.gz'  : { $md5checksum = '774d8cb584d9ebedef8eba9ee2dfe113' }
        'jre-8u151-linux-i586.rpm'    : { $md5checksum = '3ee20326ff2fb9ae5cd344689d3fcbdf' }
        'jre-8u151-linux-i586.tar.gz' : { $md5checksum = '6adfa27e4eb8e4acc355e598139b46e7' }
        'jre-8u151-linux-x64.rpm'     : { $md5checksum = 'a540c278bc158c4abf263f883ec3d207' }
        'jre-8u151-linux-x64.tar.gz'  : { $md5checksum = '47ada926885c43f4ee2a8426a44af634' }
        # 8u144
        'jdk-8u144-linux-i586.rpm'    : { $md5checksum = 'eb35a77bcbd2466d9c96142e5a0d9b87' }
        'jdk-8u144-linux-i586.tar.gz' : { $md5checksum = '13d771707f326b02e2497c99e0a2ca37' }
        'jdk-8u144-linux-x64.rpm'     : { $md5checksum = 'dcc4c903506766ec4c50a969babdd856' }
        'jdk-8u144-linux-x64.tar.gz'  : { $md5checksum = '2d59a3add1f213cd249a67684d4aeb83' }
        'jre-8u144-linux-i586.rpm'    : { $md5checksum = 'b9798f6a9fa9bcf5a9828173185dbe55' }
        'jre-8u144-linux-i586.tar.gz' : { $md5checksum = '794e74d0395124337809dcc225c80411' }
        'jre-8u144-linux-x64.rpm'     : { $md5checksum = '5f4b98cbe19862a969494ce878377298' }
        'jre-8u144-linux-x64.tar.gz'  : { $md5checksum = 'e3808f24d0f588b0c313fa18b50683c6' }
        # 8u141
        'jdk-8u141-linux-i586.rpm'    : { $md5checksum = '827d5757ca23e32f071af38debc05bdc' }
        'jdk-8u141-linux-i586.tar.gz' : { $md5checksum = '016e3389363cce74b2d756b626e949c6' }
        'jdk-8u141-linux-x64.rpm'     : { $md5checksum = '336e6a9c298416ff4422e30420622e08' }
        'jdk-8u141-linux-x64.tar.gz'  : { $md5checksum = '8cf4c4e00744bfafc023d770cb65328c' }
        'jre-8u141-linux-i586.rpm'    : { $md5checksum = '31dd9203bfbadc0a9203b3ddd92bf5c0' }
        'jre-8u141-linux-i586.tar.gz' : { $md5checksum = 'a66f26ee7665a499a2511fb470b60140' }
        'jre-8u141-linux-x64.rpm'     : { $md5checksum = 'd2af8822f0264aa745bb546e4a6253de' }
        'jre-8u141-linux-x64.tar.gz'  : { $md5checksum = 'dfa2de5305b7b7519cf8a581c8d82fb9' }
        # 8u131
        'jdk-8u131-linux-i586.rpm'    : { $md5checksum = 'ad0ced8cae343a31c55aef3615bc6143' }
        'jdk-8u131-linux-i586.tar.gz' : { $md5checksum = 'a6741fd674372366546bd8480be735c7' }
        'jdk-8u131-linux-x64.rpm'     : { $md5checksum = '9024d13ec651d07de450d465f14065a6' }
        'jdk-8u131-linux-x64.tar.gz'  : { $md5checksum = '75b2cb2249710d822a60f83e28860053' }
        'jre-8u131-linux-i586.rpm'    : { $md5checksum = 'ac33957a306472e08cea05f6c717c61c' }
        'jre-8u131-linux-i586.tar.gz' : { $md5checksum = 'c88bb459288ee336a0f6109be169bc8c' }
        'jre-8u131-linux-x64.rpm'     : { $md5checksum = 'ebebfd327e67c4bbe47dabe6b9f6e961' }
        'jre-8u131-linux-x64.tar.gz'  : { $md5checksum = '9864b3b90840a2bc4604fba513e87453' }
        # 8u121
        'jdk-8u121-linux-i586.rpm'    : { $md5checksum = 'c59f56c0723ec82ff1382e4bcc3e22a5' }
        'jdk-8u121-linux-i586.tar.gz' : { $md5checksum = '9e0e84f36427ce258abfca35fbeb0c55' }
        'jdk-8u121-linux-x64.rpm'     : { $md5checksum = 'de86e326f9fd98f080cd355081b4a3dc' }
        'jdk-8u121-linux-x64.tar.gz'  : { $md5checksum = '91972fb4e753f1b6674c2b952d974320' }
        'jre-8u121-linux-i586.rpm'    : { $md5checksum = 'f2c141cb384108cbb76b05bba8e9e3af' }
        'jre-8u121-linux-i586.tar.gz' : { $md5checksum = 'b3c499fd4be692e22e5d849177bcfa3f' }
        'jre-8u121-linux-x64.rpm'     : { $md5checksum = 'ee64193f3aa2092d44fbfb7a61b09290' }
        'jre-8u121-linux-x64.tar.gz'  : { $md5checksum = '093e22e4f0a55420780a0e437ab9fcd4' }
        # 8u112
        'jdk-8u112-linux-i586.tar.gz' : { $md5checksum = '66ccf8e7c28969d56863034d030134bf' }
        'jdk-8u112-linux-x64.tar.gz'  : { $md5checksum = 'de9b7a90f0f5a13cfcaa3b01451d0337' }
        'jre-8u112-linux-i586.tar.gz' : { $md5checksum = 'ff4e17ebd082b5c5bad457751468769d' }
        'jre-8u112-linux-x64.tar.gz'  : { $md5checksum = '5ccc09b2cbbf715b583fad72b070b69d' }
        # 8u111
        'jdk-8u111-linux-i586.tar.gz' : { $md5checksum = 'f3399a2c00560a8f5f9a652f7c67e493' }
        'jdk-8u111-linux-x64.tar.gz'  : { $md5checksum = '2d48badebe05c848cc3b4d6e0c53a457' }
        'jre-8u111-linux-i586.tar.gz' : { $md5checksum = '1f4844c81c6d6c5c24270054638f7628' }
        'jre-8u111-linux-x64.tar.gz'  : { $md5checksum = '38f7d7a29fd7346350da5a12179d05e7' }
        # 8u102
        'jdk-8u102-linux-i586.tar.gz' : { $md5checksum = '13ca2f1c15a71dde4e57436d5ce671f8' }
        'jdk-8u102-linux-x64.tar.gz'  : { $md5checksum = 'bac58dcec9bb85859810a2a6acba740b' }
        'jre-8u102-linux-i586.tar.gz' : { $md5checksum = '77199a65cc3dd11e6a5dbb3144fad968' }
        'jre-8u102-linux-x64.tar.gz'  : { $md5checksum = '18f4cfa3ad7b10dea718e74fd06e5f19' }
        # 8u101
        'jdk-8u101-linux-i586.tar.gz' : { $md5checksum = '4f4600815aa1adb5294278d471e890e3' }
        'jdk-8u101-linux-x64.tar.gz'  : { $md5checksum = 'a7ab8014716b0dac3adcaf5342167699' }
        'jre-8u101-linux-i586.tar.gz' : { $md5checksum = '70b99858124b1de5fe7b9bf484f1c735' }
        'jre-8u101-linux-x64.tar.gz'  : { $md5checksum = '967b7a0c51be657ec79ca27c559943d1' }
        # 8u92
        'jdk-8u92-linux-i586.tar.gz'  : { $md5checksum = '0f2839ff1066438123dac3404702a3ef' }
        'jdk-8u92-linux-x64.tar.gz'   : { $md5checksum = '65a1cc17ea362453a6e0eb4f13be76e4' }
        'jre-8u92-linux-i586.tar.gz'  : { $md5checksum = 'e2157870ce7f0484f347b8374da863a0' }
        'jre-8u92-linux-x64.tar.gz'   : { $md5checksum = 'df1371cec5c66c1039ccc3e7a433c1de' }
        # 8u91
        'jdk-8u91-linux-i586.tar.gz'  : { $md5checksum = 'f18cbe901f2c77630f1e301cea32b259' }
        'jdk-8u91-linux-x64.tar.gz'   : { $md5checksum = '3f3d7d0cd70bfe0feab382ed4b0e45c0' }
        'jre-8u91-linux-i586.tar.gz'  : { $md5checksum = '705521705f0ddaa150f64090e56ae96c' }
        'jre-8u91-linux-x64.tar.gz'   : { $md5checksum = 'cc48b4cacfeda1f699b43ea77ddfaa95' }
        # 8u77
        'jdk-8u77-linux-i586.tar.gz'  : { $md5checksum = 'e5bac32e2a7ab5cf9068ba92ba084472' }
        'jdk-8u77-linux-x64.tar.gz'   : { $md5checksum = 'ee501bef73ba7fac255f0593e595d8eb' }
        'jre-8u77-linux-i586.tar.gz'  : { $md5checksum = '2a92cc0efa5e087230b0b77cef8a569e' }
        'jre-8u77-linux-x64.tar.gz'   : { $md5checksum = '7e7d8d0918b4f81f6adde9fcb853a036' }
        # 8u72
        'jdk-8u72-linux-i586.tar.gz'  : { $md5checksum = '19e3ad9a6c8dc6d4ff042f459c06b6c4' }
        'jdk-8u72-linux-x64.tar.gz'   : { $md5checksum = '54cde24fc0596f0f05b5d0d8f329053d' }
        'jre-8u72-linux-i586.tar.gz'  : { $md5checksum = '625a5caea29984d36640aa0e59e5e52c' }
        'jre-8u72-linux-x64.tar.gz'   : { $md5checksum = 'f45932f9a3a9c38e47a60504d21449f8' }
        # 8u71
        'jdk-8u71-linux-i586.tar.gz'  : { $md5checksum = 'b794964aa840745235bac1409c90a9ac' }
        'jdk-8u71-linux-x64.tar.gz'   : { $md5checksum = '12db05061f8816d01bb234bbdc40fefa' }
        'jre-8u71-linux-i586.tar.gz'  : { $md5checksum = '9991e271ec34395c60eed9ee0b393a7c' }
        'jre-8u71-linux-x64.tar.gz'   : { $md5checksum = '345029226fff96c52ac300c5e01b32f8' }
        # 8u66
        'jdk-8u66-linux-i586.tar.gz'  : { $md5checksum = '8a1f36b29152856a5dd2c3953a4c24a1' }
        'jdk-8u66-linux-x64.tar.gz'   : { $md5checksum = '88f31f3d642c3287134297b8c10e61bf' }
        'jre-8u66-linux-i586.tar.gz'  : { $md5checksum = '4656044616b97e4f578680d1ef5d55c0' }
        'jre-8u66-linux-x64.tar.gz'   : { $md5checksum = 'af82cfb37e139458ae6297ae1bfc4f5e' }
        # 8u65
        'jdk-8u65-linux-i586.tar.gz'  : { $md5checksum = '7b715e1fe2316c94aaa968b23ce49c9a' }
        'jdk-8u65-linux-x64.tar.gz'   : { $md5checksum = '196880a42c45ec9ab2f00868d69619c0' }
        'jre-8u65-linux-i586.tar.gz'  : { $md5checksum = '3c3deab4f2cc4df8b7f56a63dc541236' }
        'jre-8u65-linux-x64.tar.gz'   : { $md5checksum = 'abe147a99744b19df86e0e08010fff6c' }
        # 8u60
        'jdk-8u60-linux-i586.tar.gz'  : { $md5checksum = 'a46d706babbd63f459d7ca6d4057d80f' }
        'jdk-8u60-linux-x64.tar.gz'   : { $md5checksum = 'b8ca513d4f439782c019cb78cd7fd101' }
        'jre-8u60-linux-i586.tar.gz'  : { $md5checksum = '51512cfe055125570b5215a48a553d83' }
        'jre-8u60-linux-x64.tar.gz'   : { $md5checksum = 'e6e44f44b67c1a412f06694c9c30b77f' }
        # 8u51
        'jdk-8u51-linux-i586.tar.gz'  : { $md5checksum = '742b9151d9190a9ae7d8ed05c7d39850' }
        'jdk-8u51-linux-x64.tar.gz'   : { $md5checksum = 'b34ff02c5d98b6f372288c17e96c51cf' }
        'jre-8u51-linux-i586.tar.gz'  : { $md5checksum = 'f234dacdff97e6ac5ff3e85d58f2d158' }
        'jre-8u51-linux-x64.tar.gz'   : { $md5checksum = '3c4e3ed6b1c61fe18b9a88ea8b2d9384' }
        # 8u45
        'jdk-8u45-linux-i586.tar.gz'  : { $md5checksum = 'e68241caf30cb81ae4e985be7218bb6d' }
        'jdk-8u45-linux-x64.tar.gz'   : { $md5checksum = '1ad9a5be748fb75b31cd3bd3aa339cac' }
        'jre-8u45-linux-i586.tar.gz'  : { $md5checksum = 'def512ee71620662c7f4631bed7da183' }
        'jre-8u45-linux-x64.tar.gz'   : { $md5checksum = '58486d7b16d7b21fbea7374adc109233' }
        # 8u40
        'jdk-8u40-linux-i586.tar.gz'  : { $md5checksum = '1c4b119e7f25da30fa1d0ba62deb66f9' }
        'jdk-8u40-linux-x64.tar.gz'   : { $md5checksum = '159a3186bb88b77b4eb9ff9971222736' }
        'jre-8u40-linux-i586.tar.gz'  : { $md5checksum = 'b22953df20789fc199877ad7d615d51e' }
        'jre-8u40-linux-x64.tar.gz'   : { $md5checksum = '394d5dbd541691413e5b8d01f2e720d6' }
        # 8u31
        'jdk-8u31-linux-i586.tar.gz'  : { $md5checksum = '4e9aec24367672412c7d10105a2a2bbb' }
        'jdk-8u31-linux-x64.tar.gz'   : { $md5checksum = '173e24bc2d5d5ca3469b8e34864a80da' }
        'jre-8u31-linux-i586.tar.gz'  : { $md5checksum = '6cb48241523ad39862c05d8cf791ce92' }
        'jre-8u31-linux-x64.tar.gz'   : { $md5checksum = 'c81a3cdabe4a12439dae08d4311670ff' }
        # 8u25
        'jdk-8u25-linux-i586.tar.gz'  : { $md5checksum = 'b5b16247f66643727d9b6d4bc7c5efda' }
        'jdk-8u25-linux-x64.tar.gz'   : { $md5checksum = 'e145c03a7edc845215092786bcfba77e' }
        'jre-8u25-linux-i586.tar.gz'  : { $md5checksum = '22d970566c418499d331a2099d77c548' }
        'jre-8u25-linux-x64.tar.gz'   : { $md5checksum = 'f4f7f7335eaf2e7b5ff455abece9d5ed' }
        # 8u20
        'jdk-8u20-linux-i586.tar.gz'  : { $md5checksum = '5dafdef064e18468f21c65051a6918d7' }
        'jdk-8u20-linux-x64.tar.gz'   : { $md5checksum = 'ec7f89dc3697b402e2c851d0488f6299' }
        'jre-8u20-linux-i586.tar.gz'  : { $md5checksum = '488ebb6b67e2c822ad886c399e4255d6' }
        'jre-8u20-linux-x64.tar.gz'   : { $md5checksum = '01cd08eade026ba10d9748a66c2cbb8e' }
        # 8u11
        'jdk-8u11-linux-i586.tar.gz'  : { $md5checksum = '252bd6545d765ccf9d52ac3ef2ebf0aa' }
        'jdk-8u11-linux-x64.tar.gz'   : { $md5checksum = '13ee1d0bf6baaf2b119115356f234a48' }
        'jre-8u11-linux-i586.tar.gz'  : { $md5checksum = '329c93351f0fcbc832fdf76a406dfbc3' }
        'jre-8u11-linux-x64.tar.gz'   : { $md5checksum = '05b6ce6ce8133c390cd4c5df58434743' }
        # 8u5
        'jdk-8u5-linux-i586.tar.gz'   : { $md5checksum = 'fb0e8b5c0be11521bccec5d667559e76' }
        'jdk-8u5-linux-x64.tar.gz'    : { $md5checksum = 'adc3827532741873de9216a5aed883ed' }
        'jre-8u5-linux-i586.tar.gz'   : { $md5checksum = '14f8b937e76d30bf2904d343d126a4b4' }
        'jre-8u5-linux-x64.tar.gz'    : { $md5checksum = 'd0aab3d18f7ffe7310ed3a72a19efac1' }
        # 8u0
        'jdk-8-linux-i586.tar.gz'     : { $md5checksum = '45556e463a561b470bd9d0c07a73effb' }
        'jdk-8-linux-x64.tar.gz'      : { $md5checksum = '7e9e5e5229c6603a4d8476050bbd98b1' }
        'jre-8-linux-i586.tar.gz'     : { $md5checksum = '045a0309585e546fa2da2316309c09ea' }
        'jre-8-linux-x64.tar.gz'      : { $md5checksum = '1e024eb9b0f7f61722e10fc08c873543' }
        # 7u80
        'jdk-7u80-linux-i586.tar.gz'  : { $md5checksum = '0811a4045714bd8f1e1577e318528597' }
        'jdk-7u80-linux-x64.tar.gz'   : { $md5checksum = '6152f8a7561acf795ca4701daa10a965' }
        'jre-7u80-linux-i586.tar.gz'  : { $md5checksum = 'ff0f6847e51b6be5c241615a73043005' }
        'jre-7u80-linux-x64.tar.gz'   : { $md5checksum = 'c0e01ae8683b2d8924ce79cd6ce6a691' }
        # 7u79
        'jdk-7u79-linux-i586.tar.gz'  : { $md5checksum = 'b0ed59147c77a6d3e63a7b340e4e1d28' }
        'jdk-7u79-linux-x64.tar.gz'   : { $md5checksum = '9222e097e624800fdd9bfb568169ccad' }
        'jre-7u79-linux-i586.tar.gz'  : { $md5checksum = 'eba02bbd1dcb9546fed93a9854b84ed9' }
        'jre-7u79-linux-x64.tar.gz'   : { $md5checksum = 'fcd884a57920d90fa23240abb403fcf5' }
        # 7u76
        'jdk-7u76-linux-i586.tar.gz'  : { $md5checksum = '566dcbcedbb9ec5a26f08bd65b14746b' }
        'jdk-7u76-linux-x64.tar.gz'   : { $md5checksum = '5a98b1a3e4c48363d03f664f173bbb9a' }
        'jre-7u76-linux-i586.tar.gz'  : { $md5checksum = 'e7eb5d65eab8f57cbf0d5da804327f75' }
        'jre-7u76-linux-x64.tar.gz'   : { $md5checksum = 'a5ee5fd266453e0209e45fb8bb5acd6d' }
        # 7u75
        'jdk-7u75-linux-i586.tar.gz'  : { $md5checksum = 'e4371a4fddc049eca3bfef293d812b8e' }
        'jdk-7u75-linux-x64.tar.gz'   : { $md5checksum = '6f1f81030a34f7a9c987f8b68a24d139' }
        'jre-7u75-linux-i586.tar.gz'  : { $md5checksum = '3a2a94b9cd76fa1323dd9a5aaf48383b' }
        'jre-7u75-linux-x64.tar.gz'   : { $md5checksum = '1869f0d2dac96372e3c345105543ba3e' }
        # 7u72
        'jdk-7u72-linux-i586.tar.gz'  : { $md5checksum = '4a942a47a700e63e050dd66e8ca08a1f' }
        'jdk-7u72-linux-x64.tar.gz'   : { $md5checksum = 'cfa44b49e50ea06e5c6ab95ff79e5b2a' }
        'jre-7u72-linux-i586.tar.gz'  : { $md5checksum = 'a66052322c1a26c33bf6078cb4040dfb' }
        'jre-7u72-linux-x64.tar.gz'   : { $md5checksum = '4ae2ef732dfd309e86a182ca0f7681fe' }
        # 7u71
        'jdk-7u71-linux-i586.tar.gz'  : { $md5checksum = '54899d0733d9a8697da59de79a02cc8f' }
        'jdk-7u71-linux-x64.tar.gz'   : { $md5checksum = '22761b214b1505f1a9671b124b0f44f4' }
        'jre-7u71-linux-i586.tar.gz'  : { $md5checksum = '90a6b9e2a32d06c18a3f16b485f0d1ea' }
        'jre-7u71-linux-x64.tar.gz'   : { $md5checksum = '7605134662f6c87131eca5745895fe84' }
        # 7u67
        'jdk-7u67-linux-i586.tar.gz'  : { $md5checksum = '715b0e8ba2a06bded75f6a92427e2701' }
        'jdk-7u67-linux-x64.tar.gz'   : { $md5checksum = '81e3e2df33e13781e5fac5756ed90e67' }
        'jre-7u67-linux-i586.tar.gz'  : { $md5checksum = '2a256eb2a91f0084e58c612636342c2b' }
        'jre-7u67-linux-x64.tar.gz'   : { $md5checksum = '9007c79167be0177fb47e5313c53d5cb' }
        # 7u65
        'jdk-7u65-linux-i586.tar.gz'  : { $md5checksum = 'bfe1f792918aca2fbe53157061e2145c' }
        'jdk-7u65-linux-x64.tar.gz'   : { $md5checksum = 'c223bdbaf706f986f7a5061a204f641f' }
        'jre-7u65-linux-i586.tar.gz'  : { $md5checksum = 'd11d9f4488d75106fc8909b847efaeda' }
        'jre-7u65-linux-x64.tar.gz'   : { $md5checksum = '2f5c128568f697e918c5259d7bcf2fae' }
        # 7u60
        'jdk-7u60-linux-i586.tar.gz'  : { $md5checksum = 'b33c914b03e46c3e7c33e4bdddbec4bd' }
        'jdk-7u60-linux-x64.tar.gz'   : { $md5checksum = 'eba4b121b8a363f583679d7cb2e69d28' }
        'jre-7u60-linux-i586.tar.gz'  : { $md5checksum = '331a7ef8230de0939941d1e9b3b761fd' }
        'jre-7u60-linux-x64.tar.gz'   : { $md5checksum = '53a787c9a3170308641074cd86606a99' }
        # 7u55
        'jdk-7u55-linux-i586.tar.gz'  : { $md5checksum = 'fec08edfd805ffcc34a1c20f38a9cc65' }
        'jdk-7u55-linux-x64.tar.gz'   : { $md5checksum = '9e1fb7936f0e5aaa1e64d36ba640bc1f' }
        'jre-7u55-linux-i586.tar.gz'  : { $md5checksum = '9e363fb6fdd072d04aa5862a8e06e6c2' }
        'jre-7u55-linux-x64.tar.gz'   : { $md5checksum = '5dea1a4d745c55c933ef87c8227c4bd5' }
        # 7u51
        'jdk-7u51-linux-i586.tar.gz'  : { $md5checksum = '909d353c1caf6b3b54cc20767a7778ef' }
        'jdk-7u51-linux-x64.tar.gz'   : { $md5checksum = '764f96c4b078b80adaa5983e75470ff2' }
        'jre-7u51-linux-i586.tar.gz'  : { $md5checksum = 'f133f125ca93acef3f70d1912cc2f4b0' }
        'jre-7u51-linux-x64.tar.gz'   : { $md5checksum = '1f6a93cc5ef5f66bb01bc39fd731cd9f' }
        # 7u45
        'jdk-7u45-linux-i586.tar.gz'  : { $md5checksum = '66b47e77d963c5dd652f0c5d3b03cb52' }
        'jdk-7u45-linux-x64.tar.gz'   : { $md5checksum = 'bea330fcbcff77d31878f21753e09b30' }
        'jre-7u45-linux-i586.tar.gz'  : { $md5checksum = '7fa0cf09846e96b367526c95f33bb278' }
        'jre-7u45-linux-x64.tar.gz'   : { $md5checksum = 'e82743de29c6cb59ae09bbcb090ccbee' }
        # 7u40
        'jdk-7u40-linux-i586.tar.gz'  : { $md5checksum = '0079cecc8c4d0f088ace5d0ea99d0c5c' }
        'jdk-7u40-linux-x64.tar.gz'   : { $md5checksum = '511ea34e4a42955bc03c28afa4b8f6cf' }
        'jre-7u40-linux-i586.tar.gz'  : { $md5checksum = '3e7f53fb5a3a7a4ba57343b1160fe67f' }
        'jre-7u40-linux-x64.tar.gz'   : { $md5checksum = '0c775aa90b4c4919b000949f02e0ec5b' }
        # 7u25
        'jdk-7u25-linux-i586.tar.gz'  : { $md5checksum = '23176d0ebf9dedd21e3150b4bb0ee776' }
        'jdk-7u25-linux-x64.tar.gz'   : { $md5checksum = '83ba05e260813f7a9140b76e3d37ea33' }
        'jre-7u25-linux-i586.tar.gz'  : { $md5checksum = '0e9ccefe49e937e592dbb605f2e8e7d8' }
        'jre-7u25-linux-x64.tar.gz'   : { $md5checksum = '743ee0ebf73ce428c912866d84e374e0' }
        # 7u21
        'jdk-7u21-linux-i586.tar.gz'  : { $md5checksum = 'fc0241e1a3e243602698ac700abc94e9' }
        'jdk-7u21-linux-x64.tar.gz'   : { $md5checksum = '3ceef66377b6d87144b802960f5e715b' }
        'jre-7u21-linux-i586.tar.gz'  : { $md5checksum = 'd1df6cbb7c2b5cc7e9dd05b3e8e838f9' }
        'jre-7u21-linux-x64.tar.gz'   : { $md5checksum = 'ad983b63a4d342f2db249a37f1fd6cc3' }
        # 7u17
        'jdk-7u17-linux-i586.tar.gz'  : { $md5checksum = '694f9592d894b86a8a3cb56bf71768e6' }
        'jdk-7u17-linux-x64.tar.gz'   : { $md5checksum = 'd9b5870a94c47efa0282d6c1863d0667' }
        'jre-7u17-linux-i586.tar.gz'  : { $md5checksum = '1ff65703df3cffbe98a6bc477db58e81' }
        'jre-7u17-linux-x64.tar.gz'   : { $md5checksum = '23e2949c86471ef9bbdfaac525deccea' }
        # 7u15
        'jdk-7u15-linux-i586.tar.gz'  : { $md5checksum = '6ebab8e0942706af2f7f5e0195a96f2c' }
        'jdk-7u15-linux-x64.tar.gz'   : { $md5checksum = '118a16aab9ff2c3f7c7788658cc77734' }
        'jre-7u15-linux-i586.tar.gz'  : { $md5checksum = '5c29a3adfd166a56c306ac297ab554d6' }
        'jre-7u15-linux-x64.tar.gz'   : { $md5checksum = 'ecb902aec2e7aabe7d8dc41e0b716723' }
        # 7u13
        'jdk-7u13-linux-i586.tar.gz'  : { $md5checksum = '2e129b77f7c2640dde08c267ed000c49' }
        'jdk-7u13-linux-x64.tar.gz'   : { $md5checksum = '5286b7e752fb8814d85124cb623ff045' }
        'jre-7u13-linux-i586.tar.gz'  : { $md5checksum = 'e34988dda917e5bb6a134eb56d41215d' }
        'jre-7u13-linux-x64.tar.gz'   : { $md5checksum = 'ae24d12dc8b390be02fa3dc84f1bd9fd' }
        # 7u11
        'jdk-7u11-linux-i586.tar.gz'  : { $md5checksum = '22239a786477a7d21bc8a835455ca24a' }
        'jdk-7u11-linux-x64.tar.gz'   : { $md5checksum = 'd8f65419fa65f179382ae310237fd1f4' }
        'jre-7u11-linux-i586.tar.gz'  : { $md5checksum = '76b71067cacddbee8d78db99ffa3d075' }
        'jre-7u11-linux-x64.tar.gz'   : { $md5checksum = '78872a8326394b5aeb1ac58288db66ed' }
        # 7u10
        'jdk-7u10-linux-i586.tar.gz'  : { $md5checksum = 'd890ad93e1d48c17b980fa3ada65c1be' }
        'jdk-7u10-linux-x64.tar.gz'   : { $md5checksum = '2a75b5510bdb7360b9279a6f659d054a' }
        'jre-7u10-linux-i586.tar.gz'  : { $md5checksum = '09ad4d62e64cdcf116c4f86290a62f46' }
        'jre-7u10-linux-x64.tar.gz'   : { $md5checksum = '9ce426628b1cb2c16dd05fbd906440aa' }
        # 7u9
        'jdk-7u9-linux-i586.tar.gz'   : { $md5checksum = 'f66c309ab38d6ba6651f7d98cd58d9d5' }
        'jdk-7u9-linux-x64.tar.gz'    : { $md5checksum = '372b9dcde93230522672837e1820f939' }
        'jre-7u9-linux-i586.tar.gz'   : { $md5checksum = '56178ed00dab2ebd8268caf5575743f4' }
        'jre-7u9-linux-x64.tar.gz'    : { $md5checksum = '8e17fa7b2152ab11f915c6936542cc12' }
        # 7u7
        'jdk-7u7-linux-i586.tar.gz'   : { $md5checksum = '5a46b8e1904cc9f94e6102f3e9d3deb8' }
        'jdk-7u7-linux-x64.tar.gz'    : { $md5checksum = '15f4b80901111f002894c33a3d78124c' }
        'jre-7u7-linux-i586.tar.gz'   : { $md5checksum = 'ea99bedd9db33e9e2970f4b70abd1e4b' }
        'jre-7u7-linux-x64.tar.gz'    : { $md5checksum = '5aa9bd26cdf1fa6afd2b15826b4ba139' }
        # 7u6
        'jdk-7u6-linux-i586.tar.gz'   : { $md5checksum = '3ddb72969d92485e8ec9b32dc065130b' }
        'jdk-7u6-linux-x64.tar.gz'    : { $md5checksum = '2178f5f10dadaed75c1476805a3d04d8' }
        'jre-7u6-linux-i586.tar.gz'   : { $md5checksum = '094ea2232f9b19dd56683728b2de98ab' }
        'jre-7u6-linux-x64.tar.gz'    : { $md5checksum = 'f0339e3251c4acecdf824d5acce87c36' }
        # 7u5
        'jdk-7u5-linux-i586.tar.gz'   : { $md5checksum = 'b3cc5eabc8027529025e48270120429b' }
        'jdk-7u5-linux-x64.tar.gz'    : { $md5checksum = 'c3b4dc26274b86fc3cd4b77ef04fea83' }
        'jre-7u5-linux-i586.tar.gz'   : { $md5checksum = '621131c104d77c6ca5e58784861dd060' }
        'jre-7u5-linux-x64.tar.gz'    : { $md5checksum = '4c8850b82a536480cddd771012426f1b' }
        # 7u4
        'jdk-7u4-linux-i586.tar.gz'   : { $md5checksum = '8e271abb32ac6ce199ba15ee5beb758b' }
        'jdk-7u4-linux-x64.tar.gz'    : { $md5checksum = 'a5ebe416c83b64a68c463a4a65f9e882' }
        'jre-7u4-linux-i586.tar.gz'   : { $md5checksum = '8e6db43d9a7cac724be2cb9d1329e702' }
        'jre-7u4-linux-x64.tar.gz'    : { $md5checksum = '49da2f0c288f96ed255ed75b796a5455' }
        # 7u3
        'jdk-7u3-linux-i586.tar.gz'   : { $md5checksum = '99a0fa02b608985c271e55122f0621bf' }
        'jdk-7u3-linux-x64.tar.gz'    : { $md5checksum = '969927251b558ffbc09ede1e89200d40' }
        'jre-7u3-linux-i586.tar.gz'   : { $md5checksum = 'cfce10a05f8d152d39aef892f2cd4011' }
        'jre-7u3-linux-x64.tar.gz'    : { $md5checksum = '3d3e206cea84129f1daa8e62bf656a28' }
        # 7u2
        'jdk-7u2-linux-i586.tar.gz'   : { $md5checksum = '8a06141ffae6c96743ea405b75e54f84' }
        'jdk-7u2-linux-x64.tar.gz'    : { $md5checksum = 'a0bbb9265b4633cfd7823928649f450c' }
        'jre-7u2-linux-i586.tar.gz'   : { $md5checksum = '78923ef097586c36a6242c54cb20abd7' }
        'jre-7u2-linux-x64.tar.gz'    : { $md5checksum = 'c6d0aa62337148787795870a12c17974' }
        # 7u1
        'jdk-7u1-linux-i586.tar.gz'   : { $md5checksum = '7267759f93bc6fb23046dd42d40d1c2f' }
        'jdk-7u1-linux-x64.tar.gz'    : { $md5checksum = '9707049b591f47e5c3988a9f029c015e' }
        'jre-7u1-linux-i586.tar.gz'   : { $md5checksum = 'd9b73cc5ccaa4f0b36cd6b8b62d07142' }
        'jre-7u1-linux-x64.tar.gz'    : { $md5checksum = '07bd73571b7028b73fc8ed19bc85226d' }
        # 7u0
        'jdk-7-linux-i586.tar.gz'     : { $md5checksum = 'f97244a104f03731e5ff69f0dd5a9927' }
        'jdk-7-linux-x64.tar.gz'      : { $md5checksum = 'b3c1ef5faea7b180469c129a49762b64' }
        'jre-7-linux-i586.tar.gz'     : { $md5checksum = '1c368a19835834a08b9aabd806a1b2d6' }
        'jre-7-linux-x64.tar.gz'      : { $md5checksum = '27b14f437db6db6922c753472305c13c' }
        # 6u45
        'jdk-6u45-linux-i586.bin'     : { $md5checksum = '3269370b7c34e6cbfed8785d3d0c5cbd' }
        'jdk-6u45-linux-x64.bin'      : { $md5checksum = '40c1a87563c5c6a90a0ed6994615befe' }
        'jre-6u45-linux-i586.bin'     : { $md5checksum = '1d8001ef61a2e3a11fe7b9eec9f08948' }
        'jre-6u45-linux-x64.bin'      : { $md5checksum = '4a4569126f05f525f48bacf761f7185c' }
        default                       : { fail("Unknown checksum for file ${filename_real}") }
      }
      #-- end checksum --#
      $checksum_real = $md5checksum
    } else {
      $checksum_real = $checksum
    }
    Archive {
      checksum      => $checksum_real,
      checksum_type => 'md5'
    }
  }

  Archive {
    proxy_server => $proxy_server,
    proxy_type   => $proxy_type,
    require      => File[$install_path]
  }

  # pass credentials to Oracle SSO for authenticated downloads
  if $oracle_url {
    Archive {
      source => oracle_sso("${download_url_real}/${filename_real}", $oracle_java::ssousername, $oracle_java::ssopassword)
    }
  } else {
    Archive {
      source => "${download_url_real}/${filename_real}",
    }
  }

  # download archive
  if $maj_version == '6' {
    archive { "${install_path}/${filename_real}":
      cleanup => false,
      extract => false
    }
  } else {
    # also extract and clean up if tar.gz
    archive { "${install_path}/${filename_real}":
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
      command => "chmod +x ${filename_real}; ./${filename_real}"
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
                         --slave /usr/bin/jaotc jaotc ${install_path}/${longversion}/bin/jaotc \
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
                         --slave /usr/bin/jdeprscan jdeprscan ${install_path}/${longversion}/bin/jdeprscan \
                         --slave /usr/bin/jdeps jdeps ${install_path}/${longversion}/bin/jdeps \
                         --slave /usr/bin/jhat jhat ${install_path}/${longversion}/bin/jhat \
                         --slave /usr/bin/jhsdb jhsdb ${install_path}/${longversion}/bin/jhsdb \
                         --slave /usr/bin/jimage jimage ${install_path}/${longversion}/bin/jimage \
                         --slave /usr/bin/jinfo jinfo ${install_path}/${longversion}/bin/jinfo \
                         --slave /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs \
                         --slave /usr/bin/jlink jlink ${install_path}/${longversion}/bin/jlink \
                         --slave /usr/bin/jmap jmap ${install_path}/${longversion}/bin/jmap \
                         --slave /usr/bin/jmc jmc ${install_path}/${longversion}/bin/jmc \
                         --slave /usr/bin/jmod jmod ${install_path}/${longversion}/bin/jmod \
                         --slave /usr/bin/jps jps ${install_path}/${longversion}/bin/jps \
                         --slave /usr/bin/jrunscript jrunscript ${install_path}/${longversion}/bin/jrunscript \
                         --slave /usr/bin/jsadebugd jsadebugd ${install_path}/${longversion}/bin/jsadebugd \
                         --slave /usr/bin/jshell jshell ${install_path}/${longversion}/bin/jshell \
                         --slave /usr/bin/jstack jstack ${install_path}/${longversion}/bin/jstack \
                         --slave /usr/bin/jstat jstat ${install_path}/${longversion}/bin/jstat \
                         --slave /usr/bin/jstatd jstatd ${install_path}/${longversion}/bin/jstatd \
                         --slave /usr/bin/jvisualvm jvisualvm ${install_path}/${longversion}/bin/jvisualvm \
                         --slave /usr/bin/jweblauncher jweblauncher ${install_path}/${longversion}/bin/jweblauncher \
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
                         --slave /usr/share/man/man1/jaotc.1 jaotc.1 ${install_path}/${longversion}/man/man1/jaotc.1 \
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
                         --slave /usr/share/man/man1/jdeprscan.1 jdeprscan.1 ${install_path}/${longversion}/man/man1/jdeprscan.1 \
                         --slave /usr/share/man/man1/jdeps.1 jdeps.1 ${install_path}/${longversion}/man/man1/jdeps.1 \
                         --slave /usr/share/man/man1/jhat.1 jhat.1 ${install_path}/${longversion}/man/man1/jhat.1 \
                         --slave /usr/share/man/man1/jhsdb.1 jhsdb.1 ${install_path}/${longversion}/man/man1/jhsdb.1 \
                         --slave /usr/share/man/man1/jimage.1 jimage.1 ${install_path}/${longversion}/man/man1/jimage.1 \
                         --slave /usr/share/man/man1/jinfo.1 jinfo.1 ${install_path}/${longversion}/man/man1/jinfo.1 \
                         --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1 \
                         --slave /usr/share/man/man1/jlink.1 jlink.1 ${install_path}/${longversion}/man/man1/jlink.1 \
                         --slave /usr/share/man/man1/jmap.1 jmap.1 ${install_path}/${longversion}/man/man1/jmap.1 \
                         --slave /usr/share/man/man1/jmc.1 jmc.1 ${install_path}/${longversion}/man/man1/jmc.1 \
                         --slave /usr/share/man/man1/jmod.1 jmod.1 ${install_path}/${longversion}/man/man1/jmod.1 \
                         --slave /usr/share/man/man1/jps.1 jps.1 ${install_path}/${longversion}/man/man1/jps.1 \
                         --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${install_path}/${longversion}/man/man1/jrunscript.1 \
                         --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 ${install_path}/${longversion}/man/man1/jsadebugd.1 \
                         --slave /usr/share/man/man1/jshell.1 jshell.1 ${install_path}/${longversion}/man/man1/jshell.1 \
                         --slave /usr/share/man/man1/jstack.1 jstack.1 ${install_path}/${longversion}/man/man1/jstack.1 \
                         --slave /usr/share/man/man1/jstat.1 jstat.1 ${install_path}/${longversion}/man/man1/jstat.1 \
                         --slave /usr/share/man/man1/jstatd.1 jstatd.1 ${install_path}/${longversion}/man/man1/jstatd.1 \
                         --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 ${install_path}/${longversion}/man/man1/jvisualvm.1 \
                         --slave /usr/share/man/man1/jweblauncher.1 jweblauncher.1 ${install_path}/${longversion}/man/man1/jweblauncher.1 \
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
                         --slave /usr/bin/appletviewer appletviewer ${install_path}/${longversion}/bin/appletviewer \
                         --slave /usr/bin/idlj idlj ${install_path}/${longversion}/bin/idlj \
                         --slave /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws \
                         --slave /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol \
                         --slave /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs \
                         --slave /usr/bin/jrunscript jrunscript ${install_path}/${longversion}/bin/jrunscript \
                         --slave /usr/bin/jweblauncher jweblauncher ${install_path}/${longversion}/bin/jweblauncher \
                         --slave /usr/bin/keytool keytool ${install_path}/${longversion}/bin/keytool \
                         --slave /usr/bin/orbd orbd ${install_path}/${longversion}/bin/orbd \
                         --slave /usr/bin/pack200 pack200 ${install_path}/${longversion}/bin/pack200 \
                         --slave /usr/bin/policytool policytool ${install_path}/${longversion}/bin/policytool \
                         --slave /usr/bin/rmid rmid ${install_path}/${longversion}/bin/rmid \
                         --slave /usr/bin/rmiregistry rmiregistry ${install_path}/${longversion}/bin/rmiregistry \
                         --slave /usr/bin/servertool servertool ${install_path}/${longversion}/bin/servertool \
                         --slave /usr/bin/tnameserv tnameserv ${install_path}/${longversion}/bin/tnameserv \
                         --slave /usr/bin/unpack200 unpack200 ${install_path}/${longversion}/bin/unpack200 \
                         --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 ${install_path}/${longversion}/man/man1/appletviewer.1 \
                         --slave /usr/share/man/man1/idlj.1 idlj.1 ${install_path}/${longversion}/man/man1/idlj.1 \
                         --slave /usr/share/man/man1/java.1 java.1 ${install_path}/${longversion}/man/man1/java.1 \
                         --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1 \
                         --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1 \
                         --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${install_path}/${longversion}/man/man1/jrunscript.1 \
                         --slave /usr/share/man/man1/jweblauncher.1 jweblauncher.1 ${install_path}/${longversion}/man/man1/jweblauncher.1 \
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
                          update-alternatives --install /usr/bin/jlink jlink ${install_path}/${longversion}/bin/jlink ${priority} \
                           --slave /usr/share/man/man1/jlink.1 jlink.1 ${install_path}/${longversion}/man/man1/jlink.1;
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
                          update-alternatives --install /usr/bin/jaotc jaotc ${install_path}/${longversion}/bin/jaotc ${priority} \
                           --slave /usr/share/man/man1/jaotc.1 jaotc.1 ${install_path}/${longversion}/man/man1/jaotc.1;
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
                          update-alternatives --install /usr/bin/jhsdb jhsdb ${install_path}/${longversion}/bin/jhsdb ${priority} \
                           --slave /usr/share/man/man1/jhsdb.1 jhsdb.1 ${install_path}/${longversion}/man/man1/jhsdb.1;
                          update-alternatives --install /usr/bin/jimage jimage ${install_path}/${longversion}/bin/jimage ${priority} \
                           --slave /usr/share/man/man1/jimage.1 jimage.1 ${install_path}/${longversion}/man/man1/jimage.1;
                          update-alternatives --install /usr/bin/jinfo jinfo ${install_path}/${longversion}/bin/jinfo ${priority} \
                           --slave /usr/share/man/man1/jinfo.1 jinfo.1 ${install_path}/${longversion}/man/man1/jinfo.1;
                          update-alternatives --install /usr/bin/jmap jmap ${install_path}/${longversion}/bin/jmap ${priority} \
                           --slave /usr/share/man/man1/jmap.1 jmap.1 ${install_path}/${longversion}/man/man1/jmap.1;
                          update-alternatives --install /usr/bin/jmc jmc ${install_path}/${longversion}/bin/jmc ${priority} \
                           --slave /usr/share/man/man1/jmc.1 jmc.1 ${install_path}/${longversion}/man/man1/jmc.1;
                          update-alternatives --install /usr/bin/jmod jmod ${install_path}/${longversion}/bin/jmod ${priority} \
                           --slave /usr/share/man/man1/jmod.1 jmod.1 ${install_path}/${longversion}/man/man1/jmod.1;
                          update-alternatives --install /usr/bin/jps jps ${install_path}/${longversion}/bin/jps ${priority} \
                           --slave /usr/share/man/man1/jps.1 jps.1 ${install_path}/${longversion}/man/man1/jps.1;
                          update-alternatives --install /usr/bin/jrunscript jrunscript ${install_path}/${longversion}/bin/jrunscript ${priority} \
                           --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${install_path}/${longversion}/man/man1/jrunscript.1;
                          update-alternatives --install /usr/bin/jsadebugd jsadebugd ${install_path}/${longversion}/bin/jsadebugd ${priority} \
                           --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 ${install_path}/${longversion}/man/man1/jsadebugd.1;
                          update-alternatives --install /usr/bin/jshell jshell ${install_path}/${longversion}/bin/jshell ${priority} \
                           --slave /usr/share/man/man1/jshell.1 jshell.1 ${install_path}/${longversion}/man/man1/jshell.1;
                          update-alternatives --install /usr/bin/jstack jstack ${install_path}/${longversion}/bin/jstack ${priority} \
                           --slave /usr/share/man/man1/jstack.1 jstack.1 ${install_path}/${longversion}/man/man1/jstack.1;
                          update-alternatives --install /usr/bin/jstat jstat ${install_path}/${longversion}/bin/jstat ${priority} \
                           --slave /usr/share/man/man1/jstat.1 jstat.1 ${install_path}/${longversion}/man/man1/jstat.1;
                          update-alternatives --install /usr/bin/jstatd jstatd ${install_path}/${longversion}/bin/jstatd ${priority} \
                           --slave /usr/share/man/man1/jstatd.1 jstatd.1 ${install_path}/${longversion}/man/man1/jstatd.1;
                          update-alternatives --install /usr/bin/jvisualvm jvisualvm ${install_path}/${longversion}/bin/jvisualvm ${priority} \
                           --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 ${install_path}/${longversion}/man/man1/jvisualvm.1;
                          update-alternatives --install /usr/bin/jweblauncher jweblauncher ${install_path}/${longversion}/bin/jweblauncher ${priority} \
                           --slave /usr/share/man/man1/jweblauncher.1 jweblauncher.1 ${install_path}/${longversion}/man/man1/jweblauncher.1;
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
                          update-alternatives --install /usr/bin/appletviewer appletviewer ${install_path}/${longversion}/bin/appletviewer ${priority} \
                           --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 ${install_path}/${longversion}/man/man1/appletviewer.1;
                          update-alternatives --install /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws ${priority} \
                           --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1;
                          update-alternatives --install /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol ${priority};
                          update-alternatives --install /usr/bin/idlj idlj ${install_path}/${longversion}/bin/idlj ${priority} \
                           --slave /usr/share/man/man1/idlj.1 idlj.1 ${install_path}/${longversion}/man/man1/idlj.1;
                          update-alternatives --install /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs${priority} \
                           --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1;
                          update-alternatives --install /usr/bin/jrunscript jrunscript ${install_path}/${longversion}/bin/jrunscript ${priority} \
                           --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${install_path}/${longversion}/man/man1/jrunscript.1;
                          update-alternatives --install /usr/bin/jweblauncher jweblauncher ${install_path}/${longversion}/bin/jweblauncher ${priority} \
                           --slave /usr/share/man/man1/jweblauncher.1 jweblauncher.1 ${install_path}/${longversion}/man/man1/jweblauncher.1;
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
