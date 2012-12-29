class hadoop::hdfs::params {
  $fs_default_name              = $hostname
  $tmp_dir                      = "/tmp/hadoop"
  $logfile_size                 = "2000000"
  $logfile_count                = "7"
  $topology_script_file_name    = "/etc/hadoop/conf/hadoop_topology.sh"
  $dfs_replication              = "3"
  $dfs_permissions              = "false"
  $dfs_datanode_du_reserved     = "10000000000"
  $dfs_datanode_du_pct          = "0.9f"
  $dfs_datanode_max_xcievers    = "4096"
  $dfs_balance_bandwidthPerSec  = "104857600"
  $volumes                      = []
  $namenode                     = false
  $datanode                     = false
  $secondarynamenode            = false
}
