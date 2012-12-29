class hadoop::hdfs(
  $fs_default_name              = $hadoop::hdfs::params::fs_default_name,
  $tmp_dir                      = $hadoop::hdfs::params::tmp_dir,
  $logfile_size                 = $hadoop::hdfs::params::logfile_size,
  $logfile_count                = $hadoop::hdfs::params::logfile_count,
  $topology_script_file_name    = $hadoop::hdfs::params::topology_script_file_name,
  $dfs_replication              = $hadoop::hdfs::params::dfs_replication,
  $dfs_permissions              = $hadoop::hdfs::params::dfs_permissions,
  $dfs_datanode_du_reserved     = $hadoop::hdfs::params::dfs_datanode_du_reserved,
  $dfs_datanode_du_pct          = $hadoop::hdfs::params::dfs_datanode_du_pct,
  $dfs_datanode_max_xcievers    = $hadoop::hdfs::params::dfs_datanode_max_xcievers,
  $dfs_balance_bandwidthPerSec  = $hadoop::hdfs::params::dfs_balance_bandwidthPerSec,
  $volumes                      = $hadoop::hdfs::params::volumes,
  $namenode                     = $hadoop::hdfs::params::namenode,
  $datanode                     = $hadoop::hdfs::params::datanode,
  $secondarynamenode            = $hadoop::hdfs::params::secondarynamenode) inherits hadoop::hdfs::params {
  anchor { "hadoop::hdfs::start":
  } ->
  class { "hadoop::hdfs::packages":
    namenode                => $namenode,
    datanode                => $datanode,
    secondarynamenode       => $secondarynamenode
  } ~>
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
  } ~>
  class { "hadoop::hdfs::service":
    namenode                     => $namenode,
    datanode                     => $datanode,
    secondarynamenode            => $secondarynamenode
  } ~>
  anchor { "hadoop::hdfs::end":
  }
}
