execute "gem install fluentd" do 
  command "gem install fluentd -v 0.10.56"
  user "root"
end

execute "gem install bundler" do 
  command "gem install bundler"
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
  notifies :run, "directory[/etc/fluentd/plugin]"
  notifies :run, "template[/etc/fluentd/fluent.conf]"
  notifies :run, "template[/etc/fluentd/Gemfile]"
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
  notifies :run, "template[/etc/fluentd/fluent.conf]"
end

file '/var/log/fluentd.log' do
  owner  'deploy'
  group  'deploy'
  mode   0660
  action :create
  not_if { File.exists?("/var/log/fluentd.log") }
end

directory '/etc/fluentd/plugin' do
  owner  'deploy'
  group  'deploy'
  mode   0755
  action :create
  only_if { File.exists?("/etc/fluentd") }
  notifies :run, "execute[plugin install]"
end

template "/etc/fluentd/Gemfile" do
  owner 'deploy'
  group 'deploy'
  mode 0755
  source "Gemfile"
  variables({
  })
  only_if { File.exists?("/etc/fluentd") }
end

execute "plugin install" do
  command "bundle install --path /etc/fluentd/plugin"
  cwd "/etc/fluentd"
  user "deploy"
  only_if { File.exists?("/etc/fluentd/plugin") }
end

template "/data/monit.d/fluentd.monitrc" do
  owner 'root'
  group 'root'
  mode 0644
  source "fluentd.monitrc.erb"
  notifies :run, "execute[monit reload]"
end

execute "monit reload" do
  command "monit reload"
  action :run
end

execute "fluentd reload" do
  command "monit restart fluentd"
  user "root"
end
