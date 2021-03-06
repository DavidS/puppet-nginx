# = Class: nginx
#
# This is the main nginx class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, nginx class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $nginx_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, nginx main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $nginx_source
#
# [*source_dir*]
#   If defined, the whole nginx configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $nginx_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true, force => true)
#   Can be defined also by the (top scope) variable $nginx_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, nginx main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $nginx_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $nginx_options
#
# [*service_autorestart*]
#   Automatically restarts the nginx service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $nginx_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $nginx_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $nginx_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $nginx_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for nginx checks
#   Can be defined also by the (top scope) variables $nginx_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $nginx_monitor_target
#   and $monitor_target
#
# [*monitor_config_hash*]
#   A generic Hash that will be passed to certain monitoring Implementations
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $nginx_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $nginx_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $nginx_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for nginx port(s)
#   Can be defined also by the (top scope) variables $nginx_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling nginx. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $nginx_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $nginx_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $nginx_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $nginx_audit_only
#   and $audit_only
#
# Default class params - As defined in nginx::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of nginx package
#
# [*service*]
#   The name of nginx service
#
# [*gzip*]
#   Specified the gzip function of nginx 'on' or 'off'. Deault is 'on',
#
# [*worker_connections*]
#   Specified worker connections number. Default is 1024.
#
# [*keepalive_timeout*]
#   Specified keepalive timeout. Default is 65(ms).
#
# [*server_names_hash_bucket_size*]
#   Specified the server_names_hash_bucket_size. Default is 64
#   Increase this to powers of 2 if you are getting related errors
#
# [*client_max_body_size*]
#   Specified the max body size of client. Default is 10mb.
#   Increase this param if your nginx is an upload server.
#
# [*sendfile*]
#   Activate or deactivate the usage of sendfile. Default is on.
#
# [*service_status*]
#   If the nginx service init script supports status argument
#
# [*process*]
#   The name of nginx process
#
# [*process_args*]
#   The name of nginx arguments. Used by puppi and monitor.
#   Used only in case the nginx process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user nginx runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*config_file_default_purge*]
#   Set to 'true' to purge the default configuration file
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $nginx_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $nginx_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include nginx"
# - Call nginx as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class nginx (
  $gzip                = params_lookup( 'gzip' ),
  $worker_connections  = params_lookup( 'worker_connections' ),
  $keepalive_timeout   = params_lookup( 'keepalive_timeout' ),
  $server_names_hash_bucket_size  = params_lookup( 'server_names_hash_bucket_size' ),
  $client_max_body_size  = params_lookup( 'client_max_body_size' ),
  $types_hash_max_size = params_lookup( 'types_hash_max_size' ),
  $sendfile            = params_lookup( 'sendfile' ),
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $monitor_config_hash = params_lookup( 'monitor_config_hash' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $config_file_default_purge = params_lookup( 'config_file_default_purge'),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' ),
  ) inherits nginx::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  $real_gzip = $gzip ? {
    'off'     => 'off',
    'OFF'     => 'off',
    'ON'      => 'on',
    default   => 'on',
  }

  ### Calculation of variables that dependes on arguments
  # Debian uses TWO configs dirs separatedly
  $cdir = $::operatingsystem ? {
    default => "${nginx::config_dir}/conf.d",
  }

  $vdir = $::operatingsystem ? {
    /(?i:Ubuntu|Debian|Mint)/ => "${nginx::config_dir}/sites-available",
    default                   => "${nginx::config_dir}/conf.d",
  }

  ### Definition of some variables used in the module
  $manage_package = $nginx::bool_absent ? {
    true  => 'absent',
    false => $nginx::version,
  }

  $manage_service_enable = $nginx::bool_disableboot ? {
    true    => false,
    default => $nginx::bool_disable ? {
      true    => false,
      default => $nginx::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $nginx::bool_disable ? {
    true    => 'stopped',
    default =>  $nginx::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $nginx::bool_service_autorestart ? {
    true    => 'Service[nginx]',
    false   => undef,
  }

  $manage_file = $nginx::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $nginx::bool_absent == true
  or $nginx::bool_disable == true
  or $nginx::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $nginx::bool_absent == true or $nginx::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $nginx::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $nginx::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $nginx::source ? {
    ''        => undef,
    default   => $nginx::source,
  }

  $manage_file_content = $nginx::template ? {
    ''        => undef,
    default   => template($nginx::template),
  }

  ### Managed resources
  package { 'nginx':
    ensure => $nginx::manage_package,
    name   => $nginx::package,
  }

  service { 'nginx':
    ensure     => $nginx::manage_service_ensure,
    name       => $nginx::service,
    enable     => $nginx::manage_service_enable,
    hasstatus  => $nginx::service_status,
    pattern    => $nginx::process,
    require    => Package['nginx'],
  }

  file { 'nginx.conf':
    ensure  => $nginx::manage_file,
    path    => $nginx::config_file,
    mode    => $nginx::config_file_mode,
    owner   => $nginx::config_file_owner,
    group   => $nginx::config_file_group,
    require => Package['nginx'],
    notify  => $nginx::manage_service_autorestart,
    source  => $nginx::manage_file_source,
    content => $nginx::manage_file_content,
    replace => $nginx::manage_file_replace,
    audit   => $nginx::manage_audit,
  }

  # The whole nginx configuration directory can be recursively overriden
  if $nginx::source_dir {
    file { 'nginx.dir':
      ensure  => directory,
      path    => $nginx::config_dir,
      require => Package['nginx'],
      notify  => $nginx::manage_service_autorestart,
      source  => $nginx::source_dir,
      recurse => true,
      purge   => $nginx::bool_source_dir_purge,
      force   => $nginx::bool_source_dir_purge,
      replace => $nginx::manage_file_replace,
      audit   => $nginx::manage_audit,
    }
  }

  if $nginx::config_file_default_purge {
    $default_site = $::operatingsystem ? {
      /(?i:Debian|Ubuntu|Mint)/              => [ "${nginx::config_dir}/sites-enabled/default", "${nginx::config_dir}/sites-available/default" ],
      /(?i:Redhat|Centos|Scientific|Fedora)/ => "${nginx::config_dir}/conf.d/default.conf",
    }

    file { $default_site:
      ensure  => absent,
      require => Package[$nginx::package],
      notify  => Service[$nginx::service],
    }
  }


  ### Include custom class if $my_class is set
  if $nginx::my_class {
    include $nginx::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $nginx::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'nginx':
      ensure    => $nginx::manage_file,
      variables => $classvars,
      helper    => $nginx::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $nginx::bool_monitor == true {
    monitor::port { "nginx_${nginx::protocol}_${nginx::port}":
      protocol => $nginx::protocol,
      port     => $nginx::port,
      target   => $nginx::monitor_target,
      tool     => $nginx::monitor_tool,
      enable   => $nginx::manage_monitor,
    }
    monitor::process { 'nginx_process':
      process     => $nginx::process,
      service     => $nginx::service,
      pidfile     => $nginx::pid_file,
      user        => $nginx::process_user,
      argument    => $nginx::process_args,
      tool        => $nginx::monitor_tool,
      enable      => $nginx::manage_monitor,
      config_hash => $nginx::monitor_config_hash,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $nginx::bool_firewall == true {
    firewall { "nginx_${nginx::protocol}_${nginx::port}":
      source      => $nginx::firewall_src,
      destination => $nginx::firewall_dst,
      protocol    => $nginx::protocol,
      port        => $nginx::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $nginx::firewall_tool,
      enable      => $nginx::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $nginx::bool_debug == true {
    file { 'debug_nginx':
      ensure  => $nginx::manage_file,
      path    => "${settings::vardir}/debug-nginx",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
