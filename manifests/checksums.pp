# == Class: oracle_java::checksums
#
# This class associates a Java archive file name with its expected checksum
#
class oracle_java::checksums {
  case $oracle_java::filename {
    # 8u25
    'jdk-8u25-linux-i586.rpm'    : { $checksum = '86c47648337ab32477f52f8b303c4fca' }
    'jdk-8u25-linux-i586.tar.gz' : { $checksum = 'b5b16247f66643727d9b6d4bc7c5efda' }
    'jdk-8u25-linux-x64.rpm'     : { $checksum = '6a8897b5d92e5850ef3458aa89a5e9d7' }
    'jdk-8u25-linux-x64.tar.gz'  : { $checksum = 'e145c03a7edc845215092786bcfba77e' }
    'jre-8u25-linux-i586.rpm'    : { $checksum = '53c0cbd1dc8741a16fe28ce4bc6a35a6' }
    'jre-8u25-linux-i586.tar.gz' : { $checksum = '22d970566c418499d331a2099d77c548' }
    'jre-8u25-linux-x64.rpm'     : { $checksum = '96f77d62fe678a27466594ff9359eb0b' }
    'jre-8u25-linux-x64.tar.gz'  : { $checksum = 'f4f7f7335eaf2e7b5ff455abece9d5ed' }
    # 8u20
    'jdk-8u20-linux-i586.rpm'    : { $checksum = '082330b7c5652caa8fa6f49016b940ea' }
    'jdk-8u20-linux-i586.tar.gz' : { $checksum = '5dafdef064e18468f21c65051a6918d7' }
    'jdk-8u20-linux-x64.rpm'     : { $checksum = '98fc97402e9f37610d172953b64f2c8a' }
    'jdk-8u20-linux-x64.tar.gz'  : { $checksum = 'ec7f89dc3697b402e2c851d0488f6299' }
    'jre-8u20-linux-i586.rpm'    : { $checksum = '407aa0c938e40736ff666e1eac4b5dc9' }
    'jre-8u20-linux-i586.tar.gz' : { $checksum = '488ebb6b67e2c822ad886c399e4255d6' }
    'jre-8u20-linux-x64.rpm'     : { $checksum = 'bc8387ac80111605567fe24eb1d607d6' }
    'jre-8u20-linux-x64.tar.gz'  : { $checksum = '01cd08eade026ba10d9748a66c2cbb8e' }
    # 8u11
    'jdk-8u11-linux-i586.rpm'    : { $checksum = '815afd78511745be05cc8515cbed2e4d' }
    'jdk-8u11-linux-i586.tar.gz' : { $checksum = '252bd6545d765ccf9d52ac3ef2ebf0aa' }
    'jdk-8u11-linux-x64.rpm'     : { $checksum = 'c3e82b9c73ef98578be1e6a7289ad647' }
    'jdk-8u11-linux-x64.tar.gz'  : { $checksum = '13ee1d0bf6baaf2b119115356f234a48' }
    'jre-8u11-linux-i586.rpm'    : { $checksum = 'd4ec4136153e9880ee70e9246acd8ba8' }
    'jre-8u11-linux-i586.tar.gz' : { $checksum = '329c93351f0fcbc832fdf76a406dfbc3' }
    'jre-8u11-linux-x64.rpm'     : { $checksum = '4d1e85c292bae8f76ed1f49b5c2015b7' }
    'jre-8u11-linux-x64.tar.gz'  : { $checksum = '05b6ce6ce8133c390cd4c5df58434743' }
    # 8u5
    'jdk-8u5-linux-i586.rpm'     : { $checksum = 'f3b96d753696521a1f34d1725e9d0a26' }
    'jdk-8u5-linux-i586.tar.gz'  : { $checksum = 'fb0e8b5c0be11521bccec5d667559e76' }
    'jdk-8u5-linux-x64.rpm'      : { $checksum = '05aa80043ca12022de83f2e4c4c1f73f' }
    'jdk-8u5-linux-x64.tar.gz'   : { $checksum = 'adc3827532741873de9216a5aed883ed' }
    'jre-8u5-linux-i586.rpm'     : { $checksum = '33c368b8511fe8b9bed121dddfdb3df0' }
    'jre-8u5-linux-i586.tar.gz'  : { $checksum = '14f8b937e76d30bf2904d343d126a4b4' }
    'jre-8u5-linux-x64.rpm'      : { $checksum = '93a30349c6e8671fb31dc4bb2c6d409b' }
    'jre-8u5-linux-x64.tar.gz'   : { $checksum = 'd0aab3d18f7ffe7310ed3a72a19efac1' }
    # 8u0
    'jdk-8-linux-i586.rpm'       : { $checksum = '3aa0f6d2409fd0894d54380321251967' }
    'jdk-8-linux-i586.tar.gz'    : { $checksum = '45556e463a561b470bd9d0c07a73effb' }
    'jdk-8-linux-x64.rpm'        : { $checksum = '9bafe523018bf9523ab531de844d3096' }
    'jdk-8-linux-x64.tar.gz'     : { $checksum = '7e9e5e5229c6603a4d8476050bbd98b1' }
    'jre-8-linux-i586.rpm'       : { $checksum = 'f5f1499990dc858e09b538a18140d48b' }
    'jre-8-linux-i586.tar.gz'    : { $checksum = '045a0309585e546fa2da2316309c09ea' }
    'jre-8-linux-x64.rpm'        : { $checksum = 'aa776b85d53202a385e7894b5b64c91e' }
    'jre-8-linux-x64.tar.gz'     : { $checksum = '1e024eb9b0f7f61722e10fc08c873543' }
    # 7u72
    'jdk-7u72-linux-x64.rpm'     : { $checksum = 'c55acf3c04e149c0b91f57758f6b63ce' }
    'jdk-7u72-linux-i586.rpm'    : { $checksum = 'bc6d383794f5baca63568fbbb663d0b5' }
    'jdk-7u72-linux-x64.tar.gz'  : { $checksum = 'cfa44b49e50ea06e5c6ab95ff79e5b2a' }
    'jdk-7u72-linux-i586.tar.gz' : { $checksum = '4a942a47a700e63e050dd66e8ca08a1f' }
    'jre-7u72-linux-x64.rpm'     : { $checksum = 'e48cdd20ee993726005dbaea26ec0dcc' }
    'jre-7u72-linux-i586.rpm'    : { $checksum = 'c31b755e808633bb0ec3102cee67179e' }
    'jre-7u72-linux-x64.tar.gz'  : { $checksum = '4ae2ef732dfd309e86a182ca0f7681fe' }
    'jre-7u72-linux-i586.tar.gz' : { $checksum = 'a66052322c1a26c33bf6078cb4040dfb' }
    # 7u71
    'jdk-7u71-linux-i586.rpm'    : { $checksum = 'ca000c4668d4ffb4958474776ceddf8b' }
    'jdk-7u71-linux-i586.tar.gz' : { $checksum = '54899d0733d9a8697da59de79a02cc8f' }
    'jdk-7u71-linux-x64.rpm'     : { $checksum = 'f9dafcc0bd52f085c8b0894c27b39d10' }
    'jdk-7u71-linux-x64.tar.gz'  : { $checksum = '22761b214b1505f1a9671b124b0f44f4' }
    'jre-7u71-linux-i586.rpm'    : { $checksum = '4742e40e702df2ab373b00a8ee620464' }
    'jre-7u71-linux-i586.tar.gz' : { $checksum = '90a6b9e2a32d06c18a3f16b485f0d1ea' }
    'jre-7u71-linux-x64.rpm'     : { $checksum = '764182d4c6ce628c15d173109d266955' }
    'jre-7u71-linux-x64.tar.gz'  : { $checksum = '7605134662f6c87131eca5745895fe84' }
    # 7u67
    'jdk-7u67-linux-i586.rpm'    : { $checksum = 'e2dafa3d46b5d639d9681b4a5d5dc757' }
    'jdk-7u67-linux-i586.tar.gz' : { $checksum = '715b0e8ba2a06bded75f6a92427e2701' }
    'jdk-7u67-linux-x64.rpm'     : { $checksum = '3209c90d10ca86e5c384f3aa6ad25bba' }
    'jdk-7u67-linux-x64.tar.gz'  : { $checksum = '81e3e2df33e13781e5fac5756ed90e67' }
    'jre-7u67-linux-i586.rpm'    : { $checksum = 'c405accbc8b6071953af771a2b3f9da4' }
    'jre-7u67-linux-i586.tar.gz' : { $checksum = '2a256eb2a91f0084e58c612636342c2b' }
    'jre-7u67-linux-x64.rpm'     : { $checksum = 'b1bb0bd661b30bb39477d9527e26ff59' }
    'jre-7u67-linux-x64.tar.gz'  : { $checksum = '9007c79167be0177fb47e5313c53d5cb' }
    # 7u65
    'jdk-7u65-linux-i586.rpm'    : { $checksum = '3e4669ff2e0ac4ab0b5609d19a2bae71' }
    'jdk-7u65-linux-i586.tar.gz' : { $checksum = 'bfe1f792918aca2fbe53157061e2145c' }
    'jdk-7u65-linux-x64.rpm'     : { $checksum = 'f5a975d77d35bc7713a8806090f5f9e2' }
    'jdk-7u65-linux-x64.tar.gz'  : { $checksum = 'c223bdbaf706f986f7a5061a204f641f' }
    'jre-7u65-linux-i586.rpm'    : { $checksum = '4122514823f99544b64c7990bfef1c34' }
    'jre-7u65-linux-i586.tar.gz' : { $checksum = 'd11d9f4488d75106fc8909b847efaeda' }
    'jre-7u65-linux-x64.rpm'     : { $checksum = 'cca8862e49cf2e6c6e28e1987c59a2f7' }
    'jre-7u65-linux-x64.tar.gz'  : { $checksum = '2f5c128568f697e918c5259d7bcf2fae' }
    # 7u60
    'jdk-7u60-linux-i586.rpm'    : { $checksum = '849a74c2e854bd8fa961da624a2045a2' }
    'jdk-7u60-linux-i586.tar.gz' : { $checksum = 'b33c914b03e46c3e7c33e4bdddbec4bd' }
    'jdk-7u60-linux-x64.rpm'     : { $checksum = '6f0f17f60a0f4326dbe9115dd0925f33' }
    'jdk-7u60-linux-x64.tar.gz'  : { $checksum = 'eba4b121b8a363f583679d7cb2e69d28' }
    'jre-7u60-linux-i586.rpm'    : { $checksum = 'a897c067b420d977e09b5e085ad371fa' }
    'jre-7u60-linux-i586.tar.gz' : { $checksum = '331a7ef8230de0939941d1e9b3b761fd' }
    'jre-7u60-linux-x64.rpm'     : { $checksum = 'dafa30af874544a3cbe59b03b94fdcd1' }
    'jre-7u60-linux-x64.tar.gz'  : { $checksum = '53a787c9a3170308641074cd86606a99' }
    # 7u55
    'jdk-7u55-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u55-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u55-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u55-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u55-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u55-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u55-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u55-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u51
    'jdk-7u51-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u51-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u51-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u51-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u51-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u51-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u51-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u51-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u45
    'jdk-7u45-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u45-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u45-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u45-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u45-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u45-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u45-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u45-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u40
    'jdk-7u40-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u40-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u40-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u40-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u40-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u40-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u40-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u40-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u25
    'jdk-7u25-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u25-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u25-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u25-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u25-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u25-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u25-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u25-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u21
    'jdk-7u21-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u21-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u21-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u21-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u21-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u21-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u21-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u21-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u17
    'jdk-7u17-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u17-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u17-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u17-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u17-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u17-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u17-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u17-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u15
    'jdk-7u15-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u15-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u15-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u15-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u15-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u15-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u15-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u15-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u13
    'jdk-7u13-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u13-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u13-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u13-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u13-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u13-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u13-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u13-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u11
    'jdk-7u11-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u11-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u11-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u11-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u11-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u11-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u11-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u11-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u10
    'jdk-7u10-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u10-linux-i586.tar.gz' : { $checksum = '' }
    'jdk-7u10-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u10-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u10-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u10-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u10-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u10-linux-x64.tar.gz'  : { $checksum = '' }
    # 7u9
    'jdk-7u9-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u9-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u9-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u9-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u9-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u9-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u9-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u9-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u7
    'jdk-7u7-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u7-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u7-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u7-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u7-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u7-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u7-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u7-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u6
    'jdk-7u6-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u6-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u6-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u6-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u6-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u6-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u6-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u6-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u5
    'jdk-7u5-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u5-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u5-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u5-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u5-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u5-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u5-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u5-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u4
    'jdk-7u4-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u4-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u4-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u4-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u4-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u4-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u4-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u4-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u3
    'jdk-7u3-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u3-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u3-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u3-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u3-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u3-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u3-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u3-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u2
    'jdk-7u2-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u2-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u2-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u2-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u2-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u2-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u2-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u2-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u1
    'jdk-7u1-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u1-linux-i586.tar.gz'  : { $checksum = '' }
    'jdk-7u1-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u1-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u1-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u1-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u1-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u1-linux-x64.tar.gz'   : { $checksum = '' }
    # 7u0
    'jdk-7-linux-i586.rpm'       : { $checksum = '' }
    'jdk-7-linux-i586.tar.gz'    : { $checksum = '' }
    'jdk-7-linux-x64.rpm'        : { $checksum = '' }
    'jdk-7-linux-x64.tar.gz'     : { $checksum = '' }
    'jre-7-linux-i586.rpm'       : { $checksum = '' }
    'jre-7-linux-i586.tar.gz'    : { $checksum = '' }
    'jre-7-linux-x64.rpm'        : { $checksum = '' }
    'jre-7-linux-x64.tar.gz'     : { $checksum = '' }
    default : { fail("Unknown checksum for file ${oracle_java::filename}") }
  }
}