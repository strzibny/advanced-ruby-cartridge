Rainbows! do
  #use :FiberSpawn
  use :ThreadSpawn # concurrency model to use
  worker_connections 400
  client_max_body_size 5*1024*1024 # 5 MB
  keepalive_requests 666 # default:100
  client_header_buffer_size 2 * 1024 # 2 kB
end

listen "#{ENV['OPENSHIFT_RUBY_IP']}:#{ENV['OPENSHIFT_RUBY_PORT']}"
pid "#{ENV['OPENSHIFT_RUBY_SERVER_PID']}"
timeout 30
stdout_path "#{ENV['OPENSHIFT_RUBY_SERVER_STDOUT_LOG']}"
stderr_path "#{ENV['OPENSHIFT_RUBY_SERVER_STDERR_LOG']}"

