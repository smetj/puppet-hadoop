class hadoop::mapreduce(
  $mapred_job_tracker                       = $hadoop::mapreduce::params::hostname,
  $mapred_system_dir                        = $hadoop::mapreduce::params::mapred_system_dir,
  $mapred_tasktracker_map_tasks_maximum     = $hadoop::mapreduce::params::mapred_tasktracker_map_tasks_maximum,
  $mapred_tasktracker_reduce_tasks_maximum  = $hadoop::mapreduce::params::mapred_tasktracker_reduce_tasks_maximum,
  $volumes                                  = $hadoop::mapreduce::params::volumes,
  $jobtracker                               = $hadoop::mapreduce::params::jobtracker,
  $tasktracker                              = $hadoop::mapreduce::params::tasktracker) inherits hadoop::mapreduce::params{
  anchor { "hadoop::mapreduce::start":
  } ->
  class { "hadoop::mapreduce::packages":
    jobtracker                              => $jobtracker,
    tasktracker                             => $tasktracker
  } ~>
  class { "hadoop::mapreduce::config":
    mapred_job_tracker                      => $mapred_job_tracker,
    mapred_system_dir                       => $mapred_system_dir,
    mapred_tasktracker_map_tasks_maximum    => $mapred_tasktracker_map_tasks_maximum,
    mapred_tasktracker_reduce_tasks_maximum => $mapred_tasktracker_reduce_tasks_maximum,
    volumes                                 => $volumes,
    jobtracker                              => $jobtracker,
    tasktracker                             => $tasktracker
  } ~>
  class { "hadoop::mapreduce::service":
    jobtracker                              => $jobtracker,
    tasktracker                             => $tasktracker,
  } ~>
  anchor { "hadoop::mapreduce::end":
  }
}
