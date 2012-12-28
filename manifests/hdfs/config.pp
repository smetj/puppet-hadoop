class hadoop::hdfs::config(
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
  
  exec { "format_hdfs":
        command => "/usr/bin/hadoop namenode -format < /tmp/namenode_format_answers",
        user    => "hdfs",
        timeout => 10,
        onlyif  => [ "/usr/bin/test -f /tmp/namenode_format_answers" ]
        #require => Notify [ "Created directory hadoop tree." ]
  }

  File ["core-site.xml"] -> File ["hdfs-site.xml"] -> Exec [ "format_hdfs"]
}
