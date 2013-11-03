listen "#{ENV['OPENSHIFT_RUBY_IP']}:#{ENV['OPENSHIFT_RUBY_PORT']}"
pid "#{ENV['OPENSHIFT_RUBY_SERVER_PID']}"
timeout 30
stdout_path "#{ENV['OPENSHIFT_RUBY_LOG_DIR']}/unicorn_stdout.log"
stderr_path "#{ENV['OPENSHIFT_RUBY_LOG_DIR']}/unicorn_stderr.log"

