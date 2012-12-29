class hadoop::base(
  $metricfactory          = $hadoop::base::params::metricfactory,
  $java_home              = $hadoop::base::params::java_home,
  $heapsize               = $hadoop::base::params::heapsize,
  $namenode_opts          = $hadoop::base::params::namenode_opts,
  $secondarynamenode_opts = $hadoop::base::params::secondarynamenode_opts,
  $datanode_opts          = $hadoop::base::params::datanode_opts,
  $balancer_opts          = $hadoop::base::params::balancer_opts,
  $jobtracker_opts        = $hadoop::base::params::jobtracker_opts,
  $tasktracker_opts       = $hadoop::base::params::tasktracker_opts,
  $volumes                = $hadoop::base::params::volumes,
  $logging_id             = $hadoop::base::params::logging_id,
  $logging_server         = $hadoop::base::params::logging_server,
  $logging_threshold      = $hadoop::base::params::logging_threshold) inherits hadoop::base::params {
  
  anchor { "hadoop::base::start":
  } ->
  class { "hadoop::base::packages":
  } ~>
  class { "hadoop::base::config":
    metricfactory           => $metricfactory,
    java_home               => $java_home,
    heapsize                => $heapsize,
    namenode_opts           => $namenode_opts,
    secondarynamenode_opts  => $secondarynamenode_opts,
    datanode_opts           => $datanode_opts,
    balancer_opts           => $balancer_opts,
    jobtracker_opts         => $jobtracker_opts,
    tasktracker_opts        => $tasktracker_opts,
    volumes                 => $volumes,
    logging_id              => $logging_id,
    logging_server          => $ogging_server,
    logging_threshold       => $logging_threshold
  } ~>
  anchor { "hadoop::base::end":
  }
}
