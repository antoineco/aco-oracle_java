# == Class: oracle_java::install
class oracle_java::install {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # define packages required by the exec resources
  if $oracle_java::maj_version < 7 {
    if !defined(Package['sed']) {
      package { 'sed': ensure => present }
    }
  }

  # install package
  if $oracle_java::maj_version >= 7 {
    package { $oracle_java::packagename:
      ensure   => latest,
      source   => "/usr/java/${oracle_java::filename}",
      provider => rpm
    }
  }
  # the procedure is a bit more complicated for Java 6...
  # RPM files are packaged into a BIN archive which needs to be extracted
   else {
    exec { 'unpack java RPM':
      path    => '/bin',
      cwd     => '/usr/java',
      creates => "/usr/java/${oracle_java::filename_extracted}",
      command => "sed -ni '/exit 0/,\${//!p}' ${oracle_java::filename}; chmod +x ${oracle_java::filename}; ./${oracle_java::filename}",
      require => Package['sed']
    } ~>
    # remove undesired extra RPMs
    exec { 'cleanup java RPM':
      path        => '/bin',
      cwd         => '/usr/java',
      refreshonly => true,
      command     => 'rm -f sun-javadb-*.rpm'
    } ->
    package { $oracle_java::packagename:
      ensure   => latest,
      source   => "/usr/java/${oracle_java::filename_extracted}",
      provider => rpm
    }
  }
}