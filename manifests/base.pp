class hadoop::base(
  $metricfactory="localhost:8649",
  $java_home              ="/usr/java/default",
  $heapsize               =4000,
  $namenode_opts          ='-Xmx4000m -Dcom.sun.management.jmxremote $HADOOP_NAMENODE_OPTS',
  $secondarynamenode_opts ='-Dcom.sun.management.jmxremote $HADOOP_SECONDARYNAMENODE_OPTS',
  $datanode_opts          ='-Dcom.sun.management.jmxremote $HADOOP_DATANODE_OPTS',
  $balancer_opts          ='-Dcom.sun.management.jmxremote $HADOOP_BALANCER_OPTS',
  $jobtracker_opts        ='-Xmx4000m -Dcom.sun.management.jmxremote $HADOOP_JOBTRACKER_OPTS',
  $tasktracker_opts       ='-Dcom.sun.management.jmxremote $HADOOP_TASKTRACKER_OPTS',
  $volumes                = ["/var/tmp/1"],
  $logging_id             ="HadoopCluster",
  $logging_server         ="someserver",
  $logging_threshold      ="WARN"){
  
  class { "hadoop::base::packages":
  }
  class { "hadoop::base::config":
    metricfactory           => $metricfactory,
    java_home               => $java_home,
    heapsize                => $heapsize,
    namenode_opts           => $namenode_opts,
    secondarynamenode_opts  => $secondarynamenode_opts,
    datanode_opts           => $datanode_opts,
    balancer_opts           => $balancer_opts,
    jobtracker_opts         => $jobtracker_opts,
    tasktracker_opts        => $tasktracker_opts,
    volumes                 => $volumes,
    logging_id              => $logging_id,
    logging_server          => $ogging_server,
    logging_threshold       => $logging_threshold
  }
  Class["hadoop::base::packages"] -> Class["hadoop::base::config"]
}
