class hadoop::hdfs::packages(
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
