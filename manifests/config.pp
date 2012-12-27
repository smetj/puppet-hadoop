# Configures the Hadoop role.
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

class hadoop::config::base(
    $metricfactory="localhost:8649",
    $java_home=undef,
    $heapsize=undef,
    $namenode_opts=undef,
    $secondarynamenode_opts=undef,
    $datanode_opts=undef,
    $balancer_opts=undef,
    $jobtracker_opts=undef,
    $tasktracker_opts=undef,
    $volumes=[],
    $logging_id=undef,
    $logging_server=undef,
    $logging_threshold=undef){
  
  # Build basic config files
  ##########################
  file { "hadoop-env.sh":
    path    => "/etc/hadoop/conf/hadoop-env.sh",
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/hadoop/conf/hadoop-env.sh.erb"),
  }
  file { "hadoop-metrics.properties":
    path    => "/etc/hadoop/conf/hadoop-metrics.properties",
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/hadoop/conf/hadoop-metrics.properties.erb"),
  }
  file { "log4j.properties":
    path    => "/etc/hadoop/conf/log4j.properties",
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/hadoop/conf/log4j.properties.erb"),
  }
  # Create the Hadoop directory tree for each volume
  ##################################################
  class { "hadoop::config::base::createvolumes":
    volumes       => $volumes
  }
  notify { "Created directory tree.":
    require => Class [ "hadoop::config::base::createvolumes" ]
  }
}

class hadoop::config::hdfs(
  $fs_default_name=undef,
  $tmp_dir=undef,
  $logfile_size=undef,
  $logfile_count=undef,
  $topology_script_file_name=undef,
  $dfs_replication=undef,
  $dfs_permissions=undef,
  $dfs_datanode_du_reserved=undef,
  $dfs_datanode_du_pct=undef,
  $dfs_datanode_max_xcievers=undef,
  $dfs_balance_bandwidthPerSec=undef,
  $volumes=[],
  $namenode=false,
  $datanode=false,
  $secondarynamenode=false
  ){
  $dfs_data_dir       = regsubst($volumes, '(.*)', "\\1/dfs/dn")
  $dfs_name_dir       = regsubst($volumes, '(.*)', "\\1/dfs/nn")
  $fs_checkpoint_dir  = regsubst($volumes, '(.*)', "\\1/dfs/snn")
  
  file { "core-site.xml":
    path    => "/etc/hadoop/conf/core-site.xml",
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/hadoop/conf/core-site.xml.erb"),
  }
  file { "hdfs-site.xml":
    path    => "/etc/hadoop/conf/hdfs-site.xml",
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/hadoop/conf/hdfs-site.xml.erb")
  }
  
  class format_namenode(){
    if $hadoop::config::hdfs::namenode == true {
      notice ("A namenode, going to format.")
      exec { "format":
        command => "/usr/bin/hadoop namenode -format < /tmp/namenode_format_answers",
        user    => "hdfs",
        unless  => "/etc/init.d/hadoop-0.20-namenode status"
        #unless  => "echo $hadoop::config::hdfs::dfs_name_dir > /tmp/kaka "
      }
    }
    else {
      notice ("Not a namenode, not going to format.")
    }
  }
  
  class {"format_namenode":}
  
  Class [ "format_namenode"] -> File ["hdfs-site.xml"] -> File ["core-site.xml"]
}
class hadoop::config::secondarynamenode(){
  notice("This has not been implemented yet.")
}
class hadoop::config::datanode(){
  notice("This has not been implemented yet.")
}
class hadoop::config::jobtracker(){
  notice("This has not been implemented yet.")
}
class hadoop::config::tasktracker(){
  notice("This has not been implemented yet.")
}
class hadoop::config::hbasemaster(){
  notice("This has not been implemented yet.")
}
class hadoop::config::regionserver(){
  notice("This has not been implemented yet.")
}
class hadoop::config::zookeeper(){
  notice("This has not been implemented yet.")
}
  
class hadoop::config::base::createvolumes(
  $volumes=[]){
  
  exec { "namenode_format_answers":
    command   =>  "/bin/echo Y >> /tmp/namenode_format_answers"
  }
    
  define buildtree(){
    file { "$name/dfs":
      owner   =>  "hdfs",
      group   =>  "hadoop",
      mode    =>  644,
      ensure  =>  "directory"
    }
    file { "$name/dfs/nn":
      owner   =>  "hdfs",
      group   =>  "hadoop",
      mode    =>  644,
      ensure  =>  "directory",
      require =>  File [ "$name/dfs" ]
    }
    file { "$name/dfs/snn":
      owner   =>  "hdfs",
      group   =>  "hadoop",
      mode    =>  644,
      ensure  =>  "directory",
      require =>  File [ "$name/dfs" ]
    }
    file { "$name/dfs/dn":
      owner   =>  "hdfs",
      group   =>  "hadoop",
      mode    =>  0700,
      ensure  =>  "directory",
      require =>  File [ "$name/dfs" ]
    }
    file { "$name/mapred":
      owner   =>  "mapred",
      group   =>  "hadoop",
      mode    =>  644,
      ensure  =>  "directory",
    }
  }
  buildtree { $volumes:
  }    
}
