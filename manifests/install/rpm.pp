# == Class: oracle_java::install::rpm
#
# This class is used to install the RPM version of Java
#
class oracle_java::install::rpm {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # install package
  if $oracle_java::maj_version >= '7' {
    package { $oracle_java::packagename:
      ensure   => latest,
      source   => "${oracle_java::install_path}/${oracle_java::filename}",
      provider => rpm
    }
  }
  # the procedure is a bit more complicated for Java 6...
  # RPM file is packaged into an unzipsfx archive which has to be extracted
  else {
    exec { 'unpack java RPM':
      path    => '/bin',
      cwd     => $oracle_java::install_path,
      creates => "${oracle_java::install_path}/${oracle_java::filename_extracted}",
      command => "chmod +x ${oracle_java::filename}; ./${oracle_java::filename}"
    } ->
    package { $oracle_java::packagename:
      ensure   => latest,
      source   => "${oracle_java::install_path}/${oracle_java::filename_extracted}",
      provider => rpm
    }
  }
}
