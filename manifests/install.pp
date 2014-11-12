# == Class: oracle_java::install
class oracle_java::install {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  case $oracle_java::format_real {
    'rpm'    : { contain oracle_java::install::rpm }
    'tar.gz' : { contain oracle_java::install::targz }
  }
}