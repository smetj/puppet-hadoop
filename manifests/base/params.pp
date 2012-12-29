class hadoop::base::params {
  $metricfactory          = "localhost:8649"
  $java_home              = "/usr/java/default"
  $heapsize               = 4000
  $namenode_opts          = '-Xmx4000m -Dcom.sun.management.jmxremote $HADOOP_NAMENODE_OPTS'
  $secondarynamenode_opts = '-Dcom.sun.management.jmxremote $HADOOP_SECONDARYNAMENODE_OPTS'
  $datanode_opts          = '-Dcom.sun.management.jmxremote $HADOOP_DATANODE_OPTS'
  $balancer_opts          = '-Dcom.sun.management.jmxremote $HADOOP_BALANCER_OPTS'
  $jobtracker_opts        = '-Xmx4000m -Dcom.sun.management.jmxremote $HADOOP_JOBTRACKER_OPTS'
  $tasktracker_opts       = '-Dcom.sun.management.jmxremote $HADOOP_TASKTRACKER_OPTS'
  $volumes                = ["/var/tmp/1"]
  $logging_id             = "HadoopCluster"
  $logging_server         = "someserver"
  $logging_threshold      = "WARN"
}
