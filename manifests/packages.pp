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


class hadoop::packages( $role ){
  class { "hadoop::packages::base": }
  class { "hadoop::packages::$role": }
}

class hadoop::packages::base(){
  yumrepo { "cloudera":
    name => "cloudera-cdh3",
    baseurl => "",
    mirrorlist => "http://archive.cloudera.com/redhat/6/x86_64/cdh/3/mirrors",
    enabled => 1,
    gpgcheck => 1,
    gpgkey => "http://archive.cloudera.com/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera"
  }
  package { "jdk":
    ensure => "latest",
    provider => "yum",
    require => Yumrepo['cloudera']
  }
  package { "hadoop-0.20":
    ensure => "latest",
    provider => "yum",
    require => Yumrepo['cloudera']
  }
  notify {'Hadoop base installed.':
    require => Package["hadoop-0.20"]
  }
}
class hadoop::packages::hdfs(
  $namenode = false,
  $datanode = false,
  $secondarynamenode = false){
  if $namenode == true {
    package { "hadoop-0.20-namenode":
      ensure => "installed",
      provider => "yum"
    }
  }
  else {
    package { "hadoop-0.20-namenode":
      ensure => "absent",
      provider => "yum"
    }
  }
  if $secondarynamenode == true {
    package { "hadoop-0.20-secondarynamenode":
      ensure => "installed",
      provider => "yum"
    }
  }
  else {
    package { "hadoop-0.20-secondarynamenode":
      ensure => "absent",
      provider => "yum"
    }
  }
  if $datanode == true {
    package { "hadoop-0.20-datanode":
      ensure => "installed",
      provider => "yum"
    }
  }
  else {
    package { "hadoop-0.20-datanode":
      ensure => "absent",
      provider => "yum"
    }
  }
}

class hadoop::packages::jobtracker(){
  package { "hadoop-0.20-jobtracker":
    ensure => "installed",
    provider => "yum"
  }
}
class hadoop::packages::tasktracker(){
  package { "hadoop-0.20-tasktracker":
    ensure => "installed",
    provider => "yum"
  }
}
class hadoop::packages::hbasemaster(){
  package { "hadoop-0.20-hbasemaster":
    ensure => "installed",
    provider => "yum"
  }
}
class hadoop::packages::regionserver(){
  package { "hadoop-0.20-namenode":
    ensure => "installed",
    provider => "yum"
  }
}
class hadoop::packages::zookeeper(){
  package { "hadoop-0.20-zookeeper":
    ensure => "installed",
    provider => "yum"
  }
}
