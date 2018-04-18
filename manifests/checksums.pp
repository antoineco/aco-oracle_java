# == Class: oracle_java::checksums
#
# This class associates a Java archive file name to its expected checksum
#
class oracle_java::checksums {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  if !$oracle_java::checksum {
    case $oracle_java::filename_real {
      # 9.0.4
      'jdk-9.0.4_linux-x64_bin.rpm'    : { $md5checksum = 'ae42bc8183305172395d1ac1c41b215b' }
      'jdk-9.0.4_linux-x64_bin.tar.gz' : { $md5checksum = '41de6337d523d365dc3d9c5f862f71cc' }
      'jre-9.0.4_linux-x64_bin.rpm'    : { $md5checksum = '6db8cc5c5d62887590ca2816b48c8423' }
      'jre-9.0.4_linux-x64_bin.tar.gz' : { $md5checksum = 'f894ae55b8405932f4b6a75e4bf40f52' }
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
      # 8u172
      'jdk-8u172-linux-i586.rpm'    : { $md5checksum = '345472922488290894a803f36fdeb2d1' }
      'jdk-8u172-linux-i586.tar.gz' : { $md5checksum = '0462f605ca1a558a0a95c52d46127071' }
      'jdk-8u172-linux-x64.rpm'     : { $md5checksum = '5fe15af21a4a4da4a53e56664d29752a' }
      'jdk-8u172-linux-x64.tar.gz'  : { $md5checksum = 'eda2945e8c02b84adbf78f46c37b71c1' }
      'jre-8u172-linux-i586.rpm'    : { $md5checksum = '50878cc7405891c2a2921b13d4fa97a8' }
      'jre-8u172-linux-i586.tar.gz' : { $md5checksum = '475a2abd81f51171ed599a6308d90a8a' }
      'jre-8u172-linux-x64.rpm'     : { $md5checksum = '82494334f7055435dbf0a331728c76c3' }
      'jre-8u172-linux-x64.tar.gz'  : { $md5checksum = '67c6d523fc008e1431bbb518bc78c9f9' }
      # 8u171
      'jdk-8u171-linux-i586.rpm'    : { $md5checksum = 'a118832a673be1b707bc830e4ef114a6' }
      'jdk-8u171-linux-i586.tar.gz' : { $md5checksum = 'ba5d42b4237cd576ea4209b1dffef6a3' }
      'jdk-8u171-linux-x64.rpm'     : { $md5checksum = '6517ad9e344139a96842845b0279c012' }
      'jdk-8u171-linux-x64.tar.gz'  : { $md5checksum = '43dafc862dd98bcff889e1239625e7a3' }
      'jre-8u171-linux-i586.rpm'    : { $md5checksum = '7ed4cf7c8eb84fbc860226d7ff667927' }
      'jre-8u171-linux-i586.tar.gz' : { $md5checksum = '1f1ce927eb2dd744b76799f0c5d37ccd' }
      'jre-8u171-linux-x64.rpm'     : { $md5checksum = 'e3bba3ef077cc025e5e80f8dda0e5e57' }
      'jre-8u171-linux-x64.tar.gz'  : { $md5checksum = 'c9744c876eb6a66cc1464f2d46bada29' }
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
      'jdk-8u112-linux-i586.rpm'    : { $md5checksum = '3717e85be783a8899b71deaac9a019ec' }
      'jdk-8u112-linux-i586.tar.gz' : { $md5checksum = '66ccf8e7c28969d56863034d030134bf' }
      'jdk-8u112-linux-x64.rpm'     : { $md5checksum = '25b37dc93828cc24e2c246cf6f4a5aac' }
      'jdk-8u112-linux-x64.tar.gz'  : { $md5checksum = 'de9b7a90f0f5a13cfcaa3b01451d0337' }
      'jre-8u112-linux-i586.rpm'    : { $md5checksum = '9d9f8ff1b728bb747e4c793611aba088' }
      'jre-8u112-linux-i586.tar.gz' : { $md5checksum = 'ff4e17ebd082b5c5bad457751468769d' }
      'jre-8u112-linux-x64.rpm'     : { $md5checksum = '5dc4d31d2c845d2c029a46dd2560bd2e' }
      'jre-8u112-linux-x64.tar.gz'  : { $md5checksum = '5ccc09b2cbbf715b583fad72b070b69d' }
      # 8u111
      'jdk-8u111-linux-i586.rpm'    : { $md5checksum = 'b632ea1d221929d26955704475604481' }
      'jdk-8u111-linux-i586.tar.gz' : { $md5checksum = 'f3399a2c00560a8f5f9a652f7c67e493' }
      'jdk-8u111-linux-x64.rpm'     : { $md5checksum = '27504fb3cbbdaa44945572583663dacd' }
      'jdk-8u111-linux-x64.tar.gz'  : { $md5checksum = '2d48badebe05c848cc3b4d6e0c53a457' }
      'jre-8u111-linux-i586.rpm'    : { $md5checksum = '541fc9a8e5207de53de1f85d63b8c12e' }
      'jre-8u111-linux-i586.tar.gz' : { $md5checksum = '1f4844c81c6d6c5c24270054638f7628' }
      'jre-8u111-linux-x64.rpm'     : { $md5checksum = '099044714e758029ca7d875daa54fbfa' }
      'jre-8u111-linux-x64.tar.gz'  : { $md5checksum = '38f7d7a29fd7346350da5a12179d05e7' }
      # 8u102
      'jdk-8u102-linux-i586.rpm'    : { $md5checksum = 'e1faeb8e847f77c3a842571d605ffaa0' }
      'jdk-8u102-linux-i586.tar.gz' : { $md5checksum = '13ca2f1c15a71dde4e57436d5ce671f8' }
      'jdk-8u102-linux-x64.rpm'     : { $md5checksum = '1ffe998845b594c66db2703dd5f60d88' }
      'jdk-8u102-linux-x64.tar.gz'  : { $md5checksum = 'bac58dcec9bb85859810a2a6acba740b' }
      'jre-8u102-linux-i586.rpm'    : { $md5checksum = '712b5b9376feed70893a7ba899e90748' }
      'jre-8u102-linux-i586.tar.gz' : { $md5checksum = '77199a65cc3dd11e6a5dbb3144fad968' }
      'jre-8u102-linux-x64.rpm'     : { $md5checksum = '95fb6160ad3878ed3ca0a1772e0f421d' }
      'jre-8u102-linux-x64.tar.gz'  : { $md5checksum = '18f4cfa3ad7b10dea718e74fd06e5f19' }
      # 8u101
      'jdk-8u101-linux-i586.rpm'    : { $md5checksum = 'fa4561cef6f02e05e3339a122115658b' }
      'jdk-8u101-linux-i586.tar.gz' : { $md5checksum = '4f4600815aa1adb5294278d471e890e3' }
      'jdk-8u101-linux-x64.rpm'     : { $md5checksum = '353403dbc633d70e527f7a8fc9cb708e' }
      'jdk-8u101-linux-x64.tar.gz'  : { $md5checksum = 'a7ab8014716b0dac3adcaf5342167699' }
      'jre-8u101-linux-i586.rpm'    : { $md5checksum = 'f14d8a0c04105752d47590c7d38abd96' }
      'jre-8u101-linux-i586.tar.gz' : { $md5checksum = '70b99858124b1de5fe7b9bf484f1c735' }
      'jre-8u101-linux-x64.rpm'     : { $md5checksum = '8eeed2ea9f48b688cd01b888d3c72bec' }
      'jre-8u101-linux-x64.tar.gz'  : { $md5checksum = '967b7a0c51be657ec79ca27c559943d1' }
      # 8u92
      'jdk-8u92-linux-i586.rpm'     : { $md5checksum = 'ac93a9f5b9a24cf2243e70fe4b45821d' }
      'jdk-8u92-linux-i586.tar.gz'  : { $md5checksum = '0f2839ff1066438123dac3404702a3ef' }
      'jdk-8u92-linux-x64.rpm'      : { $md5checksum = '881ee6070efcb427204f04c98db9a173' }
      'jdk-8u92-linux-x64.tar.gz'   : { $md5checksum = '65a1cc17ea362453a6e0eb4f13be76e4' }
      'jre-8u92-linux-i586.rpm'     : { $md5checksum = '2c55be06a4591a1c92ecf6d70da6f538' }
      'jre-8u92-linux-i586.tar.gz'  : { $md5checksum = 'e2157870ce7f0484f347b8374da863a0' }
      'jre-8u92-linux-x64.rpm'      : { $md5checksum = '99a3ab44a94c17520e70d5f8502ae0ee' }
      'jre-8u92-linux-x64.tar.gz'   : { $md5checksum = 'df1371cec5c66c1039ccc3e7a433c1de' }
      # 8u91
      'jdk-8u91-linux-i586.rpm'     : { $md5checksum = 'aa51e55b8d9a62dc981a36f1377e0d7a' }
      'jdk-8u91-linux-i586.tar.gz'  : { $md5checksum = 'f18cbe901f2c77630f1e301cea32b259' }
      'jdk-8u91-linux-x64.rpm'      : { $md5checksum = '967d658352ebd7fac8904fed690856c6' }
      'jdk-8u91-linux-x64.tar.gz'   : { $md5checksum = '3f3d7d0cd70bfe0feab382ed4b0e45c0' }
      'jre-8u91-linux-i586.rpm'     : { $md5checksum = 'c1ea766e7b25ed730c5d685f34ad62a5' }
      'jre-8u91-linux-i586.tar.gz'  : { $md5checksum = '705521705f0ddaa150f64090e56ae96c' }
      'jre-8u91-linux-x64.rpm'      : { $md5checksum = '60a99e2076ccdc28003a106d6e995f2c' }
      'jre-8u91-linux-x64.tar.gz'   : { $md5checksum = 'cc48b4cacfeda1f699b43ea77ddfaa95' }
      # 8u77
      'jdk-8u77-linux-i586.rpm'     : { $md5checksum = '466a2bb2b48011b51620aeb115a3d6ae' }
      'jdk-8u77-linux-i586.tar.gz'  : { $md5checksum = 'e5bac32e2a7ab5cf9068ba92ba084472' }
      'jdk-8u77-linux-x64.rpm'      : { $md5checksum = 'a1db6aa94d2617c28d8120a789989f72' }
      'jdk-8u77-linux-x64.tar.gz'   : { $md5checksum = 'ee501bef73ba7fac255f0593e595d8eb' }
      'jre-8u77-linux-i586.rpm'     : { $md5checksum = 'e98301955a62e7f0bf44c9c22e0cb9fb' }
      'jre-8u77-linux-i586.tar.gz'  : { $md5checksum = '2a92cc0efa5e087230b0b77cef8a569e' }
      'jre-8u77-linux-x64.rpm'      : { $md5checksum = '5559c78c9d8c0bdbfb89d49aa502b56e' }
      'jre-8u77-linux-x64.tar.gz'   : { $md5checksum = '7e7d8d0918b4f81f6adde9fcb853a036' }
      # 8u72
      'jdk-8u72-linux-i586.rpm'     : { $md5checksum = 'e5bc5ad8a59f343265d5493fe0004ace' }
      'jdk-8u72-linux-i586.tar.gz'  : { $md5checksum = '19e3ad9a6c8dc6d4ff042f459c06b6c4' }
      'jdk-8u72-linux-x64.rpm'      : { $md5checksum = '09a5aab308ff5a6a9d42cf6a5e34c688' }
      'jdk-8u72-linux-x64.tar.gz'   : { $md5checksum = '54cde24fc0596f0f05b5d0d8f329053d' }
      'jre-8u72-linux-i586.rpm'     : { $md5checksum = 'ca219876a0428cb724834bf026eee997' }
      'jre-8u72-linux-i586.tar.gz'  : { $md5checksum = '625a5caea29984d36640aa0e59e5e52c' }
      'jre-8u72-linux-x64.rpm'      : { $md5checksum = '927987581899d7a5e64920c134bab073' }
      'jre-8u72-linux-x64.tar.gz'   : { $md5checksum = 'f45932f9a3a9c38e47a60504d21449f8' }
      # 8u71
      'jdk-8u71-linux-i586.rpm'     : { $md5checksum = 'b76b5f195cd2349ab37ebbaa22f84255' }
      'jdk-8u71-linux-i586.tar.gz'  : { $md5checksum = 'b794964aa840745235bac1409c90a9ac' }
      'jdk-8u71-linux-x64.rpm'      : { $md5checksum = '43a9271b9e9d99dea8af289f9d931984' }
      'jdk-8u71-linux-x64.tar.gz'   : { $md5checksum = '12db05061f8816d01bb234bbdc40fefa' }
      'jre-8u71-linux-i586.rpm'     : { $md5checksum = '881756340b2614f4cb8ba38f5ba5e1c1' }
      'jre-8u71-linux-i586.tar.gz'  : { $md5checksum = '9991e271ec34395c60eed9ee0b393a7c' }
      'jre-8u71-linux-x64.rpm'      : { $md5checksum = '8f6a8da3b7431bf82391fff2c908ad08' }
      'jre-8u71-linux-x64.tar.gz'   : { $md5checksum = '345029226fff96c52ac300c5e01b32f8' }
      # 8u66
      'jdk-8u66-linux-i586.rpm'     : { $md5checksum = 'a35792c4d9ae325404148b90ce632076' }
      'jdk-8u66-linux-i586.tar.gz'  : { $md5checksum = '8a1f36b29152856a5dd2c3953a4c24a1' }
      'jdk-8u66-linux-x64.rpm'      : { $md5checksum = '159cf0b31396458e342835b57afa4b61' }
      'jdk-8u66-linux-x64.tar.gz'   : { $md5checksum = '88f31f3d642c3287134297b8c10e61bf' }
      'jre-8u66-linux-i586.rpm'     : { $md5checksum = '1239ab6d807d4a11fa6a776ae2bf0639' }
      'jre-8u66-linux-i586.tar.gz'  : { $md5checksum = '4656044616b97e4f578680d1ef5d55c0' }
      'jre-8u66-linux-x64.rpm'      : { $md5checksum = 'f7e8be2384d1d536cc364743ee473364' }
      'jre-8u66-linux-x64.tar.gz'   : { $md5checksum = 'af82cfb37e139458ae6297ae1bfc4f5e' }
      # 8u65
      'jdk-8u65-linux-i586.rpm'     : { $md5checksum = 'd776782fa8a8de82a482ad0d4fbe406a' }
      'jdk-8u65-linux-i586.tar.gz'  : { $md5checksum = '7b715e1fe2316c94aaa968b23ce49c9a' }
      'jdk-8u65-linux-x64.rpm'      : { $md5checksum = '1e587aca2514a612b10935813b1cef28' }
      'jdk-8u65-linux-x64.tar.gz'   : { $md5checksum = '196880a42c45ec9ab2f00868d69619c0' }
      'jre-8u65-linux-i586.rpm'     : { $md5checksum = 'a3fa3299fe1d1865ed75ddb8388c47c5' }
      'jre-8u65-linux-i586.tar.gz'  : { $md5checksum = '3c3deab4f2cc4df8b7f56a63dc541236' }
      'jre-8u65-linux-x64.rpm'      : { $md5checksum = '2c6b771c96a01adc10b89cbf6daf6297' }
      'jre-8u65-linux-x64.tar.gz'   : { $md5checksum = 'abe147a99744b19df86e0e08010fff6c' }
      # 8u60
      'jdk-8u60-linux-i586.rpm'     : { $md5checksum = 'b341d458867e7d5ba24bcffeb6d1d32c' }
      'jdk-8u60-linux-i586.tar.gz'  : { $md5checksum = 'a46d706babbd63f459d7ca6d4057d80f' }
      'jdk-8u60-linux-x64.rpm'      : { $md5checksum = '6c9adca7ba0f89fe755653d2a62cdbd3' }
      'jdk-8u60-linux-x64.tar.gz'   : { $md5checksum = 'b8ca513d4f439782c019cb78cd7fd101' }
      'jre-8u60-linux-i586.rpm'     : { $md5checksum = 'e9530e29fb3fc6767a801687d895af7c' }
      'jre-8u60-linux-i586.tar.gz'  : { $md5checksum = '51512cfe055125570b5215a48a553d83' }
      'jre-8u60-linux-x64.rpm'      : { $md5checksum = '2b5e57b4590184af8ea61cf73506f9eb' }
      'jre-8u60-linux-x64.tar.gz'   : { $md5checksum = 'e6e44f44b67c1a412f06694c9c30b77f' }
      # 8u51
      'jdk-8u51-linux-i586.rpm'     : { $md5checksum = 'f851040e139d391c47c815e035ea8a16' }
      'jdk-8u51-linux-i586.tar.gz'  : { $md5checksum = '742b9151d9190a9ae7d8ed05c7d39850' }
      'jdk-8u51-linux-x64.rpm'      : { $md5checksum = 'e539d132c3d98480217554b8f0da2480' }
      'jdk-8u51-linux-x64.tar.gz'   : { $md5checksum = 'b34ff02c5d98b6f372288c17e96c51cf' }
      'jre-8u51-linux-i586.rpm'     : { $md5checksum = '8d9d82697cbcbb2ffcf940632d02f731' }
      'jre-8u51-linux-i586.tar.gz'  : { $md5checksum = 'f234dacdff97e6ac5ff3e85d58f2d158' }
      'jre-8u51-linux-x64.rpm'      : { $md5checksum = '0f200e6ca52ef4f52f3c7b0f1e55ebe3' }
      'jre-8u51-linux-x64.tar.gz'   : { $md5checksum = '3c4e3ed6b1c61fe18b9a88ea8b2d9384' }
      # 8u45
      'jdk-8u45-linux-i586.rpm'     : { $md5checksum = '60be5b761d8dd1fd298b3c02d78857bd' }
      'jdk-8u45-linux-i586.tar.gz'  : { $md5checksum = 'e68241caf30cb81ae4e985be7218bb6d' }
      'jdk-8u45-linux-x64.rpm'      : { $md5checksum = '50ae04f69743921dd6082dfe978672ad' }
      'jdk-8u45-linux-x64.tar.gz'   : { $md5checksum = '1ad9a5be748fb75b31cd3bd3aa339cac' }
      'jre-8u45-linux-i586.rpm'     : { $md5checksum = 'f9900062bfb06d146e60d2043eecd45f' }
      'jre-8u45-linux-i586.tar.gz'  : { $md5checksum = 'def512ee71620662c7f4631bed7da183' }
      'jre-8u45-linux-x64.rpm'      : { $md5checksum = 'aec557cd1cb863aa6defb873889bf3ae' }
      'jre-8u45-linux-x64.tar.gz'   : { $md5checksum = '58486d7b16d7b21fbea7374adc109233' }
      # 8u40
      'jdk-8u40-linux-i586.rpm'     : { $md5checksum = '2fca12b67151a0b175c8ec495cf398eb' }
      'jdk-8u40-linux-i586.tar.gz'  : { $md5checksum = '1c4b119e7f25da30fa1d0ba62deb66f9' }
      'jdk-8u40-linux-x64.rpm'      : { $md5checksum = '21be6e5a53ec795ce4999d5b61fe013c' }
      'jdk-8u40-linux-x64.tar.gz'   : { $md5checksum = '159a3186bb88b77b4eb9ff9971222736' }
      'jre-8u40-linux-i586.rpm'     : { $md5checksum = 'd03360a9192d26a71770206a4257b470' }
      'jre-8u40-linux-i586.tar.gz'  : { $md5checksum = 'b22953df20789fc199877ad7d615d51e' }
      'jre-8u40-linux-x64.rpm'      : { $md5checksum = '1802527c440523d6d9990cb8477593ea' }
      'jre-8u40-linux-x64.tar.gz'   : { $md5checksum = '394d5dbd541691413e5b8d01f2e720d6' }
      # 8u31
      'jdk-8u31-linux-i586.rpm'     : { $md5checksum = '0676136c154c3e0a6f3c3c9ebeb2a47d' }
      'jdk-8u31-linux-i586.tar.gz'  : { $md5checksum = '4e9aec24367672412c7d10105a2a2bbb' }
      'jdk-8u31-linux-x64.rpm'      : { $md5checksum = 'be6abc353ef797755c1c9260c27422e9' }
      'jdk-8u31-linux-x64.tar.gz'   : { $md5checksum = '173e24bc2d5d5ca3469b8e34864a80da' }
      'jre-8u31-linux-i586.rpm'     : { $md5checksum = 'ba6a68f0bbf350040d7d75b92cedae55' }
      'jre-8u31-linux-i586.tar.gz'  : { $md5checksum = '6cb48241523ad39862c05d8cf791ce92' }
      'jre-8u31-linux-x64.rpm'      : { $md5checksum = '4d6a99aa7f2addde8f6ad714e788ff61' }
      'jre-8u31-linux-x64.tar.gz'   : { $md5checksum = 'c81a3cdabe4a12439dae08d4311670ff' }
      # 8u25
      'jdk-8u25-linux-i586.rpm'     : { $md5checksum = '86c47648337ab32477f52f8b303c4fca' }
      'jdk-8u25-linux-i586.tar.gz'  : { $md5checksum = 'b5b16247f66643727d9b6d4bc7c5efda' }
      'jdk-8u25-linux-x64.rpm'      : { $md5checksum = '6a8897b5d92e5850ef3458aa89a5e9d7' }
      'jdk-8u25-linux-x64.tar.gz'   : { $md5checksum = 'e145c03a7edc845215092786bcfba77e' }
      'jre-8u25-linux-i586.rpm'     : { $md5checksum = '53c0cbd1dc8741a16fe28ce4bc6a35a6' }
      'jre-8u25-linux-i586.tar.gz'  : { $md5checksum = '22d970566c418499d331a2099d77c548' }
      'jre-8u25-linux-x64.rpm'      : { $md5checksum = '96f77d62fe678a27466594ff9359eb0b' }
      'jre-8u25-linux-x64.tar.gz'   : { $md5checksum = 'f4f7f7335eaf2e7b5ff455abece9d5ed' }
      # 8u20
      'jdk-8u20-linux-i586.rpm'     : { $md5checksum = '082330b7c5652caa8fa6f49016b940ea' }
      'jdk-8u20-linux-i586.tar.gz'  : { $md5checksum = '5dafdef064e18468f21c65051a6918d7' }
      'jdk-8u20-linux-x64.rpm'      : { $md5checksum = '98fc97402e9f37610d172953b64f2c8a' }
      'jdk-8u20-linux-x64.tar.gz'   : { $md5checksum = 'ec7f89dc3697b402e2c851d0488f6299' }
      'jre-8u20-linux-i586.rpm'     : { $md5checksum = '407aa0c938e40736ff666e1eac4b5dc9' }
      'jre-8u20-linux-i586.tar.gz'  : { $md5checksum = '488ebb6b67e2c822ad886c399e4255d6' }
      'jre-8u20-linux-x64.rpm'      : { $md5checksum = 'bc8387ac80111605567fe24eb1d607d6' }
      'jre-8u20-linux-x64.tar.gz'   : { $md5checksum = '01cd08eade026ba10d9748a66c2cbb8e' }
      # 8u11
      'jdk-8u11-linux-i586.rpm'     : { $md5checksum = '815afd78511745be05cc8515cbed2e4d' }
      'jdk-8u11-linux-i586.tar.gz'  : { $md5checksum = '252bd6545d765ccf9d52ac3ef2ebf0aa' }
      'jdk-8u11-linux-x64.rpm'      : { $md5checksum = 'c3e82b9c73ef98578be1e6a7289ad647' }
      'jdk-8u11-linux-x64.tar.gz'   : { $md5checksum = '13ee1d0bf6baaf2b119115356f234a48' }
      'jre-8u11-linux-i586.rpm'     : { $md5checksum = 'd4ec4136153e9880ee70e9246acd8ba8' }
      'jre-8u11-linux-i586.tar.gz'  : { $md5checksum = '329c93351f0fcbc832fdf76a406dfbc3' }
      'jre-8u11-linux-x64.rpm'      : { $md5checksum = '4d1e85c292bae8f76ed1f49b5c2015b7' }
      'jre-8u11-linux-x64.tar.gz'   : { $md5checksum = '05b6ce6ce8133c390cd4c5df58434743' }
      # 8u5
      'jdk-8u5-linux-i586.rpm'      : { $md5checksum = 'f3b96d753696521a1f34d1725e9d0a26' }
      'jdk-8u5-linux-i586.tar.gz'   : { $md5checksum = 'fb0e8b5c0be11521bccec5d667559e76' }
      'jdk-8u5-linux-x64.rpm'       : { $md5checksum = '05aa80043ca12022de83f2e4c4c1f73f' }
      'jdk-8u5-linux-x64.tar.gz'    : { $md5checksum = 'adc3827532741873de9216a5aed883ed' }
      'jre-8u5-linux-i586.rpm'      : { $md5checksum = '33c368b8511fe8b9bed121dddfdb3df0' }
      'jre-8u5-linux-i586.tar.gz'   : { $md5checksum = '14f8b937e76d30bf2904d343d126a4b4' }
      'jre-8u5-linux-x64.rpm'       : { $md5checksum = '93a30349c6e8671fb31dc4bb2c6d409b' }
      'jre-8u5-linux-x64.tar.gz'    : { $md5checksum = 'd0aab3d18f7ffe7310ed3a72a19efac1' }
      # 8u0
      'jdk-8-linux-i586.rpm'        : { $md5checksum = '3aa0f6d2409fd0894d54380321251967' }
      'jdk-8-linux-i586.tar.gz'     : { $md5checksum = '45556e463a561b470bd9d0c07a73effb' }
      'jdk-8-linux-x64.rpm'         : { $md5checksum = '9bafe523018bf9523ab531de844d3096' }
      'jdk-8-linux-x64.tar.gz'      : { $md5checksum = '7e9e5e5229c6603a4d8476050bbd98b1' }
      'jre-8-linux-i586.rpm'        : { $md5checksum = 'f5f1499990dc858e09b538a18140d48b' }
      'jre-8-linux-i586.tar.gz'     : { $md5checksum = '045a0309585e546fa2da2316309c09ea' }
      'jre-8-linux-x64.rpm'         : { $md5checksum = 'aa776b85d53202a385e7894b5b64c91e' }
      'jre-8-linux-x64.tar.gz'      : { $md5checksum = '1e024eb9b0f7f61722e10fc08c873543' }
      # 7u80
      'jdk-7u80-linux-i586.rpm'     : { $md5checksum = 'e03bbfae91c590710a66a25e20ba4c15' }
      'jdk-7u80-linux-i586.tar.gz'  : { $md5checksum = '0811a4045714bd8f1e1577e318528597' }
      'jdk-7u80-linux-x64.rpm'      : { $md5checksum = 'b516630a940d83b066cf1e6479ec59fe' }
      'jdk-7u80-linux-x64.tar.gz'   : { $md5checksum = '6152f8a7561acf795ca4701daa10a965' }
      'jre-7u80-linux-i586.rpm'     : { $md5checksum = 'a8c4bd41c3b280fbfc888f3524241c1a' }
      'jre-7u80-linux-i586.tar.gz'  : { $md5checksum = 'ff0f6847e51b6be5c241615a73043005' }
      'jre-7u80-linux-x64.rpm'      : { $md5checksum = '8ac14c3a8c340189986fba2fe6ed5faf' }
      'jre-7u80-linux-x64.tar.gz'   : { $md5checksum = 'c0e01ae8683b2d8924ce79cd6ce6a691' }
      # 7u79
      'jdk-7u79-linux-i586.rpm'     : { $md5checksum = '5aeed0298dfa12e2367d64c2519f96e3' }
      'jdk-7u79-linux-i586.tar.gz'  : { $md5checksum = 'b0ed59147c77a6d3e63a7b340e4e1d28' }
      'jdk-7u79-linux-x64.rpm'      : { $md5checksum = '8486da4cdc4123f5c4f080d279f07712' }
      'jdk-7u79-linux-x64.tar.gz'   : { $md5checksum = '9222e097e624800fdd9bfb568169ccad' }
      'jre-7u79-linux-i586.rpm'     : { $md5checksum = '7678667addb5242bf8313d33e98b36df' }
      'jre-7u79-linux-i586.tar.gz'  : { $md5checksum = 'eba02bbd1dcb9546fed93a9854b84ed9' }
      'jre-7u79-linux-x64.rpm'      : { $md5checksum = '28ecc42e74830bc4b69bf072e25377c2' }
      'jre-7u79-linux-x64.tar.gz'   : { $md5checksum = 'fcd884a57920d90fa23240abb403fcf5' }
      # 7u76
      'jdk-7u76-linux-i586.rpm'     : { $md5checksum = '75a1a5873014e18683b48fbf6e9990f9' }
      'jdk-7u76-linux-i586.tar.gz'  : { $md5checksum = '566dcbcedbb9ec5a26f08bd65b14746b' }
      'jdk-7u76-linux-x64.rpm'      : { $md5checksum = '993d0d6425951d2a3fe39d8ad2e550fc' }
      'jdk-7u76-linux-x64.tar.gz'   : { $md5checksum = '5a98b1a3e4c48363d03f664f173bbb9a' }
      'jre-7u76-linux-i586.rpm'     : { $md5checksum = '2d19d0aafa8e3684616803977e3cc364' }
      'jre-7u76-linux-i586.tar.gz'  : { $md5checksum = 'e7eb5d65eab8f57cbf0d5da804327f75' }
      'jre-7u76-linux-x64.rpm'      : { $md5checksum = '02ec5613512692c3d0c41fde4484d4e3' }
      'jre-7u76-linux-x64.tar.gz'   : { $md5checksum = 'a5ee5fd266453e0209e45fb8bb5acd6d' }
      # 7u75
      'jdk-7u75-linux-i586.rpm'     : { $md5checksum = 'c8b7d39c1c6bf750750e51d39e6b72fe' }
      'jdk-7u75-linux-i586.tar.gz'  : { $md5checksum = 'e4371a4fddc049eca3bfef293d812b8e' }
      'jdk-7u75-linux-x64.rpm'      : { $md5checksum = '53b8513548ae527d79899902524a06e1' }
      'jdk-7u75-linux-x64.tar.gz'   : { $md5checksum = '6f1f81030a34f7a9c987f8b68a24d139' }
      'jre-7u75-linux-i586.rpm'     : { $md5checksum = '89f718c7850f3089753da03202087205' }
      'jre-7u75-linux-i586.tar.gz'  : { $md5checksum = '3a2a94b9cd76fa1323dd9a5aaf48383b' }
      'jre-7u75-linux-x64.rpm'      : { $md5checksum = '302813994fe51f5177e8f7717d71e13c' }
      'jre-7u75-linux-x64.tar.gz'   : { $md5checksum = '1869f0d2dac96372e3c345105543ba3e' }
      # 7u72
      'jdk-7u72-linux-i586.rpm'     : { $md5checksum = 'bc6d383794f5baca63568fbbb663d0b5' }
      'jdk-7u72-linux-i586.tar.gz'  : { $md5checksum = '4a942a47a700e63e050dd66e8ca08a1f' }
      'jdk-7u72-linux-x64.rpm'      : { $md5checksum = 'c55acf3c04e149c0b91f57758f6b63ce' }
      'jdk-7u72-linux-x64.tar.gz'   : { $md5checksum = 'cfa44b49e50ea06e5c6ab95ff79e5b2a' }
      'jre-7u72-linux-i586.rpm'     : { $md5checksum = 'c31b755e808633bb0ec3102cee67179e' }
      'jre-7u72-linux-i586.tar.gz'  : { $md5checksum = 'a66052322c1a26c33bf6078cb4040dfb' }
      'jre-7u72-linux-x64.rpm'      : { $md5checksum = 'e48cdd20ee993726005dbaea26ec0dcc' }
      'jre-7u72-linux-x64.tar.gz'   : { $md5checksum = '4ae2ef732dfd309e86a182ca0f7681fe' }
      # 7u71
      'jdk-7u71-linux-i586.rpm'     : { $md5checksum = 'ca000c4668d4ffb4958474776ceddf8b' }
      'jdk-7u71-linux-i586.tar.gz'  : { $md5checksum = '54899d0733d9a8697da59de79a02cc8f' }
      'jdk-7u71-linux-x64.rpm'      : { $md5checksum = 'f9dafcc0bd52f085c8b0894c27b39d10' }
      'jdk-7u71-linux-x64.tar.gz'   : { $md5checksum = '22761b214b1505f1a9671b124b0f44f4' }
      'jre-7u71-linux-i586.rpm'     : { $md5checksum = '4742e40e702df2ab373b00a8ee620464' }
      'jre-7u71-linux-i586.tar.gz'  : { $md5checksum = '90a6b9e2a32d06c18a3f16b485f0d1ea' }
      'jre-7u71-linux-x64.rpm'      : { $md5checksum = '764182d4c6ce628c15d173109d266955' }
      'jre-7u71-linux-x64.tar.gz'   : { $md5checksum = '7605134662f6c87131eca5745895fe84' }
      # 7u67
      'jdk-7u67-linux-i586.rpm'     : { $md5checksum = 'e2dafa3d46b5d639d9681b4a5d5dc757' }
      'jdk-7u67-linux-i586.tar.gz'  : { $md5checksum = '715b0e8ba2a06bded75f6a92427e2701' }
      'jdk-7u67-linux-x64.rpm'      : { $md5checksum = '3209c90d10ca86e5c384f3aa6ad25bba' }
      'jdk-7u67-linux-x64.tar.gz'   : { $md5checksum = '81e3e2df33e13781e5fac5756ed90e67' }
      'jre-7u67-linux-i586.rpm'     : { $md5checksum = 'c405accbc8b6071953af771a2b3f9da4' }
      'jre-7u67-linux-i586.tar.gz'  : { $md5checksum = '2a256eb2a91f0084e58c612636342c2b' }
      'jre-7u67-linux-x64.rpm'      : { $md5checksum = 'b1bb0bd661b30bb39477d9527e26ff59' }
      'jre-7u67-linux-x64.tar.gz'   : { $md5checksum = '9007c79167be0177fb47e5313c53d5cb' }
      # 7u65
      'jdk-7u65-linux-i586.rpm'     : { $md5checksum = '3e4669ff2e0ac4ab0b5609d19a2bae71' }
      'jdk-7u65-linux-i586.tar.gz'  : { $md5checksum = 'bfe1f792918aca2fbe53157061e2145c' }
      'jdk-7u65-linux-x64.rpm'      : { $md5checksum = 'f5a975d77d35bc7713a8806090f5f9e2' }
      'jdk-7u65-linux-x64.tar.gz'   : { $md5checksum = 'c223bdbaf706f986f7a5061a204f641f' }
      'jre-7u65-linux-i586.rpm'     : { $md5checksum = '4122514823f99544b64c7990bfef1c34' }
      'jre-7u65-linux-i586.tar.gz'  : { $md5checksum = 'd11d9f4488d75106fc8909b847efaeda' }
      'jre-7u65-linux-x64.rpm'      : { $md5checksum = 'cca8862e49cf2e6c6e28e1987c59a2f7' }
      'jre-7u65-linux-x64.tar.gz'   : { $md5checksum = '2f5c128568f697e918c5259d7bcf2fae' }
      # 7u60
      'jdk-7u60-linux-i586.rpm'     : { $md5checksum = '849a74c2e854bd8fa961da624a2045a2' }
      'jdk-7u60-linux-i586.tar.gz'  : { $md5checksum = 'b33c914b03e46c3e7c33e4bdddbec4bd' }
      'jdk-7u60-linux-x64.rpm'      : { $md5checksum = '6f0f17f60a0f4326dbe9115dd0925f33' }
      'jdk-7u60-linux-x64.tar.gz'   : { $md5checksum = 'eba4b121b8a363f583679d7cb2e69d28' }
      'jre-7u60-linux-i586.rpm'     : { $md5checksum = 'a897c067b420d977e09b5e085ad371fa' }
      'jre-7u60-linux-i586.tar.gz'  : { $md5checksum = '331a7ef8230de0939941d1e9b3b761fd' }
      'jre-7u60-linux-x64.rpm'      : { $md5checksum = 'dafa30af874544a3cbe59b03b94fdcd1' }
      'jre-7u60-linux-x64.tar.gz'   : { $md5checksum = '53a787c9a3170308641074cd86606a99' }
      # 7u55
      'jdk-7u55-linux-i586.rpm'     : { $md5checksum = '1815d03f299900359fc143475e074591' }
      'jdk-7u55-linux-i586.tar.gz'  : { $md5checksum = 'fec08edfd805ffcc34a1c20f38a9cc65' }
      'jdk-7u55-linux-x64.rpm'      : { $md5checksum = '11c0ab0a2ce24cad94a71bcff13b28f9' }
      'jdk-7u55-linux-x64.tar.gz'   : { $md5checksum = '9e1fb7936f0e5aaa1e64d36ba640bc1f' }
      'jre-7u55-linux-i586.rpm'     : { $md5checksum = 'c180d361a141be77dbe0d0ecbcc1eed3' }
      'jre-7u55-linux-i586.tar.gz'  : { $md5checksum = '9e363fb6fdd072d04aa5862a8e06e6c2' }
      'jre-7u55-linux-x64.rpm'      : { $md5checksum = '4a2ea75c3deeba7e2767de4b62323597' }
      'jre-7u55-linux-x64.tar.gz'   : { $md5checksum = '5dea1a4d745c55c933ef87c8227c4bd5' }
      # 7u51
      'jdk-7u51-linux-i586.rpm'     : { $md5checksum = '457fb449a4486860ec5bde6c28ce8ec4' }
      'jdk-7u51-linux-i586.tar.gz'  : { $md5checksum = '909d353c1caf6b3b54cc20767a7778ef' }
      'jdk-7u51-linux-x64.rpm'      : { $md5checksum = 'c523e7339d925c1e6c5994813f7c9e86' }
      'jdk-7u51-linux-x64.tar.gz'   : { $md5checksum = '764f96c4b078b80adaa5983e75470ff2' }
      'jre-7u51-linux-i586.rpm'     : { $md5checksum = '28d0ee36020023904e64afeebc9555cc' }
      'jre-7u51-linux-i586.tar.gz'  : { $md5checksum = 'f133f125ca93acef3f70d1912cc2f4b0' }
      'jre-7u51-linux-x64.rpm'      : { $md5checksum = 'd914baffa3cb378a6054969d7d9bbbd0' }
      'jre-7u51-linux-x64.tar.gz'   : { $md5checksum = '1f6a93cc5ef5f66bb01bc39fd731cd9f' }
      # 7u45
      'jdk-7u45-linux-i586.rpm'     : { $md5checksum = 'e14d069ec18e8166adda2984e747af7d' }
      'jdk-7u45-linux-i586.tar.gz'  : { $md5checksum = '66b47e77d963c5dd652f0c5d3b03cb52' }
      'jdk-7u45-linux-x64.rpm'      : { $md5checksum = 'ad481550f72d864613b425ac12f4680e' }
      'jdk-7u45-linux-x64.tar.gz'   : { $md5checksum = 'bea330fcbcff77d31878f21753e09b30' }
      'jre-7u45-linux-i586.rpm'     : { $md5checksum = '2804c849aeec9087815150d9ca1b9f6e' }
      'jre-7u45-linux-i586.tar.gz'  : { $md5checksum = '7fa0cf09846e96b367526c95f33bb278' }
      'jre-7u45-linux-x64.rpm'      : { $md5checksum = '52b91f024e795597599d3ec8342ff86b' }
      'jre-7u45-linux-x64.tar.gz'   : { $md5checksum = 'e82743de29c6cb59ae09bbcb090ccbee' }
      # 7u40
      'jdk-7u40-linux-i586.rpm'     : { $md5checksum = '71d0d75ecdf144ad4694443f513eb61a' }
      'jdk-7u40-linux-i586.tar.gz'  : { $md5checksum = '0079cecc8c4d0f088ace5d0ea99d0c5c' }
      'jdk-7u40-linux-x64.rpm'      : { $md5checksum = '652aae7b3133e230e237c46aefba9517' }
      'jdk-7u40-linux-x64.tar.gz'   : { $md5checksum = '511ea34e4a42955bc03c28afa4b8f6cf' }
      'jre-7u40-linux-i586.rpm'     : { $md5checksum = '070de5405ab31ac99eeb5f78f57be9fa' }
      'jre-7u40-linux-i586.tar.gz'  : { $md5checksum = '3e7f53fb5a3a7a4ba57343b1160fe67f' }
      'jre-7u40-linux-x64.rpm'      : { $md5checksum = 'ef3b348dd528e30887eee0fe2c03fe61' }
      'jre-7u40-linux-x64.tar.gz'   : { $md5checksum = '0c775aa90b4c4919b000949f02e0ec5b' }
      # 7u25
      'jdk-7u25-linux-i586.rpm'     : { $md5checksum = 'a02fd5a7b070def2621a06c28f7b6ccb' }
      'jdk-7u25-linux-i586.tar.gz'  : { $md5checksum = '23176d0ebf9dedd21e3150b4bb0ee776' }
      'jdk-7u25-linux-x64.rpm'      : { $md5checksum = 'cefed369b941c7ac010f001e2bda78e6' }
      'jdk-7u25-linux-x64.tar.gz'   : { $md5checksum = '83ba05e260813f7a9140b76e3d37ea33' }
      'jre-7u25-linux-i586.rpm'     : { $md5checksum = '42029241f70df007600d5b38955ef27f' }
      'jre-7u25-linux-i586.tar.gz'  : { $md5checksum = '0e9ccefe49e937e592dbb605f2e8e7d8' }
      'jre-7u25-linux-x64.rpm'      : { $md5checksum = '84f8efd633c40c7605f78a4eadf36f00' }
      'jre-7u25-linux-x64.tar.gz'   : { $md5checksum = '743ee0ebf73ce428c912866d84e374e0' }
      # 7u21
      'jdk-7u21-linux-i586.rpm'     : { $md5checksum = '1b5395de227777ee1f0d8bdcfbf6a013' }
      'jdk-7u21-linux-i586.tar.gz'  : { $md5checksum = 'fc0241e1a3e243602698ac700abc94e9' }
      'jdk-7u21-linux-x64.rpm'      : { $md5checksum = '91fdd397aa7934a333fcc085765e6177' }
      'jdk-7u21-linux-x64.tar.gz'   : { $md5checksum = '3ceef66377b6d87144b802960f5e715b' }
      'jre-7u21-linux-i586.rpm'     : { $md5checksum = '3e790a9e57d84f40559fbd035e925e55' }
      'jre-7u21-linux-i586.tar.gz'  : { $md5checksum = 'd1df6cbb7c2b5cc7e9dd05b3e8e838f9' }
      'jre-7u21-linux-x64.rpm'      : { $md5checksum = '1b90f002d9b34fec8cf6b0be54fc8a9d' }
      'jre-7u21-linux-x64.tar.gz'   : { $md5checksum = 'ad983b63a4d342f2db249a37f1fd6cc3' }
      # 7u17
      'jdk-7u17-linux-i586.rpm'     : { $md5checksum = '42fabc17e5f455192770d55d2d44123e' }
      'jdk-7u17-linux-i586.tar.gz'  : { $md5checksum = '694f9592d894b86a8a3cb56bf71768e6' }
      'jdk-7u17-linux-x64.rpm'      : { $md5checksum = '4a5181913cb9ed0616b3cfb5ee0f5ce1' }
      'jdk-7u17-linux-x64.tar.gz'   : { $md5checksum = 'd9b5870a94c47efa0282d6c1863d0667' }
      'jre-7u17-linux-i586.rpm'     : { $md5checksum = 'ea3c70d69f0d9044a6a42365acef3551' }
      'jre-7u17-linux-i586.tar.gz'  : { $md5checksum = '1ff65703df3cffbe98a6bc477db58e81' }
      'jre-7u17-linux-x64.rpm'      : { $md5checksum = 'df876894de0b0a0a04c4887abb1dc28e' }
      'jre-7u17-linux-x64.tar.gz'   : { $md5checksum = '23e2949c86471ef9bbdfaac525deccea' }
      # 7u15
      'jdk-7u15-linux-i586.rpm'     : { $md5checksum = 'acc02911f1022cb8f120ba2a743a2faa' }
      'jdk-7u15-linux-i586.tar.gz'  : { $md5checksum = '6ebab8e0942706af2f7f5e0195a96f2c' }
      'jdk-7u15-linux-x64.rpm'      : { $md5checksum = '7af6490c7bc619d09fd859bf28c36f9d' }
      'jdk-7u15-linux-x64.tar.gz'   : { $md5checksum = '118a16aab9ff2c3f7c7788658cc77734' }
      'jre-7u15-linux-i586.rpm'     : { $md5checksum = '1569417fe31acae5232ecc80adf84b8d' }
      'jre-7u15-linux-i586.tar.gz'  : { $md5checksum = '5c29a3adfd166a56c306ac297ab554d6' }
      'jre-7u15-linux-x64.rpm'      : { $md5checksum = '6d1690b19578775fecb76a278a3bec85' }
      'jre-7u15-linux-x64.tar.gz'   : { $md5checksum = 'ecb902aec2e7aabe7d8dc41e0b716723' }
      # 7u13
      'jdk-7u13-linux-i586.rpm'     : { $md5checksum = '6f1c45359fa31fe0c3a4a83342baf0b9' }
      'jdk-7u13-linux-i586.tar.gz'  : { $md5checksum = '2e129b77f7c2640dde08c267ed000c49' }
      'jdk-7u13-linux-x64.rpm'      : { $md5checksum = 'f560a0d3e4d7dfe3bd9ae491ccb13d7c' }
      'jdk-7u13-linux-x64.tar.gz'   : { $md5checksum = '5286b7e752fb8814d85124cb623ff045' }
      'jre-7u13-linux-i586.rpm'     : { $md5checksum = '8b55cabb35a379395fd20b31ef2c73ac' }
      'jre-7u13-linux-i586.tar.gz'  : { $md5checksum = 'e34988dda917e5bb6a134eb56d41215d' }
      'jre-7u13-linux-x64.rpm'      : { $md5checksum = '40d403ec3cd7e4a9c0ef1c85d365f677' }
      'jre-7u13-linux-x64.tar.gz'   : { $md5checksum = 'ae24d12dc8b390be02fa3dc84f1bd9fd' }
      # 7u11
      'jdk-7u11-linux-i586.rpm'     : { $md5checksum = 'ecb4c37e230cfbc434a96afb563f483f' }
      'jdk-7u11-linux-i586.tar.gz'  : { $md5checksum = '22239a786477a7d21bc8a835455ca24a' }
      'jdk-7u11-linux-x64.rpm'      : { $md5checksum = '92e435aeea8c1efdce61bd04f528849a' }
      'jdk-7u11-linux-x64.tar.gz'   : { $md5checksum = 'd8f65419fa65f179382ae310237fd1f4' }
      'jre-7u11-linux-i586.rpm'     : { $md5checksum = '6d0e8dac47ed908ee8871840866ea4d8' }
      'jre-7u11-linux-i586.tar.gz'  : { $md5checksum = '76b71067cacddbee8d78db99ffa3d075' }
      'jre-7u11-linux-x64.rpm'      : { $md5checksum = 'd77adb0dc9ba26680857eafeb6c1d8be' }
      'jre-7u11-linux-x64.tar.gz'   : { $md5checksum = '78872a8326394b5aeb1ac58288db66ed' }
      # 7u10
      'jdk-7u10-linux-i586.rpm'     : { $md5checksum = 'ffe1d89332e935c373fbb3990acd964f' }
      'jdk-7u10-linux-i586.tar.gz'  : { $md5checksum = 'd890ad93e1d48c17b980fa3ada65c1be' }
      'jdk-7u10-linux-x64.rpm'      : { $md5checksum = '868b09fa422a30b91881e75ca0d621dc' }
      'jdk-7u10-linux-x64.tar.gz'   : { $md5checksum = '2a75b5510bdb7360b9279a6f659d054a' }
      'jre-7u10-linux-i586.rpm'     : { $md5checksum = '551d91c05864f631c3c2722683fd2e22' }
      'jre-7u10-linux-i586.tar.gz'  : { $md5checksum = '09ad4d62e64cdcf116c4f86290a62f46' }
      'jre-7u10-linux-x64.rpm'      : { $md5checksum = '127403bf32f12b31695a731d89607ec1' }
      'jre-7u10-linux-x64.tar.gz'   : { $md5checksum = '9ce426628b1cb2c16dd05fbd906440aa' }
      # 7u9
      'jdk-7u9-linux-i586.rpm'      : { $md5checksum = 'd40e396b0121c336cbdd8cc4c2b935fc' }
      'jdk-7u9-linux-i586.tar.gz'   : { $md5checksum = 'f66c309ab38d6ba6651f7d98cd58d9d5' }
      'jdk-7u9-linux-x64.rpm'       : { $md5checksum = 'e20057c3eaac8ff80a8c7f2633fdb161' }
      'jdk-7u9-linux-x64.tar.gz'    : { $md5checksum = '372b9dcde93230522672837e1820f939' }
      'jre-7u9-linux-i586.rpm'      : { $md5checksum = 'a3b761a54ffcae835a56de9423dfb70d' }
      'jre-7u9-linux-i586.tar.gz'   : { $md5checksum = '56178ed00dab2ebd8268caf5575743f4' }
      'jre-7u9-linux-x64.rpm'       : { $md5checksum = 'b51f8aeeba6fc88b002d001425910dae' }
      'jre-7u9-linux-x64.tar.gz'    : { $md5checksum = '8e17fa7b2152ab11f915c6936542cc12' }
      # 7u7
      'jdk-7u7-linux-i586.rpm'      : { $md5checksum = 'd8e509dc0c2339bee504d02f260f1ca5' }
      'jdk-7u7-linux-i586.tar.gz'   : { $md5checksum = '5a46b8e1904cc9f94e6102f3e9d3deb8' }
      'jdk-7u7-linux-x64.rpm'       : { $md5checksum = '3ec6a97b53d0073fb99957bd6aeed113' }
      'jdk-7u7-linux-x64.tar.gz'    : { $md5checksum = '15f4b80901111f002894c33a3d78124c' }
      'jre-7u7-linux-i586.rpm'      : { $md5checksum = '9c45f8adf9f235105c74347e0d6b2b2e' }
      'jre-7u7-linux-i586.tar.gz'   : { $md5checksum = 'ea99bedd9db33e9e2970f4b70abd1e4b' }
      'jre-7u7-linux-x64.rpm'       : { $md5checksum = '7b6b941fdd39284060b6ef71a9e74318' }
      'jre-7u7-linux-x64.tar.gz'    : { $md5checksum = '5aa9bd26cdf1fa6afd2b15826b4ba139' }
      # 7u6
      'jdk-7u6-linux-i586.rpm'      : { $md5checksum = 'c1021396fff9958f6d1bc13570d1e2af' }
      'jdk-7u6-linux-i586.tar.gz'   : { $md5checksum = '3ddb72969d92485e8ec9b32dc065130b' }
      'jdk-7u6-linux-x64.rpm'       : { $md5checksum = '75293e886fe7c76f5742df8f2e91518a' }
      'jdk-7u6-linux-x64.tar.gz'    : { $md5checksum = '2178f5f10dadaed75c1476805a3d04d8' }
      'jre-7u6-linux-i586.rpm'      : { $md5checksum = '2182402e9f09560a169fd0575d216ce2' }
      'jre-7u6-linux-i586.tar.gz'   : { $md5checksum = '094ea2232f9b19dd56683728b2de98ab' }
      'jre-7u6-linux-x64.rpm'       : { $md5checksum = '6fa7cceab2492b3cca769e60013f6f71' }
      'jre-7u6-linux-x64.tar.gz'    : { $md5checksum = 'f0339e3251c4acecdf824d5acce87c36' }
      # 7u5
      'jdk-7u5-linux-i586.rpm'      : { $md5checksum = 'af65f499597e382a55d5bf5f3c22ddd2' }
      'jdk-7u5-linux-i586.tar.gz'   : { $md5checksum = 'b3cc5eabc8027529025e48270120429b' }
      'jdk-7u5-linux-x64.rpm'       : { $md5checksum = '9173487a2a22acda7224261ccea75829' }
      'jdk-7u5-linux-x64.tar.gz'    : { $md5checksum = 'c3b4dc26274b86fc3cd4b77ef04fea83' }
      'jre-7u5-linux-i586.rpm'      : { $md5checksum = '8966449a5f0a3e5afac74df79c72186d' }
      'jre-7u5-linux-i586.tar.gz'   : { $md5checksum = '621131c104d77c6ca5e58784861dd060' }
      'jre-7u5-linux-x64.rpm'       : { $md5checksum = '18b00507ad31f1747853ac1c2741a9b0' }
      'jre-7u5-linux-x64.tar.gz'    : { $md5checksum = '4c8850b82a536480cddd771012426f1b' }
      # 7u4
      'jdk-7u4-linux-i586.rpm'      : { $md5checksum = '8f5b9f5f02f4901a7cd7af8271c2eb30' }
      'jdk-7u4-linux-i586.tar.gz'   : { $md5checksum = '8e271abb32ac6ce199ba15ee5beb758b' }
      'jdk-7u4-linux-x64.rpm'       : { $md5checksum = 'a63a36b06838a5858a5d768a31f55978' }
      'jdk-7u4-linux-x64.tar.gz'    : { $md5checksum = 'a5ebe416c83b64a68c463a4a65f9e882' }
      'jre-7u4-linux-i586.rpm'      : { $md5checksum = 'dde9cce87c984635241a1463d145988f' }
      'jre-7u4-linux-i586.tar.gz'   : { $md5checksum = '8e6db43d9a7cac724be2cb9d1329e702' }
      'jre-7u4-linux-x64.rpm'       : { $md5checksum = 'accd9f2f62b0ac0ce4e9b43446640aae' }
      'jre-7u4-linux-x64.tar.gz'    : { $md5checksum = '49da2f0c288f96ed255ed75b796a5455' }
      # 7u3
      'jdk-7u3-linux-i586.rpm'      : { $md5checksum = '37134c1540230c743b95bacbafb81824' }
      'jdk-7u3-linux-i586.tar.gz'   : { $md5checksum = '99a0fa02b608985c271e55122f0621bf' }
      'jdk-7u3-linux-x64.rpm'       : { $md5checksum = 'b86fda55e682f68405c0cbd2b7a84f36' }
      'jdk-7u3-linux-x64.tar.gz'    : { $md5checksum = '969927251b558ffbc09ede1e89200d40' }
      'jre-7u3-linux-i586.rpm'      : { $md5checksum = '6c7e6fbb53430f66af069c448bd819c5' }
      'jre-7u3-linux-i586.tar.gz'   : { $md5checksum = 'cfce10a05f8d152d39aef892f2cd4011' }
      'jre-7u3-linux-x64.rpm'       : { $md5checksum = 'a751a5e80c09440c3877800ce74f2964' }
      'jre-7u3-linux-x64.tar.gz'    : { $md5checksum = '3d3e206cea84129f1daa8e62bf656a28' }
      # 7u2
      'jdk-7u2-linux-i586.rpm'      : { $md5checksum = '18c966992187806d7211f7ff9b2101f2' }
      'jdk-7u2-linux-i586.tar.gz'   : { $md5checksum = '8a06141ffae6c96743ea405b75e54f84' }
      'jdk-7u2-linux-x64.rpm'       : { $md5checksum = 'caeb48713399a5fc70571f49a496a38a' }
      'jdk-7u2-linux-x64.tar.gz'    : { $md5checksum = 'a0bbb9265b4633cfd7823928649f450c' }
      'jre-7u2-linux-i586.rpm'      : { $md5checksum = '16095c606db1793b8c2470864b8ceeb5' }
      'jre-7u2-linux-i586.tar.gz'   : { $md5checksum = '78923ef097586c36a6242c54cb20abd7' }
      'jre-7u2-linux-x64.rpm'       : { $md5checksum = '60558fae90ea89d30760dd32f17a2900' }
      'jre-7u2-linux-x64.tar.gz'    : { $md5checksum = 'c6d0aa62337148787795870a12c17974' }
      # 7u1
      'jdk-7u1-linux-i586.rpm'      : { $md5checksum = 'fae63bedb8158a2d0746130e5c06b707' }
      'jdk-7u1-linux-i586.tar.gz'   : { $md5checksum = '7267759f93bc6fb23046dd42d40d1c2f' }
      'jdk-7u1-linux-x64.rpm'       : { $md5checksum = '05c52eb615fdc33e61b1da2e890acda4' }
      'jdk-7u1-linux-x64.tar.gz'    : { $md5checksum = '9707049b591f47e5c3988a9f029c015e' }
      'jre-7u1-linux-i586.rpm'      : { $md5checksum = '148d996db1cb4958d0551c9b9a339346' }
      'jre-7u1-linux-i586.tar.gz'   : { $md5checksum = 'd9b73cc5ccaa4f0b36cd6b8b62d07142' }
      'jre-7u1-linux-x64.rpm'       : { $md5checksum = 'e5c530718ae7867dbdfc4d486897ac55' }
      'jre-7u1-linux-x64.tar.gz'    : { $md5checksum = '07bd73571b7028b73fc8ed19bc85226d' }
      # 7u0
      'jdk-7-linux-i586.rpm'        : { $md5checksum = '3cc3ca4fb51446cf4f9cb9fa8d0144b9' }
      'jdk-7-linux-i586.tar.gz'     : { $md5checksum = 'f97244a104f03731e5ff69f0dd5a9927' }
      'jdk-7-linux-x64.rpm'         : { $md5checksum = '3c5c52922766ba365f83ee6a60dd2e60' }
      'jdk-7-linux-x64.tar.gz'      : { $md5checksum = 'b3c1ef5faea7b180469c129a49762b64' }
      'jre-7-linux-i586.rpm'        : { $md5checksum = '1b4a922fe6443386322cc06f8a59ba07' }
      'jre-7-linux-i586.tar.gz'     : { $md5checksum = '1c368a19835834a08b9aabd806a1b2d6' }
      'jre-7-linux-x64.rpm'         : { $md5checksum = '07146c32320c3df2510d90e2930ca48d' }
      'jre-7-linux-x64.tar.gz'      : { $md5checksum = '27b14f437db6db6922c753472305c13c' }
      # 6u45
      'jdk-6u45-linux-i586-rpm.bin' : { $md5checksum = '289213fa31ed0bb31266db5441490d61' }
      'jdk-6u45-linux-i586.bin'     : { $md5checksum = '3269370b7c34e6cbfed8785d3d0c5cbd' }
      'jdk-6u45-linux-x64-rpm.bin'  : { $md5checksum = '05f22d01be83c4feea30ab2c6c1cccae' }
      'jdk-6u45-linux-x64.bin'      : { $md5checksum = '40c1a87563c5c6a90a0ed6994615befe' }
      'jre-6u45-linux-i586-rpm.bin' : { $md5checksum = 'a279fb4a116be1f331bf73e28f629f60' }
      'jre-6u45-linux-i586.bin'     : { $md5checksum = '1d8001ef61a2e3a11fe7b9eec9f08948' }
      'jre-6u45-linux-x64-rpm.bin'  : { $md5checksum = '3711f2bea7520a31356a4a266c2dbc3f' }
      'jre-6u45-linux-x64.bin'      : { $md5checksum = '4a4569126f05f525f48bacf761f7185c' }
      default                       : { fail("Unknown checksum for file ${oracle_java::filename_real}") }
    }
  } else {
    $checksum_real = $oracle_java::checksum
  }
}
