gem_package "thin" do
  action :install
end

ssh_username = "deploy"
ports = [3000]

node[:applications].each do |app_name, _|
  template "/engineyard/bin/app_#{app_name}" do
    source 'init.erb'
    owner ssh_username
    group ssh_username
    mode 0755
    backup 0
    cookbook 'thin'
    variables({
      :app_name => app_name
    })
  end

  pid_file = "/var/run/engineyard/#{app_name}/thin.pid"

  template "/etc/monit.d/thin_#{app_name}.monitrc" do
    source "thin.monitrc.erb"
    owner ssh_username
    group ssh_username
    mode 0600
    backup 0
    cookbook  'thin'
    variables({
      :app => app_name,
      :username => ssh_username,
      :pid_file => pid_file,
      :ports => ports 
    })
  end

  bash "cleanup extra thin workers" do
    code <<-EOH
      for pidfile in /var/run/engineyard/#{app_name}/thin.*.pid; do 
              [[ $(echo "${pidfile}" | egrep -o '([0-9]+)' | tail -n 1) -gt 3000 ]] && kill -6 $(cat $pidfile) || true
      done
    EOH
  end
end
