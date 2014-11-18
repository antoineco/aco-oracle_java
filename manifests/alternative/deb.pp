# == Class: oracle_java::alternative::deb
#
# This class adds Oracle Java to the list of java alternatives on Debian-like distributions
#
class oracle_java::alternative::deb {
  # The base class must be included first
  if !defined(Class['oracle_java']) {
    fail('You must include the oracle_java base class before using any oracle_java sub class')
  }

  # priority based on java version
  $priority = 1000000 + $oracle_java::maj_version * 100000 + $oracle_java::min_version

  Exec {
    path   => '/bin:/sbin:/usr/bin:/usr/sbin',
    unless => "update-alternatives --display java | grep -e /usr/java/${oracle_java::longversion}/bin/java.*${priority}\$"
  }

  case $oracle_java::type {
    'jdk'   : {
      exec { 'add java alternative':
        command => "update-alternatives --install /usr/bin/java java /usr/java/${oracle_java::longversion}/bin/java ${priority} \
         --slave /usr/share/man/man1/java.1 java.1 /usr/java/${oracle_java::longversion}/man/man1/java.1;
        update-alternatives --install /usr/bin/javaws javaws /usr/java/${oracle_java::longversion}/bin/javaws ${priority} \
         --slave /usr/share/man/man1/javaws.1 javaws.1 /usr/java/${oracle_java::longversion}/man/man1/javaws.1;
        update-alternatives --install /usr/bin/jcontrol jcontrol /usr/java/${oracle_java::longversion}/bin/jcontrol ${priority};
        update-alternatives --install /usr/bin/jjs jjs /usr/java/${oracle_java::longversion}/bin/jjs ${priority} \
         --slave /usr/share/man/man1/jjs.1 jjs.1 /usr/java/${oracle_java::longversion}/man/man1/jjs.1;
        update-alternatives --install /usr/bin/keytool keytool /usr/java/${oracle_java::longversion}/bin/keytool ${priority} \
         --slave /usr/share/man/man1/keytool.1 keytool.1 /usr/java/${oracle_java::longversion}/man/man1/keytool.1;
        update-alternatives --install /usr/bin/orbd orbd /usr/java/${oracle_java::longversion}/bin/orbd ${priority} \
         --slave /usr/share/man/man1/orbd.1 orbd.1 /usr/java/${oracle_java::longversion}/man/man1/orbd.1;
        update-alternatives --install /usr/bin/pack200 pack200 /usr/java/${oracle_java::longversion}/bin/pack200 ${priority} \
         --slave /usr/share/man/man1/pack200.1 pack200.1 /usr/java/${oracle_java::longversion}/man/man1/pack200.1;
        update-alternatives --install /usr/bin/policytool policytool /usr/java/${oracle_java::longversion}/bin/policytool ${priority} \
         --slave /usr/share/man/man1/policytool.1 policytool.1 /usr/java/${oracle_java::longversion}/man/man1/policytool.1;
        update-alternatives --install /usr/bin/rmid rmid /usr/java/${oracle_java::longversion}/bin/rmid ${priority} \
         --slave /usr/share/man/man1/rmid.1 rmid.1 /usr/java/${oracle_java::longversion}/man/man1/rmid.1;
        update-alternatives --install /usr/bin/rmiregistry rmiregistry /usr/java/${oracle_java::longversion}/bin/rmiregistry ${priority} \
         --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 /usr/java/${oracle_java::longversion}/man/man1/rmiregistry.1;
        update-alternatives --install /usr/bin/servertool servertool /usr/java/${oracle_java::longversion}/bin/servertool ${priority} \
         --slave /usr/share/man/man1/servertool.1 servertool.1 /usr/java/${oracle_java::longversion}/man/man1/servertool.1;
        update-alternatives --install /usr/bin/tnameserv tnameserv /usr/java/${oracle_java::longversion}/bin/tnameserv ${priority} \
         --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 /usr/java/${oracle_java::longversion}/man/man1/tnameserv.1;
        update-alternatives --install /usr/bin/unpack200 unpack200 /usr/java/${oracle_java::longversion}/bin/unpack200 ${priority} \
         --slave /usr/share/man/man1/unpack200.1 unpack200.1 /usr/java/${oracle_java::longversion}/man/man1/unpack200.1;
        update-alternatives --install /usr/bin/appletviewer appletviewer /usr/java/${oracle_java::longversion}/bin/appletviewer ${priority} \
				 --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 /usr/java/${oracle_java::longversion}/man/man1/appletviewer.1;
				update-alternatives --install /usr/bin/extcheck extcheck /usr/java/${oracle_java::longversion}/bin/extcheck ${priority} \
				 --slave /usr/share/man/man1/extcheck.1 extcheck.1 /usr/java/${oracle_java::longversion}/man/man1/extcheck.1;
				update-alternatives --install /usr/bin/idlj idlj /usr/java/${oracle_java::longversion}/bin/idlj ${priority} \
				 --slave /usr/share/man/man1/idlj.1 idlj.1 /usr/java/${oracle_java::longversion}/man/man1/idlj.1;
				update-alternatives --install /usr/bin/jar jar /usr/java/${oracle_java::longversion}/bin/jar ${priority} \
				 --slave /usr/share/man/man1/jar.1 jar.1 /usr/java/${oracle_java::longversion}/man/man1/jar.1;
				update-alternatives --install /usr/bin/jarsigner jarsigner /usr/java/${oracle_java::longversion}/bin/jarsigner ${priority} \
				 --slave /usr/share/man/man1/jarsigner.1 jarsigner.1 /usr/java/${oracle_java::longversion}/man/man1/jarsigner.1;
				update-alternatives --install /usr/bin/javac javac /usr/java/${oracle_java::longversion}/bin/javac ${priority} \
				 --slave /usr/share/man/man1/javac.1 javac.1 /usr/java/${oracle_java::longversion}/man/man1/javac.1;
				update-alternatives --install /usr/bin/javadoc javadoc /usr/java/${oracle_java::longversion}/bin/javadoc ${priority} \
				 --slave /usr/share/man/man1/javadoc.1 javadoc.1 /usr/java/${oracle_java::longversion}/man/man1/javadoc.1;
				update-alternatives --install /usr/bin/javafxpackager javafxpackager /usr/java/${oracle_java::longversion}/bin/javafxpackager ${priority} \
				 --slave /usr/share/man/man1/javafxpackager.1 javafxpackager.1 /usr/java/${oracle_java::longversion}/man/man1/javafxpackager.1;
				update-alternatives --install /usr/bin/javah javah /usr/java/${oracle_java::longversion}/bin/javah ${priority} \
				 --slave /usr/share/man/man1/javah.1 javah.1 /usr/java/${oracle_java::longversion}/man/man1/javah.1;
				update-alternatives --install /usr/bin/javap javap /usr/java/${oracle_java::longversion}/bin/javap ${priority} \
				 --slave /usr/share/man/man1/javap.1 javap.1 /usr/java/${oracle_java::longversion}/man/man1/javap.1;
				update-alternatives --install /usr/bin/javapackager javapackager /usr/java/${oracle_java::longversion}/bin/javapackager ${priority} \
				 --slave /usr/share/man/man1/javapackager.1 javapackager.1 /usr/java/${oracle_java::longversion}/man/man1/javapackager.1;
				update-alternatives --install /usr/bin/java-rmi.cgi java-rmi.cgi /usr/java/${oracle_java::longversion}/bin/java-rmi.cgi ${priority} \
				update-alternatives --install /usr/bin/jcmd jcmd /usr/java/${oracle_java::longversion}/bin/jcmd ${priority} \
				 --slave /usr/share/man/man1/jcmd.1 jcmd.1 /usr/java/${oracle_java::longversion}/man/man1/jcmd.1;
				update-alternatives --install /usr/bin/jconsole jconsole /usr/java/${oracle_java::longversion}/bin/jconsole ${priority} \
				 --slave /usr/share/man/man1/jconsole.1 jconsole.1 /usr/java/${oracle_java::longversion}/man/man1/jconsole.1;
				update-alternatives --install /usr/bin/jdb jdb /usr/java/${oracle_java::longversion}/bin/jdb ${priority} \
				 --slave /usr/share/man/man1/jdb.1 jdb.1 /usr/java/${oracle_java::longversion}/man/man1/jdb.1;
				update-alternatives --install /usr/bin/jdeps jdeps /usr/java/${oracle_java::longversion}/bin/jdeps ${priority} \
				 --slave /usr/share/man/man1/jdeps.1 jdeps.1 /usr/java/${oracle_java::longversion}/man/man1/jdeps.1;
				update-alternatives --install /usr/bin/jhat jhat /usr/java/${oracle_java::longversion}/bin/jhat ${priority} \
				 --slave /usr/share/man/man1/jhat.1 jhat.1 /usr/java/${oracle_java::longversion}/man/man1/jhat.1;
				update-alternatives --install /usr/bin/jinfo jinfo /usr/java/${oracle_java::longversion}/bin/jinfo ${priority} \
				 --slave /usr/share/man/man1/jinfo.1 jinfo.1 /usr/java/${oracle_java::longversion}/man/man1/jinfo.1;
				update-alternatives --install /usr/bin/jmap jmap /usr/java/${oracle_java::longversion}/bin/jmap ${priority} \
				 --slave /usr/share/man/man1/jmap.1 jmap.1 /usr/java/${oracle_java::longversion}/man/man1/jmap.1;
				update-alternatives --install /usr/bin/jmc jmc /usr/java/${oracle_java::longversion}/bin/jmc ${priority} \
				 --slave /usr/share/man/man1/jmc.1 jmc.1 /usr/java/${oracle_java::longversion}/man/man1/jmc.1;
				update-alternatives --install /usr/bin/jps jps /usr/java/${oracle_java::longversion}/bin/jps ${priority} \
				 --slave /usr/share/man/man1/jps.1 jps.1 /usr/java/${oracle_java::longversion}/man/man1/jps.1;
				update-alternatives --install /usr/bin/jrunscript jrunscript /usr/java/${oracle_java::longversion}/bin/jrunscript ${priority} \
				 --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 /usr/java/${oracle_java::longversion}/man/man1/jrunscript.1;
				update-alternatives --install /usr/bin/jsadebugd jsadebugd /usr/java/${oracle_java::longversion}/bin/jsadebugd ${priority} \
				 --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 /usr/java/${oracle_java::longversion}/man/man1/jsadebugd.1;
				update-alternatives --install /usr/bin/jstack jstack /usr/java/${oracle_java::longversion}/bin/jstack ${priority} \
				 --slave /usr/share/man/man1/jstack.1 jstack.1 /usr/java/${oracle_java::longversion}/man/man1/jstack.1;
				update-alternatives --install /usr/bin/jstat jstat /usr/java/${oracle_java::longversion}/bin/jstat ${priority} \
				 --slave /usr/share/man/man1/jstat.1 jstat.1 /usr/java/${oracle_java::longversion}/man/man1/jstat.1;
				update-alternatives --install /usr/bin/jstatd jstatd /usr/java/${oracle_java::longversion}/bin/jstatd ${priority} \
				 --slave /usr/share/man/man1/jstatd.1 jstatd.1 /usr/java/${oracle_java::longversion}/man/man1/jstatd.1;
				update-alternatives --install /usr/bin/jvisualvm jvisualvm /usr/java/${oracle_java::longversion}/bin/jvisualvm ${priority} \
				 --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 /usr/java/${oracle_java::longversion}/man/man1/jvisualvm.1;
				update-alternatives --install /usr/bin/native2ascii native2ascii /usr/java/${oracle_java::longversion}/bin/native2ascii ${priority} \
				 --slave /usr/share/man/man1/native2ascii.1 native2ascii.1 /usr/java/${oracle_java::longversion}/man/man1/native2ascii.1;
				update-alternatives --install /usr/bin/rmic rmic /usr/java/${oracle_java::longversion}/bin/rmic ${priority} \
				 --slave /usr/share/man/man1/rmic.1 rmic.1 /usr/java/${oracle_java::longversion}/man/man1/rmic.1;
				update-alternatives --install /usr/bin/schemagen schemagen /usr/java/${oracle_java::longversion}/bin/schemagen ${priority} \
				 --slave /usr/share/man/man1/schemagen.1 schemagen.1 /usr/java/${oracle_java::longversion}/man/man1/schemagen.1;
				update-alternatives --install /usr/bin/serialver serialver /usr/java/${oracle_java::longversion}/bin/serialver ${priority} \
				 --slave /usr/share/man/man1/serialver.1 serialver.1 /usr/java/${oracle_java::longversion}/man/man1/serialver.1;
				update-alternatives --install /usr/bin/wsgen wsgen /usr/java/${oracle_java::longversion}/bin/wsgen ${priority} \
				 --slave /usr/share/man/man1/wsgen.1 wsgen.1 /usr/java/${oracle_java::longversion}/man/man1/wsgen.1;
				update-alternatives --install /usr/bin/wsimport wsimport /usr/java/${oracle_java::longversion}/bin/wsimport ${priority} \
				 --slave /usr/share/man/man1/wsimport.1 wsimport.1 /usr/java/${oracle_java::longversion}/man/man1/wsimport.1;
				update-alternatives --install /usr/bin/xjc xjc /usr/java/${oracle_java::longversion}/bin/xjc ${priority} \
				 --slave /usr/share/man/man1/xjc.1 xjc.1 /usr/java/${oracle_java::longversion}/man/man1/xjc.1"
      }
    }
    default : {
      exec { 'add java alternative':
        command => "update-alternatives --install /usr/bin/java java /usr/java/${oracle_java::longversion}/bin/java ${priority} \
				 --slave /usr/share/man/man1/java.1 java.1 /usr/java/${oracle_java::longversion}/man/man1/java.1;
				update-alternatives --install /usr/bin/javaws javaws /usr/java/${oracle_java::longversion}/bin/javaws ${priority} \
				 --slave /usr/share/man/man1/javaws.1 javaws.1 /usr/java/${oracle_java::longversion}/man/man1/javaws.1;
				update-alternatives --install /usr/bin/jcontrol jcontrol /usr/java/${oracle_java::longversion}/bin/jcontrol ${priority};
				update-alternatives --install /usr/bin/jjs jjs /usr/java/${oracle_java::longversion}/bin/jjs${priority} \
				 --slave /usr/share/man/man1/jjs.1 jjs.1 /usr/java/${oracle_java::longversion}/man/man1/jjs.1;
				update-alternatives --install /usr/bin/keytool keytool /usr/java/${oracle_java::longversion}/bin/keytool ${priority} \
				 --slave /usr/share/man/man1/keytool.1 keytool.1 /usr/java/${oracle_java::longversion}/man/man1/keytool.1;
				update-alternatives --install /usr/bin/orbd orbd /usr/java/${oracle_java::longversion}/bin/orbd ${priority} \
				 --slave /usr/share/man/man1/orbd.1 orbd.1 /usr/java/${oracle_java::longversion}/man/man1/orbd.1;
				update-alternatives --install /usr/bin/pack200 pack200 /usr/java/${oracle_java::longversion}/bin/pack200 ${priority} \
				 --slave /usr/share/man/man1/pack200.1 pack200.1 /usr/java/${oracle_java::longversion}/man/man1/pack200.1;
				update-alternatives --install /usr/bin/policytool policytool /usr/java/${oracle_java::longversion}/bin/policytool ${priority} \
				 --slave /usr/share/man/man1/policytool.1 policytool.1 /usr/java/${oracle_java::longversion}/man/man1/policytool.1;
				update-alternatives --install /usr/bin/rmid rmid /usr/java/${oracle_java::longversion}/bin/rmid ${priority} \
				 --slave /usr/share/man/man1/rmid.1 rmid.1 /usr/java/${oracle_java::longversion}/man/man1/rmid.1;
				update-alternatives --install /usr/bin/rmiregistry rmiregistry /usr/java/${oracle_java::longversion}/bin/rmiregistry ${priority} \
				 --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 /usr/java/${oracle_java::longversion}/man/man1/rmiregistry.1;
				update-alternatives --install /usr/bin/servertool servertool /usr/java/${oracle_java::longversion}/bin/servertool ${priority} \
				 --slave /usr/share/man/man1/servertool.1 servertool.1 /usr/java/${oracle_java::longversion}/man/man1/servertool.1;
				update-alternatives --install /usr/bin/tnameserv tnameserv /usr/java/${oracle_java::longversion}/bin/tnameserv ${priority} \
				 --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 /usr/java/${oracle_java::longversion}/man/man1/tnameserv.1;
				update-alternatives --install /usr/bin/unpack200 unpack200 /usr/java/${oracle_java::longversion}/bin/unpack200 ${priority} \
				 --slave /usr/share/man/man1/unpack200.1 unpack200.1 /usr/java/${oracle_java::longversion}/man/man1/unpack200.1"
      }
    }
  }
}