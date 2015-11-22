# == Class: oracle_java::alternative::deb
#
# This class adds Oracle Java to the list of java alternatives on Debian-like distributions
#
class oracle_java::alternative::deb {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # forward variables used in exec resources
  $install_path = $oracle_java::install_path
  $longversion = $oracle_java::longversion

  # priority based on java version
  $priority = 1000000 + $oracle_java::maj_version * 100000 + $oracle_java::min_version

  Exec {
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless => "update-alternatives --display java | grep -e ${install_path}/${longversion}/bin/java.*${priority}\$"
  }

  case $oracle_java::type {
    'jdk'   : {
      exec { "add java alternative ${oracle_java::version_final}":
        command => "update-alternatives --install /usr/bin/java java ${install_path}/${longversion}/bin/java ${priority} \
                     --slave /usr/share/man/man1/java.1 java.1 ${install_path}/${longversion}/man/man1/java.1;
                    update-alternatives --install /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws ${priority} \
                     --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1;
                    update-alternatives --install /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol ${priority};
                    update-alternatives --install /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs ${priority} \
                     --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1;
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
                    update-alternatives --install /usr/bin/jinfo jinfo ${install_path}/${longversion}/bin/jinfo ${priority} \
                     --slave /usr/share/man/man1/jinfo.1 jinfo.1 ${install_path}/${longversion}/man/man1/jinfo.1;
                    update-alternatives --install /usr/bin/jmap jmap ${install_path}/${longversion}/bin/jmap ${priority} \
                     --slave /usr/share/man/man1/jmap.1 jmap.1 ${install_path}/${longversion}/man/man1/jmap.1;
                    update-alternatives --install /usr/bin/jmc jmc ${install_path}/${longversion}/bin/jmc ${priority} \
                     --slave /usr/share/man/man1/jmc.1 jmc.1 ${install_path}/${longversion}/man/man1/jmc.1;
                    update-alternatives --install /usr/bin/jps jps ${install_path}/${longversion}/bin/jps ${priority} \
                     --slave /usr/share/man/man1/jps.1 jps.1 ${install_path}/${longversion}/man/man1/jps.1;
                    update-alternatives --install /usr/bin/jrunscript jrunscript ${install_path}/${longversion}/bin/jrunscript ${priority} \
                     --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 ${install_path}/${longversion}/man/man1/jrunscript.1;
                    update-alternatives --install /usr/bin/jsadebugd jsadebugd ${install_path}/${longversion}/bin/jsadebugd ${priority} \
                     --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 ${install_path}/${longversion}/man/man1/jsadebugd.1;
                    update-alternatives --install /usr/bin/jstack jstack ${install_path}/${longversion}/bin/jstack ${priority} \
                     --slave /usr/share/man/man1/jstack.1 jstack.1 ${install_path}/${longversion}/man/man1/jstack.1;
                    update-alternatives --install /usr/bin/jstat jstat ${install_path}/${longversion}/bin/jstat ${priority} \
                     --slave /usr/share/man/man1/jstat.1 jstat.1 ${install_path}/${longversion}/man/man1/jstat.1;
                    update-alternatives --install /usr/bin/jstatd jstatd ${install_path}/${longversion}/bin/jstatd ${priority} \
                     --slave /usr/share/man/man1/jstatd.1 jstatd.1 ${install_path}/${longversion}/man/man1/jstatd.1;
                    update-alternatives --install /usr/bin/jvisualvm jvisualvm ${install_path}/${longversion}/bin/jvisualvm ${priority} \
                     --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 ${install_path}/${longversion}/man/man1/jvisualvm.1;
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
      exec { "add java alternative ${oracle_java::version_final}":
        command => "update-alternatives --install /usr/bin/java java ${install_path}/${longversion}/bin/java ${priority} \
                   --slave /usr/share/man/man1/java.1 java.1 ${install_path}/${longversion}/man/man1/java.1;
                    update-alternatives --install /usr/bin/javaws javaws ${install_path}/${longversion}/bin/javaws ${priority} \
                     --slave /usr/share/man/man1/javaws.1 javaws.1 ${install_path}/${longversion}/man/man1/javaws.1;
                    update-alternatives --install /usr/bin/jcontrol jcontrol ${install_path}/${longversion}/bin/jcontrol ${priority};
                    update-alternatives --install /usr/bin/jjs jjs ${install_path}/${longversion}/bin/jjs${priority} \
                     --slave /usr/share/man/man1/jjs.1 jjs.1 ${install_path}/${longversion}/man/man1/jjs.1;
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
  }
}
