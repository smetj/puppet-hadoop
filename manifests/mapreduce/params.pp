class hadoop::mapreduce::params{
  $mapred_job_tracker                       = $hostname
  $mapred_system_dir                        = "/hadoop/mapred/system"
  $mapred_tasktracker_map_tasks_maximum     = "3"
  $mapred_tasktracker_reduce_tasks_maximum  = "3"
  $volumes                                  = []
  $jobtracker                               = false
  $tasktracker                              = false
}
