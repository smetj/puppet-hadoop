class hadoop::hdfs::service(
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
