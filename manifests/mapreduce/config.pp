class hadoop::mapreduce::config(
  $mapred_job_tracker=undef,
  $mapred_system_dir=undef,
  $mapred_tasktracker_map_tasks_maximum=undef,
  $mapred_tasktracker_reduce_tasks_maximum=undef,
  $volumes=undef,
  $jobtracker=undef,
  $tasktracker=undef){
  $mapred_local_dir       = regsubst($volumes, '(.*)', "\\1/mapred")
  file { "mapred-site.xml":
    path    => "/etc/hadoop/conf/mapred-site.xml",
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/hadoop/conf/mapred-site.xml.erb"),
  }
  file { "fair-scheduler_pools.xml":
    path    => "/etc/hadoop/conf/fair-scheduler-pools.xml",
    owner   => root,
    group   => root,
    mode    => 644,
    content => template("${module_name}/etc/hadoop/conf/fair-scheduler-pools.xml.erb"),
  }
}
