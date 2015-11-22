# == Class: oracle_java::alternative::rpm
#
# This class adds Oracle Java to the list of java alternatives on RPM distributions
#
class oracle_java::alternative::rpm {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # forward variables used in exec resources
  $custom_archive_path = $oracle_java::custom_archive_path
  $longversion = $oracle_java::longversion

  # priority based on java version
  $priority = 1000000 + $oracle_java::maj_version * 100000 + $oracle_java::min_version

  Exec {
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless => "update-alternatives --display java | grep -e ${custom_archive_path}/${longversion}/bin/java.*${priority}\$"
  }

  case $oracle_java::type {
    'jdk'   : {
      exec { "add java alternative ${oracle_java::version_final}":
        command => "update-alternatives --install /usr/bin/java java ${custom_archive_path}/${longversion}/bin/java ${priority} \
                   --slave /usr/bin/appletviewer appletviewer ${custom_archive_path}/${longversion}/bin/appletviewer \
                   --slave /usr/bin/extcheck extcheck ${custom_archive_path}/${longversion}/bin/extcheck \
                   --slave /usr/bin/idlj idlj ${custom_archive_path}/${longversion}/bin/idlj \
                   --slave /usr/bin/jar jar ${custom_archive_path}/${longversion}/bin/jar \
                   --slave /usr/bin/jarsigner jarsigner ${custom_archive_path}/${longversion}/bin/jarsigner \
                   --slave /usr/bin/javac javac ${custom_archive_path}/${longversion}/bin/javac \
                   --slave /usr/bin/javadoc javadoc ${custom_archive_path}/${longversion}/bin/javadoc \
                   --slave /usr/bin/javafxpackager javafxpackager ${custom_archive_path}/${longversion}/bin/javafxpackager \
                   --slave /usr/bin/javah javah ${custom_archive_path}/${longversion}/bin/javah \
                   --slave /usr/bin/javap javap ${custom_archive_path}/${longversion}/bin/javap \
                   --slave /usr/bin/javapackager javapackager ${custom_archive_path}/${longversion}/bin/javapackager \
                   --slave /usr/bin/java-rmi.cgi java-rmi.cgi ${custom_archive_path}/${longversion}/bin/java-rmi.cgi \
                   --slave /usr/bin/javaws javaws ${custom_archive_path}/${longversion}/bin/javaws \
                   --slave /usr/bin/jcmd jcmd ${custom_archive_path}/${longversion}/bin/jcmd \
                   --slave /usr/bin/jconsole jconsole ${custom_archive_path}/${longversion}/bin/jconsole \
                   --slave /usr/bin/jcontrol jcontrol ${custom_archive_path}/${longversion}/bin/jcontrol \
                   --slave /usr/bin/jdb jdb ${custom_archive_path}/${longversion}/bin/jdb \
                   --slave /usr/bin/jdeps jdeps ${custom_archive_path}/${longversion}/bin/jdeps \
                   --slave /usr/bin/jhat jhat ${custom_archive_path}/${longversion}/bin/jhat \
                   --slave /usr/bin/jinfo jinfo ${custom_archive_path}/${longversion}/bin/jinfo \
                   --slave /usr/bin/jjs jjs ${custom_archive_path}/${longversion}/bin/jjs \
                   --slave /usr/bin/jmap jmap ${custom_archive_path}/${longversion}/bin/jmap \
                   --slave /usr/bin/jmc jmc ${custom_archive_path}/${longversion}/bin/jmc \
                   --slave /usr/bin/jps jps ${custom_archive_path}/${longversion}/bin/jps \
                   --slave /usr/bin/jrunscript jrunscript ${custom_archive_path}/${longversion}/bin/jrunscript \
                   --slave /usr/bin/jsadebugd jsadebugd ${custom_archive_path}/${longversion}/bin/jsadebugd \
                   --slave /usr/bin/jstack jstack ${custom_archive_path}/${longversion}/bin/jstack \
                   --slave /usr/bin/jstat jstat ${custom_archive_path}/${longversion}/bin/jstat \
                   --slave /usr/bin/jstatd jstatd ${custom_archive_path}/${longversion}/bin/jstatd \
                   --slave /usr/bin/jvisualvm jvisualvm ${custom_archive_path}/${longversion}/bin/jvisualvm \
                   --slave /usr/bin/keytool keytool ${custom_archive_path}/${longversion}/bin/keytool \
                   --slave /usr/bin/native2ascii native2ascii ${custom_archive_path}/${longversion}/bin/native2ascii \
                   --slave /usr/bin/orbd orbd ${custom_archive_path}/${longversion}/bin/orbd \
                   --slave /usr/bin/pack200 pack200 ${custom_archive_path}/${longversion}/bin/pack200 \
                   --slave /usr/bin/policytool policytool ${custom_archive_path}/${longversion}/bin/policytool \
                   --slave /usr/bin/rmic rmic ${custom_archive_path}/${longversion}/bin/rmic \
                   --slave /usr/bin/rmid rmid ${custom_archive_path}/${longversion}/bin/rmid \
                   --slave /usr/bin/rmiregistry rmiregistry ${custom_archive_path}/${longversion}/bin/rmiregistry \
                   --slave /usr/bin/schemagen schemagen ${custom_archive_path}/${longversion}/bin/schemagen \
                   --slave /usr/bin/serialver serialver ${custom_archive_path}/${longversion}/bin/serialver \
                   --slave /usr/bin/servertool servertool ${custom_archive_path}/${longversion}/bin/servertool \
                   --slave /usr/bin/tnameserv tnameserv ${custom_archive_path}/${longversion}/bin/tnameserv \
                   --slave /usr/bin/unpack200 unpack200 ${custom_archive_path}/${longversion}/bin/unpack200 \
                   --slave /usr/bin/wsgen wsgen ${custom_archive_path}/${longversion}/bin/wsgen \
                   --slave /usr/bin/wsimport wsimport ${custom_archive_path}/${longversion}/bin/wsimport \
                   --slave /usr/bin/xjc xjc ${custom_archive_path}/${longversion}/bin/xjc \
                   --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 ${custom_archive_path}/${longversion}/man/man1/appletviewer.1 \
                   --slave /usr/share/man/man1/extcheck.1 extcheck.1 ${custom_archive_path}/${longversion}/man/man1/extcheck.1 \
                   --slave /usr/share/man/man1/idlj.1 idlj.1 ${custom_archive_path}/${longversion}/man/man1/idlj.1 \
                   --slave /usr/share/man/man1/jar.1 jar.1 ${custom_archive_path}/${longversion}/man/man1/jar.1 \
                   --slave /usr/share/man/man1/jarsigner.1 jarsigner.1 ${custom_archive_path}/${longversion}/man/man1/jarsigner.1 \
                   --slave /usr/share/man/man1/java.1 java.1 ${custom_archive_path}/${longversion}/man/man1/java.1 \
                   --slave /usr/share/man/man1/javac.1 javac.1 ${custom_archive_path}/${longversion}/man/man1/javac.1 \
                   --slave /usr/share/man/man1/javadoc.1 javadoc.1 ${custom_archive_path}/${longversion}/man/man1/javadoc.1 \
                   --slave /usr/share/man/man1/javafxpackager.1 javafxpackager.1 ${custom_archive_path}/${longversion}/man/man1/javafxpackager.1 \
                   --slave /usr/share/man/man1/javah.1 javah.1 ${custom_archive_path}/${longversion}/man/man1/javah.1 \
                   --slave /usr/share/man/man1/javap.1 javap.1 ${custom_archive_path}/${longversion}/man/man1/javap.1 \
                   --slave /usr/share/man/man1/javapackager.1 javapackager.1 ${custom_archive_path}/${longversion}/man/man1/javapackager.1 \
                   --slave /usr/share/man/man1/javaws.1 javaws.1 ${custom_archive_path}/${longversion}/man/man1/javaws.1 \
                   --slave /usr/share/man/man1/jcmd.1 jcmd.1 ${custom_archive_path}/${longversion}/man/man1/jcmd.1 \
                   --slave /usr/share/man/man1/jconsole.1 jconsole.1 ${custom_archive_path}/${longversion}/man/man1/jconsole.1 \
                   --slave /usr/share/man/man1/jdb.1 jdb.1 ${custom_archive_path}/${longversion}/man/man1/jdb.1 \
                   --slave /usr/share/man/man1/jdeps.1 jdeps.1 ${custom_archive_path}/${longversion}/man/man1/jdeps.1 \
                   --slave /usr/share/man/man1/jhat.1 jhat.1 ${custom_archive_path}/${longversion}/man/man1/jhat.1 \
                   --slave /usr/share/man/man1/jinfo.1 jinfo.1 ${custom_archive_path}/${longversion}/man/man1/jinfo.1 \
                   --slave /usr/share/man/man1/jjs.1 jjs.1 ${custom_archive_path}/${longversion}/man/man1/jjs.1 \
                   --slave /usr/share/man/man1/jmap.1 jmap.1 ${custom_archive_path}/${longversion}/man/man1/jmap.1 \
                   --slave /usr/share/man/man1/jmc.1 jmc.1 ${custom_archive_path}/${longversion}/man/man1/jmc.1 \
                   --slave /usr/share/man/man1/jps.1 jps.1 ${custom_archive_path}/${longversion}/man/man1/jps.1 \
                   --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${custom_archive_path}/${longversion}/man/man1/jrunscript.1 \
                   --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 ${custom_archive_path}/${longversion}/man/man1/jsadebugd.1 \
                   --slave /usr/share/man/man1/jstack.1 jstack.1 ${custom_archive_path}/${longversion}/man/man1/jstack.1 \
                   --slave /usr/share/man/man1/jstat.1 jstat.1 ${custom_archive_path}/${longversion}/man/man1/jstat.1 \
                   --slave /usr/share/man/man1/jstatd.1 jstatd.1 ${custom_archive_path}/${longversion}/man/man1/jstatd.1 \
                   --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 ${custom_archive_path}/${longversion}/man/man1/jvisualvm.1 \
                   --slave /usr/share/man/man1/keytool.1 keytool.1 ${custom_archive_path}/${longversion}/man/man1/keytool.1 \
                   --slave /usr/share/man/man1/native2ascii.1 native2ascii.1 ${custom_archive_path}/${longversion}/man/man1/native2ascii.1 \
                   --slave /usr/share/man/man1/orbd.1 orbd.1 ${custom_archive_path}/${longversion}/man/man1/orbd.1 \
                   --slave /usr/share/man/man1/pack200.1 pack200.1 ${custom_archive_path}/${longversion}/man/man1/pack200.1 \
                   --slave /usr/share/man/man1/policytool.1 policytool.1 ${custom_archive_path}/${longversion}/man/man1/policytool.1 \
                   --slave /usr/share/man/man1/rmic.1 rmic.1 ${custom_archive_path}/${longversion}/man/man1/rmic.1 \
                   --slave /usr/share/man/man1/rmid.1 rmid.1 ${custom_archive_path}/${longversion}/man/man1/rmid.1 \
                   --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 ${custom_archive_path}/${longversion}/man/man1/rmiregistry.1 \
                   --slave /usr/share/man/man1/schemagen.1 schemagen.1 ${custom_archive_path}/${longversion}/man/man1/schemagen.1 \
                   --slave /usr/share/man/man1/serialver.1 serialver.1 ${custom_archive_path}/${longversion}/man/man1/serialver.1 \
                   --slave /usr/share/man/man1/servertool.1 servertool.1 ${custom_archive_path}/${longversion}/man/man1/servertool.1 \
                   --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 ${custom_archive_path}/${longversion}/man/man1/tnameserv.1 \
                   --slave /usr/share/man/man1/unpack200.1 unpack200.1 ${custom_archive_path}/${longversion}/man/man1/unpack200.1 \
                   --slave /usr/share/man/man1/wsgen.1 wsgen.1 ${custom_archive_path}/${longversion}/man/man1/wsgen.1 \
                   --slave /usr/share/man/man1/wsimport.1 wsimport.1 ${custom_archive_path}/${longversion}/man/man1/wsimport.1 \
                   --slave /usr/share/man/man1/xjc.1 xjc.1 ${custom_archive_path}/${longversion}/man/man1/xjc.1"
      }
    }
    default : {
      exec { "add java alternative ${oracle_java::version_final}":
        command => "update-alternatives --install /usr/bin/java java ${custom_archive_path}/${longversion}/bin/java ${priority} \
                   --slave /usr/bin/javaws javaws ${custom_archive_path}/${longversion}/bin/javaws \
                   --slave /usr/bin/jcontrol jcontrol ${custom_archive_path}/${longversion}/bin/jcontrol \
                   --slave /usr/bin/jjs jjs ${custom_archive_path}/${longversion}/bin/jjs \
                   --slave /usr/bin/keytool keytool ${custom_archive_path}/${longversion}/bin/keytool \
                   --slave /usr/bin/orbd orbd ${custom_archive_path}/${longversion}/bin/orbd \
                   --slave /usr/bin/pack200 pack200 ${custom_archive_path}/${longversion}/bin/pack200 \
                   --slave /usr/bin/policytool policytool ${custom_archive_path}/${longversion}/bin/policytool \
                   --slave /usr/bin/rmid rmid ${custom_archive_path}/${longversion}/bin/rmid \
                   --slave /usr/bin/rmiregistry rmiregistry ${custom_archive_path}/${longversion}/bin/rmiregistry \
                   --slave /usr/bin/servertool servertool ${custom_archive_path}/${longversion}/bin/servertool \
                   --slave /usr/bin/tnameserv tnameserv ${custom_archive_path}/${longversion}/bin/tnameserv \
                   --slave /usr/bin/unpack200 unpack200 ${custom_archive_path}/${longversion}/bin/unpack200 \
                   --slave /usr/share/man/man1/java.1 java.1 ${custom_archive_path}/${longversion}/man/man1/java.1 \
                   --slave /usr/share/man/man1/javaws.1 javaws.1 ${custom_archive_path}/${longversion}/man/man1/javaws.1 \
                   --slave /usr/share/man/man1/jjs.1 jjs.1 ${custom_archive_path}/${longversion}/man/man1/jjs.1 \
                   --slave /usr/share/man/man1/keytool.1 keytool.1 ${custom_archive_path}/${longversion}/man/man1/keytool.1 \
                   --slave /usr/share/man/man1/orbd.1 orbd.1 ${custom_archive_path}/${longversion}/man/man1/orbd.1 \
                   --slave /usr/share/man/man1/pack200.1 pack200.1 ${custom_archive_path}/${longversion}/man/man1/pack200.1 \
                   --slave /usr/share/man/man1/policytool.1 policytool.1 ${custom_archive_path}/${longversion}/man/man1/policytool.1 \
                   --slave /usr/share/man/man1/rmid.1 rmid.1 ${custom_archive_path}/${longversion}/man/man1/rmid.1 \
                   --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 ${custom_archive_path}/${longversion}/man/man1/rmiregistry.1 \
                   --slave /usr/share/man/man1/servertool.1 servertool.1 ${custom_archive_path}/${longversion}/man/man1/servertool.1 \
                   --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 ${custom_archive_path}/${longversion}/man/man1/tnameserv.1 \
                   --slave /usr/share/man/man1/unpack200.1 unpack200.1 ${custom_archive_path}/${longversion}/man/man1/unpack200.1"
      }
    }
  }
}
