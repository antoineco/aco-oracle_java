# == Class: oracle_java::alternative::rpm
#
# This class adds Oracle Java to the list of java alternatives on RPM distributions
#
class oracle_java::alternative::rpm {
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
				 --slave /usr/bin/appletviewer appletviewer /usr/java/${oracle_java::longversion}/bin/appletviewer \
				 --slave /usr/bin/extcheck extcheck /usr/java/${oracle_java::longversion}/bin/extcheck \
				 --slave /usr/bin/idlj idlj /usr/java/${oracle_java::longversion}/bin/idlj \
				 --slave /usr/bin/jar jar /usr/java/${oracle_java::longversion}/bin/jar \
				 --slave /usr/bin/jarsigner jarsigner /usr/java/${oracle_java::longversion}/bin/jarsigner \
				 --slave /usr/bin/javac javac /usr/java/${oracle_java::longversion}/bin/javac \
				 --slave /usr/bin/javadoc javadoc /usr/java/${oracle_java::longversion}/bin/javadoc \
				 --slave /usr/bin/javafxpackager javafxpackager /usr/java/${oracle_java::longversion}/bin/javafxpackager \
				 --slave /usr/bin/javah javah /usr/java/${oracle_java::longversion}/bin/javah \
				 --slave /usr/bin/javap javap /usr/java/${oracle_java::longversion}/bin/javap \
				 --slave /usr/bin/javapackager javapackager /usr/java/${oracle_java::longversion}/bin/javapackager \
				 --slave /usr/bin/java-rmi.cgi java-rmi.cgi /usr/java/${oracle_java::longversion}/bin/java-rmi.cgi \
				 --slave /usr/bin/javaws javaws /usr/java/${oracle_java::longversion}/bin/javaws \
				 --slave /usr/bin/jcmd jcmd /usr/java/${oracle_java::longversion}/bin/jcmd \
				 --slave /usr/bin/jconsole jconsole /usr/java/${oracle_java::longversion}/bin/jconsole \
				 --slave /usr/bin/jcontrol jcontrol /usr/java/${oracle_java::longversion}/bin/jcontrol \
				 --slave /usr/bin/jdb jdb /usr/java/${oracle_java::longversion}/bin/jdb \
				 --slave /usr/bin/jdeps jdeps /usr/java/${oracle_java::longversion}/bin/jdeps \
				 --slave /usr/bin/jhat jhat /usr/java/${oracle_java::longversion}/bin/jhat \
				 --slave /usr/bin/jinfo jinfo /usr/java/${oracle_java::longversion}/bin/jinfo \
				 --slave /usr/bin/jjs jjs /usr/java/${oracle_java::longversion}/bin/jjs \
				 --slave /usr/bin/jmap jmap /usr/java/${oracle_java::longversion}/bin/jmap \
				 --slave /usr/bin/jmc jmc /usr/java/${oracle_java::longversion}/bin/jmc \
				 --slave /usr/bin/jps jps /usr/java/${oracle_java::longversion}/bin/jps \
				 --slave /usr/bin/jrunscript jrunscript /usr/java/${oracle_java::longversion}/bin/jrunscript \
				 --slave /usr/bin/jsadebugd jsadebugd /usr/java/${oracle_java::longversion}/bin/jsadebugd \
				 --slave /usr/bin/jstack jstack /usr/java/${oracle_java::longversion}/bin/jstack \
				 --slave /usr/bin/jstat jstat /usr/java/${oracle_java::longversion}/bin/jstat \
				 --slave /usr/bin/jstatd jstatd /usr/java/${oracle_java::longversion}/bin/jstatd \
				 --slave /usr/bin/jvisualvm jvisualvm /usr/java/${oracle_java::longversion}/bin/jvisualvm \
				 --slave /usr/bin/keytool keytool /usr/java/${oracle_java::longversion}/bin/keytool \
				 --slave /usr/bin/native2ascii native2ascii /usr/java/${oracle_java::longversion}/bin/native2ascii \
				 --slave /usr/bin/orbd orbd /usr/java/${oracle_java::longversion}/bin/orbd \
				 --slave /usr/bin/pack200 pack200 /usr/java/${oracle_java::longversion}/bin/pack200 \
				 --slave /usr/bin/policytool policytool /usr/java/${oracle_java::longversion}/bin/policytool \
				 --slave /usr/bin/rmic rmic /usr/java/${oracle_java::longversion}/bin/rmic \
				 --slave /usr/bin/rmid rmid /usr/java/${oracle_java::longversion}/bin/rmid \
				 --slave /usr/bin/rmiregistry rmiregistry /usr/java/${oracle_java::longversion}/bin/rmiregistry \
				 --slave /usr/bin/schemagen schemagen /usr/java/${oracle_java::longversion}/bin/schemagen \
				 --slave /usr/bin/serialver serialver /usr/java/${oracle_java::longversion}/bin/serialver \
				 --slave /usr/bin/servertool servertool /usr/java/${oracle_java::longversion}/bin/servertool \
				 --slave /usr/bin/tnameserv tnameserv /usr/java/${oracle_java::longversion}/bin/tnameserv \
				 --slave /usr/bin/unpack200 unpack200 /usr/java/${oracle_java::longversion}/bin/unpack200 \
				 --slave /usr/bin/wsgen wsgen /usr/java/${oracle_java::longversion}/bin/wsgen \
				 --slave /usr/bin/wsimport wsimport /usr/java/${oracle_java::longversion}/bin/wsimport \
				 --slave /usr/bin/xjc xjc /usr/java/${oracle_java::longversion}/bin/xjc \
				 --slave /usr/share/man/man1/appletviewer.1 appletviewer.1 /usr/java/${oracle_java::longversion}/man/man1/appletviewer.1 \
				 --slave /usr/share/man/man1/extcheck.1 extcheck.1 /usr/java/${oracle_java::longversion}/man/man1/extcheck.1 \
				 --slave /usr/share/man/man1/idlj.1 idlj.1 /usr/java/${oracle_java::longversion}/man/man1/idlj.1 \
				 --slave /usr/share/man/man1/jar.1 jar.1 /usr/java/${oracle_java::longversion}/man/man1/jar.1 \
				 --slave /usr/share/man/man1/jarsigner.1 jarsigner.1 /usr/java/${oracle_java::longversion}/man/man1/jarsigner.1 \
				 --slave /usr/share/man/man1/java.1 java.1 /usr/java/${oracle_java::longversion}/man/man1/java.1 \
				 --slave /usr/share/man/man1/javac.1 javac.1 /usr/java/${oracle_java::longversion}/man/man1/javac.1 \
				 --slave /usr/share/man/man1/javadoc.1 javadoc.1 /usr/java/${oracle_java::longversion}/man/man1/javadoc.1 \
				 --slave /usr/share/man/man1/javafxpackager.1 javafxpackager.1 /usr/java/${oracle_java::longversion}/man/man1/javafxpackager.1 \
				 --slave /usr/share/man/man1/javah.1 javah.1 /usr/java/${oracle_java::longversion}/man/man1/javah.1 \
				 --slave /usr/share/man/man1/javap.1 javap.1 /usr/java/${oracle_java::longversion}/man/man1/javap.1 \
				 --slave /usr/share/man/man1/javapackager.1 javapackager.1 /usr/java/${oracle_java::longversion}/man/man1/javapackager.1 \
				 --slave /usr/share/man/man1/javaws.1 javaws.1 /usr/java/${oracle_java::longversion}/man/man1/javaws.1 \
				 --slave /usr/share/man/man1/jcmd.1 jcmd.1 /usr/java/${oracle_java::longversion}/man/man1/jcmd.1 \
				 --slave /usr/share/man/man1/jconsole.1 jconsole.1 /usr/java/${oracle_java::longversion}/man/man1/jconsole.1 \
				 --slave /usr/share/man/man1/jdb.1 jdb.1 /usr/java/${oracle_java::longversion}/man/man1/jdb.1 \
				 --slave /usr/share/man/man1/jdeps.1 jdeps.1 /usr/java/${oracle_java::longversion}/man/man1/jdeps.1 \
				 --slave /usr/share/man/man1/jhat.1 jhat.1 /usr/java/${oracle_java::longversion}/man/man1/jhat.1 \
				 --slave /usr/share/man/man1/jinfo.1 jinfo.1 /usr/java/${oracle_java::longversion}/man/man1/jinfo.1 \
				 --slave /usr/share/man/man1/jjs.1 jjs.1 /usr/java/${oracle_java::longversion}/man/man1/jjs.1 \
				 --slave /usr/share/man/man1/jmap.1 jmap.1 /usr/java/${oracle_java::longversion}/man/man1/jmap.1 \
				 --slave /usr/share/man/man1/jmc.1 jmc.1 /usr/java/${oracle_java::longversion}/man/man1/jmc.1 \
				 --slave /usr/share/man/man1/jps.1 jps.1 /usr/java/${oracle_java::longversion}/man/man1/jps.1 \
				 --slave /usr/share/man/man1/jrunscript.1 jrunscript.1 /usr/java/${oracle_java::longversion}/man/man1/jrunscript.1 \
				 --slave /usr/share/man/man1/jsadebugd.1 jsadebugd.1 /usr/java/${oracle_java::longversion}/man/man1/jsadebugd.1 \
				 --slave /usr/share/man/man1/jstack.1 jstack.1 /usr/java/${oracle_java::longversion}/man/man1/jstack.1 \
				 --slave /usr/share/man/man1/jstat.1 jstat.1 /usr/java/${oracle_java::longversion}/man/man1/jstat.1 \
				 --slave /usr/share/man/man1/jstatd.1 jstatd.1 /usr/java/${oracle_java::longversion}/man/man1/jstatd.1 \
				 --slave /usr/share/man/man1/jvisualvm.1 jvisualvm.1 /usr/java/${oracle_java::longversion}/man/man1/jvisualvm.1 \
				 --slave /usr/share/man/man1/keytool.1 keytool.1 /usr/java/${oracle_java::longversion}/man/man1/keytool.1 \
				 --slave /usr/share/man/man1/native2ascii.1 native2ascii.1 /usr/java/${oracle_java::longversion}/man/man1/native2ascii.1 \
				 --slave /usr/share/man/man1/orbd.1 orbd.1 /usr/java/${oracle_java::longversion}/man/man1/orbd.1 \
				 --slave /usr/share/man/man1/pack200.1 pack200.1 /usr/java/${oracle_java::longversion}/man/man1/pack200.1 \
				 --slave /usr/share/man/man1/policytool.1 policytool.1 /usr/java/${oracle_java::longversion}/man/man1/policytool.1 \
				 --slave /usr/share/man/man1/rmic.1 rmic.1 /usr/java/${oracle_java::longversion}/man/man1/rmic.1 \
				 --slave /usr/share/man/man1/rmid.1 rmid.1 /usr/java/${oracle_java::longversion}/man/man1/rmid.1 \
				 --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 /usr/java/${oracle_java::longversion}/man/man1/rmiregistry.1 \
				 --slave /usr/share/man/man1/schemagen.1 schemagen.1 /usr/java/${oracle_java::longversion}/man/man1/schemagen.1 \
				 --slave /usr/share/man/man1/serialver.1 serialver.1 /usr/java/${oracle_java::longversion}/man/man1/serialver.1 \
				 --slave /usr/share/man/man1/servertool.1 servertool.1 /usr/java/${oracle_java::longversion}/man/man1/servertool.1 \
				 --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 /usr/java/${oracle_java::longversion}/man/man1/tnameserv.1 \
				 --slave /usr/share/man/man1/unpack200.1 unpack200.1 /usr/java/${oracle_java::longversion}/man/man1/unpack200.1 \
				 --slave /usr/share/man/man1/wsgen.1 wsgen.1 /usr/java/${oracle_java::longversion}/man/man1/wsgen.1 \
				 --slave /usr/share/man/man1/wsimport.1 wsimport.1 /usr/java/${oracle_java::longversion}/man/man1/wsimport.1 \
				 --slave /usr/share/man/man1/xjc.1 xjc.1 /usr/java/${oracle_java::longversion}/man/man1/xjc.1"
      }
    }
    default : {
      exec { 'add java alternative':
        command => "update-alternatives --install /usr/bin/java java /usr/java/${oracle_java::longversion}/bin/java ${priority} \
		     --slave /usr/bin/javaws javaws /usr/java/${oracle_java::longversion}/bin/javaws \
		     --slave /usr/bin/jcontrol jcontrol /usr/java/${oracle_java::longversion}/bin/jcontrol \
		     --slave /usr/bin/jjs jjs /usr/java/${oracle_java::longversion}/bin/jjs \
		     --slave /usr/bin/keytool keytool /usr/java/${oracle_java::longversion}/bin/keytool \
		     --slave /usr/bin/orbd orbd /usr/java/${oracle_java::longversion}/bin/orbd \
		     --slave /usr/bin/pack200 pack200 /usr/java/${oracle_java::longversion}/bin/pack200 \
		     --slave /usr/bin/policytool policytool /usr/java/${oracle_java::longversion}/bin/policytool \
		     --slave /usr/bin/rmid rmid /usr/java/${oracle_java::longversion}/bin/rmid \
		     --slave /usr/bin/rmiregistry rmiregistry /usr/java/${oracle_java::longversion}/bin/rmiregistry \
		     --slave /usr/bin/servertool servertool /usr/java/${oracle_java::longversion}/bin/servertool \
		     --slave /usr/bin/tnameserv tnameserv /usr/java/${oracle_java::longversion}/bin/tnameserv \
		     --slave /usr/bin/unpack200 unpack200 /usr/java/${oracle_java::longversion}/bin/unpack200 \
		     --slave /usr/share/man/man1/java.1 java.1 /usr/java/${oracle_java::longversion}/man/man1/java.1 \
		     --slave /usr/share/man/man1/javaws.1 javaws.1 /usr/java/${oracle_java::longversion}/man/man1/javaws.1 \
		     --slave /usr/share/man/man1/jjs.1 jjs.1 /usr/java/${oracle_java::longversion}/man/man1/jjs.1 \
		     --slave /usr/share/man/man1/keytool.1 keytool.1 /usr/java/${oracle_java::longversion}/man/man1/keytool.1 \
		     --slave /usr/share/man/man1/orbd.1 orbd.1 /usr/java/${oracle_java::longversion}/man/man1/orbd.1 \
		     --slave /usr/share/man/man1/pack200.1 pack200.1 /usr/java/${oracle_java::longversion}/man/man1/pack200.1 \
		     --slave /usr/share/man/man1/policytool.1 policytool.1 /usr/java/${oracle_java::longversion}/man/man1/policytool.1 \
		     --slave /usr/share/man/man1/rmid.1 rmid.1 /usr/java/${oracle_java::longversion}/man/man1/rmid.1 \
		     --slave /usr/share/man/man1/rmiregistry.1 rmiregistry.1 /usr/java/${oracle_java::longversion}/man/man1/rmiregistry.1 \
		     --slave /usr/share/man/man1/servertool.1 servertool.1 /usr/java/${oracle_java::longversion}/man/man1/servertool.1 \
		     --slave /usr/share/man/man1/tnameserv.1 tnameserv.1 /usr/java/${oracle_java::longversion}/man/man1/tnameserv.1 \
		     --slave /usr/share/man/man1/unpack200.1 unpack200.1 /usr/java/${oracle_java::longversion}/man/man1/unpack200.1"
      }
    }
  }
}