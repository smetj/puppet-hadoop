class hadoop::mapreduce::packages(
  $jobtracker = false,
  $tasktracker = false){
  
  if $jobtracker == true {
    package { "hadoop-0.20-jobtracker":
      ensure => "installed",
      provider => "yum"
    }
  }
  else {
    package { "hadoop-0.20-jobtracker":
      ensure => "absent",
      provider => "yum"
    }
  }
  if $tasktracker == true {
    package { "hadoop-0.20-tasktracker":
      ensure => "installed",
      provider => "yum"
    }
  }
  else {
    package { "hadoop-0.20-tasktracker":
      ensure => "absent",
      provider => "yum"
    }
  }
}
