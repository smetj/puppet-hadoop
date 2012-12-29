class hadoop::mapreduce(
  $mapred_job_tracker=$hostname,
  $mapred_system_dir="/hadoop/mapred/system",
  $mapred_tasktracker_map_tasks_maximum="3",
  $mapred_tasktracker_reduce_tasks_maximum="3",
  $volumes=[],
  $jobtracker=false,
  $tasktracker=false){
    class { "hadoop::mapreduce::packages":
      jobtracker  => $jobtracker,
      tasktracker => $tasktracker
    }
    class { "hadoop::mapreduce::config":
      mapred_job_tracker                      => $mapred_job_tracker,
      mapred_system_dir                       => $mapred_system_dir,
      mapred_tasktracker_map_tasks_maximum    => $mapred_tasktracker_map_tasks_maximum,
      mapred_tasktracker_reduce_tasks_maximum => $mapred_tasktracker_reduce_tasks_maximum,
      volumes                                 => $volumes,
      jobtracker                              => $jobtracker,
      tasktracker                             => $tasktracker
    }
    class { "hadoop::mapreduce::service":
      jobtracker            => $jobtracker,
      tasktracker           => $tasktracker,
    }
    Class["hadoop::mapreduce::packages"] -> Class["hadoop::mapreduce::config"] ~> Class ["hadoop::mapreduce::service"]
}
