# Install and manage Hadoop
#
# == Parameters
#
# role (string)   - Defines the role of the Hadoop instance.
#                   Valid entries would be:
#                     namenode
#                     secondarynamenode
#                     datanode
#                     jobtracker
#                     tasktracker
#                     hbasemaster
#                     regionserver
#                     zookeeper
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
class hadoop(
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
  
    class { "hadoop::packages::base":
    }
    class { "hadoop::config::base":
      metricfactory           => $hadoop::metricfactory,
      java_home               => $hadoop::java_home,
      heapsize                => $hadoop::heapsize,
      namenode_opts           => $hadoop::namenode_opts,
      secondarynamenode_opts  => $hadoop::secondarynamenode_opts,
      datanode_opts           => $hadoop::datanode_opts,
      balancer_opts           => $hadoop::balancer_opts,
      jobtracker_opts         => $hadoop::jobtracker_opts,
      tasktracker_opts        => $hadoop::tasktracker_opts,
      volumes                 => $hadoop::volumes,
      logging_id              => $hadoop::logging_id,
      logging_server          => $hadoop::logging_server,
      logging_threshold       => $hadoop::logging_threshold
    }
    Class["hadoop::packages::base"] -> Class["hadoop::config::base"]
}

class hadoop::hdfs(
    $fs_default_name=$hostname,
    $tmp_dir="/tmp/hadoop",
    $logfile_size="2000000",
    $logfile_count="7",
    $topology_script_file_name="/etc/hadoop/conf/hadoop_topology.sh",
    $dfs_replication="3",
    $dfs_permissions="false",
    $dfs_datanode_du_reserved="10000000000",
    $dfs_datanode_du_pct="0.9f",
    $dfs_datanode_max_xcievers="4096",
    $dfs_balance_bandwidthPerSec="104857600",
    $volumes=[],
    $namenode=false,
    $datanode=false,
    $secondarynamenode=false){

  class { "hadoop::packages::hdfs":
    namenode                => $hadoop::hdfs::namenode,
    datanode                => $hadoop::hdfs::datanode,
    secondarynamenode       => $hadoop::hdfs::secondarynamenode
  }

  class { "hadoop::config::hdfs":
    fs_default_name              => $fs_default_name,
    tmp_dir                      => $tmp_dir,
    logfile_size                 => $logfile_size,
    logfile_count                => $logfile_count,
    topology_script_file_name    => $topology_script_file_name,
    dfs_replication              => $dfs_replication,
    dfs_permissions              => $dfs_permissions,
    dfs_datanode_du_reserved     => $dfs_datanode_du_reserved,
    dfs_datanode_du_pct          => $dfs_datanode_du_pct,
    dfs_datanode_max_xcievers    => $dfs_datanode_max_xcievers,
    dfs_balance_bandwidthPerSec  => $dfs_balance_bandwidthPerSec,
    volumes                      => $volumes,
    namenode                     => $namenode,
    datanode                     => $datanode,
    secondarynamenode            => $secondarynamenode
  }

  class { "hadoop::service::hdfs":
    namenode                     => $namenode,
    datanode                     => $datanode,
    secondarynamenode            => $secondarynamenode
  }
  
  Class["hadoop::packages::hdfs"] -> Class["hadoop::config::hdfs"] -> Class ["hadoop::service::hdfs"]
}
