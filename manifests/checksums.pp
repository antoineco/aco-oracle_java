# == Class: oracle_java::checksums
class oracle_java::checksums {
  case $oracle_java::filename {
    # 8u25 - https://www.oracle.com/webfolder/s/digest/8u25checksum.html
    'jdk-8u25-linux-x64.rpm'     : { $checksum = '6a8897b5d92e5850ef3458aa89a5e9d7' }
    'jdk-8u25-linux-i586.rpm'    : { $checksum = '86c47648337ab32477f52f8b303c4fca' }
    'jdk-8u25-linux-x64.tar.gz'  : { $checksum = 'e145c03a7edc845215092786bcfba77e' }
    'jdk-8u25-linux-i586.tar.gz' : { $checksum = 'b5b16247f66643727d9b6d4bc7c5efda' }
    'jre-8u25-linux-x64.rpm'     : { $checksum = '96f77d62fe678a27466594ff9359eb0b' }
    'jre-8u25-linux-i586.rpm'    : { $checksum = '53c0cbd1dc8741a16fe28ce4bc6a35a6' }
    'jre-8u25-linux-x64.tar.gz'  : { $checksum = 'f4f7f7335eaf2e7b5ff455abece9d5ed' }
    'jre-8u25-linux-i586.tar.gz' : { $checksum = '22d970566c418499d331a2099d77c548' }
    # 8u20
    'jdk-8u20-linux-x64.rpm'     : { $checksum = '' }
    'jdk-8u20-linux-i586.rpm'    : { $checksum = '' }
    'jdk-8u20-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-8u20-linux-i586.tar.gz' : { $checksum = '' }
    'jre-8u20-linux-x64.rpm'     : { $checksum = '' }
    'jre-8u20-linux-i586.rpm'    : { $checksum = '' }
    'jre-8u20-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-8u20-linux-i586.tar.gz' : { $checksum = '' }
    # 8u11
    'jdk-8u11-linux-x64.rpm'     : { $checksum = '' }
    'jdk-8u11-linux-i586.rpm'    : { $checksum = '' }
    'jdk-8u11-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-8u11-linux-i586.tar.gz' : { $checksum = '' }
    'jre-8u11-linux-x64.rpm'     : { $checksum = '' }
    'jre-8u11-linux-i586.rpm'    : { $checksum = '' }
    'jre-8u11-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-8u11-linux-i586.tar.gz' : { $checksum = '' }
    # 8u5
    'jdk-8u5-linux-x64.rpm'      : { $checksum = '' }
    'jdk-8u5-linux-i586.rpm'     : { $checksum = '' }
    'jdk-8u5-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-8u5-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-8u5-linux-x64.rpm'      : { $checksum = '' }
    'jre-8u5-linux-i586.rpm'     : { $checksum = '' }
    'jre-8u5-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-8u5-linux-i586.tar.gz'  : { $checksum = '' }
    # 8u0
    'jdk-8-linux-x64.rpm'        : { $checksum = '' }
    'jdk-8-linux-i586.rpm'       : { $checksum = '' }
    'jdk-8-linux-x64.tar.gz'     : { $checksum = '' }
    'jdk-8-linux-i586.tar.gz'    : { $checksum = '' }
    'jre-8-linux-x64.rpm'        : { $checksum = '' }
    'jre-8-linux-i586.rpm'       : { $checksum = '' }
    'jre-8-linux-x64.tar.gz'     : { $checksum = '' }
    'jre-8-linux-i586.tar.gz'    : { $checksum = '' }
    # 7u72 - https://www.oracle.com/webfolder/s/digest/7u72checksum.html
    'jdk-7u72-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u72-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u72-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u72-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u72-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u72-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u72-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u72-linux-i586.tar.gz' : { $checksum = '' }
    # 7u71 - https://www.oracle.com/webfolder/s/digest/7u71checksum.html
    'jdk-7u71-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u71-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u71-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u71-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u71-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u71-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u71-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u71-linux-i586.tar.gz' : { $checksum = '' }
    # 7u67
    'jdk-7u67-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u67-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u67-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u67-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u67-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u67-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u67-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u67-linux-i586.tar.gz' : { $checksum = '' }
    # 7u65
    'jdk-7u65-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u65-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u65-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u65-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u65-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u65-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u65-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u65-linux-i586.tar.gz' : { $checksum = '' }
    # 7u60
    'jdk-7u60-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u60-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u60-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u60-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u60-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u60-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u60-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u60-linux-i586.tar.gz' : { $checksum = '' }
    # 7u55
    'jdk-7u55-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u55-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u55-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u55-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u55-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u55-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u55-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u55-linux-i586.tar.gz' : { $checksum = '' }
    # 7u51
    'jdk-7u51-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u51-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u51-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u51-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u51-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u51-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u51-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u51-linux-i586.tar.gz' : { $checksum = '' }
    # 7u45
    'jdk-7u45-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u45-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u45-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u45-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u45-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u45-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u45-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u45-linux-i586.tar.gz' : { $checksum = '' }
    # 7u40
    'jdk-7u40-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u40-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u40-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u40-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u40-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u40-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u40-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u40-linux-i586.tar.gz' : { $checksum = '' }
    # 7u25
    'jdk-7u25-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u25-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u25-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u25-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u25-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u25-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u25-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u25-linux-i586.tar.gz' : { $checksum = '' }
    # 7u21
    'jdk-7u21-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u21-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u21-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u21-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u21-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u21-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u21-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u21-linux-i586.tar.gz' : { $checksum = '' }
    # 7u17
    'jdk-7u17-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u17-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u17-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u17-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u17-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u17-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u17-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u17-linux-i586.tar.gz' : { $checksum = '' }
    # 7u15
    'jdk-7u15-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u15-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u15-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u15-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u15-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u15-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u15-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u15-linux-i586.tar.gz' : { $checksum = '' }
    # 7u13
    'jdk-7u13-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u13-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u13-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u13-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u13-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u13-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u13-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u13-linux-i586.tar.gz' : { $checksum = '' }
    # 7u11
    'jdk-7u11-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u11-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u11-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u11-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u11-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u11-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u11-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u11-linux-i586.tar.gz' : { $checksum = '' }
    # 7u10
    'jdk-7u10-linux-x64.rpm'     : { $checksum = '' }
    'jdk-7u10-linux-i586.rpm'    : { $checksum = '' }
    'jdk-7u10-linux-x64.tar.gz'  : { $checksum = '' }
    'jdk-7u10-linux-i586.tar.gz' : { $checksum = '' }
    'jre-7u10-linux-x64.rpm'     : { $checksum = '' }
    'jre-7u10-linux-i586.rpm'    : { $checksum = '' }
    'jre-7u10-linux-x64.tar.gz'  : { $checksum = '' }
    'jre-7u10-linux-i586.tar.gz' : { $checksum = '' }
    # 7u9
    'jdk-7u9-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u9-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u9-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u9-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u9-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u9-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u9-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u9-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u7
    'jdk-7u7-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u7-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u7-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u7-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u7-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u7-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u7-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u7-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u6
    'jdk-7u6-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u6-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u6-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u6-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u6-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u6-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u6-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u6-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u5
    'jdk-7u5-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u5-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u5-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u5-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u5-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u5-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u5-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u5-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u4
    'jdk-7u4-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u4-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u4-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u4-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u4-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u4-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u4-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u4-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u3
    'jdk-7u3-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u3-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u3-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u3-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u3-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u3-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u3-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u3-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u2
    'jdk-7u2-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u2-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u2-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u2-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u2-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u2-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u2-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u2-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u1
    'jdk-7u1-linux-x64.rpm'      : { $checksum = '' }
    'jdk-7u1-linux-i586.rpm'     : { $checksum = '' }
    'jdk-7u1-linux-x64.tar.gz'   : { $checksum = '' }
    'jdk-7u1-linux-i586.tar.gz'  : { $checksum = '' }
    'jre-7u1-linux-x64.rpm'      : { $checksum = '' }
    'jre-7u1-linux-i586.rpm'     : { $checksum = '' }
    'jre-7u1-linux-x64.tar.gz'   : { $checksum = '' }
    'jre-7u1-linux-i586.tar.gz'  : { $checksum = '' }
    # 7u0
    'jdk-7-linux-x64.rpm'        : { $checksum = '' }
    'jdk-7-linux-i586.rpm'       : { $checksum = '' }
    'jdk-7-linux-x64.tar.gz'     : { $checksum = '' }
    'jdk-7-linux-i586.tar.gz'    : { $checksum = '' }
    'jre-7-linux-x64.rpm'        : { $checksum = '' }
    'jre-7-linux-i586.rpm'       : { $checksum = '' }
    'jre-7-linux-x64.tar.gz'     : { $checksum = '' }
    'jre-7-linux-i586.tar.gz'    : { $checksum = '' }
    default : { fail("Unknown checksum for file ${oracle_java::filename}") }
  }
}