environment 'production'
daemonize
pidfile "#{ENV['OPENSHIFT_SERVER_PID']}"
state_path "#{ENV['OPENSHIFT_RUBY_DIR']}run/server.state"
stdout_redirect "#{ENV['OPENSHIFT_SERVER_STDOUT_LOG']}", "#{ENV['OPENSHIFT_SERVER_STDERR_LOG']}"
threads 0, 16
bind "tcp://#{ENV['OPENSHIFT_RUBY_IP']}:#{ENV['OPENSHIFT_RUBY_PORT']}"