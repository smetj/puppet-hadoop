class hadoop::base::config(
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
  
  class createvolumes(
    $volumes=[]){
    exec { "delete_answer_file":
      command   =>  "/bin/rm /tmp/namenode_format_answers",
      onlyif    =>  "/usr/bin/test -f /tmp/namenode_format_answers"
    }
      
    define buildtree(){
      exec { $name:
        command   =>  "/bin/echo Y >> /tmp/namenode_format_answers",
        unless    =>  "/usr/bin/test -f $name/dfs/nn/current/VERSION"
      }
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
    Exec [ "delete_answer_file"] -> Buildtree [ $volumes ]
  }
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
  file { "hadoop_topology.sh":
    path    => "/etc/hadoop/conf/hadoop_topology.sh",
    owner   => root,
    group   => root,
    mode    => 755,
    content => template("${module_name}/etc/hadoop/conf/hadoop_topology.sh.erb"),
  }
  file { "topology.data":
    path    => "/etc/hadoop/conf/topology.data",
    owner   => root,
    group   => root,
    mode    => 755,
    content => template("${module_name}/etc/hadoop/conf/topology.data.erb"),
  }
  class { "createvolumes":
    volumes       => $volumes
  }
  File [ "hadoop-env.sh" ] -> File [ "hadoop-metrics.properties" ] -> File [ "log4j.properties" ] -> Class [ "createvolumes"] 
}
