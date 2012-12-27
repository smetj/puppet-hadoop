# Controls the Hadoop Services.
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

class hadoop::service::hdfs(
  $namenode    = false,
  $datanode    = false,
  $secondarynamenode = false){
  if $namenode == true {
    service { "hadoop-0.20-namenode":
      ensure => "running"
    }
  }
  else{
    service { "hadoop-0.20-namenode":
      ensure => "stopped"
    }
  }
  if $secondarynamenode == true {
    service { "hadoop-0.20-secondarynamenode":
      ensure => "running"
    }
  }
  else{
    service { "hadoop-0.20-secondarynamenode":
      ensure => "stopped"
    }
  }
  if $datanode == true {
    service { "hadoop-0.20-datanode":
      ensure => "running"
    }
  }
  else{
    service { "hadoop-0.20-datanode":
      ensure => "stopped"
    }
  }
}
class hadoop::service::secondarynamenode(){
  notice("This has not been implemented yet.")
}
class hadoop::service::datanode(){
  notice("This has not been implemented yet.")
}
class hadoop::service::jobtracker(){
  notice("This has not been implemented yet.")
}
class hadoop::service::tasktracker(){
  notice("This has not been implemented yet.")
}
class hadoop::service::hbasemaster(){
  notice("This has not been implemented yet.")
}
class hadoop::service::regionserver(){
  notice("This has not been implemented yet.")
}
class hadoop::service::zookeeper(){
  notice("This has not been implemented yet.")
}
