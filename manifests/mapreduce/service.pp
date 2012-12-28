class hadoop::mapreduce::service(
  $jobtracker   = false,
  $tasktracker  = false){
  if $jobtracker == true {
    service { "hadoop-0.20-jobtracker":
      ensure => "running"
    }
  }
  else{
    service { "hadoop-0.20-jobtracker":
      ensure => "stopped"
    }
  }
  if $tasktracker == true {
    service { "hadoop-0.20-tasktracker":
      ensure => "running"
    }
  }
  else{
    service { "hadoop-0.20-tasktracker":
      ensure => "stopped"
    }
  }
}
