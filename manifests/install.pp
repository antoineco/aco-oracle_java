# == Class: oracle_java::install
#
# This class is a wrapper to either install or extract the downloaded Java archive file
#
class oracle_java::install {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # dependency
  if !defined(Class['archive']) {
    include archive
  }

  case $oracle_java::format_real {
    'rpm'   : { contain oracle_java::install::rpm }
    default : { contain oracle_java::install::targz }
  }
}