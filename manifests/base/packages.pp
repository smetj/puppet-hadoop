# Installs packages required for the Hadoop role.
#
# == Parameters
#
# role: Determines the role
#
# == Variables
#
# None
#
# == Examples
#
# None
#
# == Authors
#
# Jelle Smet <development@smetj.net> 
#
#

class hadoop::base::packages(){
  yumrepo { "cloudera":
    name => "cloudera-cdh3",
    baseurl => "",
    mirrorlist => "http://archive.cloudera.com/redhat/6/x86_64/cdh/3/mirrors",
    enabled => 1,
    gpgcheck => 1,
    gpgkey => "http://archive.cloudera.com/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera"
  }
  package { "java-1.7.0-openjdk":
    ensure => "latest",
    provider => "yum",
  }
  package { "hadoop-0.20":
    ensure => "latest",
    provider => "yum",
    require => Yumrepo['cloudera']
  }
}
