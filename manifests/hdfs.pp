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
    class { "hadoop::hdfs::packages":
      namenode                => $namenode,
      datanode                => $datanode,
      secondarynamenode       => $secondarynamenode
    }
    class { "hadoop::hdfs::config":
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

    class { "hadoop::hdfs::service":
      namenode                     => $namenode,
      datanode                     => $datanode,
      secondarynamenode            => $secondarynamenode
    }
  
    Class["hadoop::hdfs::packages"] -> Class["hadoop::hdfs::config"] -> Class ["hadoop::hdfs::service"]
}
