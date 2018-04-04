# == Class: oracle_java::install::targz
#
# This class is used to extract the tar.gz version of Java
#
class oracle_java::install::targz {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # the procedure is a bit more complicated for Java 6...
  # files are packaged into an unzipsfx archive which has to be extracted
  if $oracle_java::maj_version == '6' {
    exec { 'unpack java files':
      path    => '/bin',
      cwd     => $oracle_java::install_path,
      creates => "${oracle_java::install_path}/${oracle_java::longversion}",
      command => "chmod +x ${oracle_java::filename_real}; ./${oracle_java::filename_real}"
    }
  }

  # fix permissions
  file { "${oracle_java::install_path}/${oracle_java::longversion}":
    ensure   => directory,
    recurse  => true,
    owner    => 'root',
    group    => 'root',
    loglevel => debug
  }

  # mimic RPM behaviour
  file { "${oracle_java::install_path}/default":
    ensure => link,
    target => "${oracle_java::install_path}/${oracle_java::longversion}"
  }
}
