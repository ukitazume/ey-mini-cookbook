execute "gem install fluentd" do 
  command "gem install fluentd -v 0.10.56"
  user "root"
end


template "/etc/init.d/fluentd" do
  owner 'root'
  group 'root'
  mode 0755
  source "fluentd.erb"
  variables({
  })
end

directory '/etc/fluentd/' do
  owner  'deploy'
  group  'deploy'
  mode   0755
  action :create
end

template "/etc/fluentd/fluent.conf" do
  owner 'deploy'
  group 'deploy'
  mode 0755
  source "fluent.conf.erb"
  variables({
  })
  only_if { File.exists?("/etc/fluentd") }
end

directory '/var/run/fluentd/' do
  owner  'deploy'
  group  'deploy'
  mode   0755
  action :create
  notifies :action, "template[/etc/fluentd/fluent.conf]"
end

file '/var/log/fluentd.log' do
  owner  'deploy'
  group  'deploy'
  mode   0660
  action :create
  not_if { File.exists?("/var/log/fluentd.log") }
end
