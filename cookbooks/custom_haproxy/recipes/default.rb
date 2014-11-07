execute "reload-haproxy" do
  command 'if /etc/init.d/haproxy status ; then /etc/init.d/haproxy reload; else /etc/init.d/haproxy restart; fi'
  action :nothing
end

bash "add-haproxy-config" do
  user 'root'
  code <<-EOC
  if grep --quiet '# additional-config' /etc/haproxy.cfg; then
    strline=`grep -n '# additional-config' /etc/haproxy.cfg | sed -e "s/[:].*//"`
    endline=`wc -l < /etc/haproxy.cfg`
    sed -e "${strline},${endline}d" /etc/haproxy.cfg > /etc/haproxy.cfg.new
  else
    cp /etc/haproxy.cfg /etc/haproxy.cfg.new
  fi
  cat /etc/haproxy/additional_config >> /etc/haproxy.cfg.new
  cp /etc/haproxy.cfg /etc/haproxy.cfg.old
  cp /etc/haproxy.cfg.new /etc/haproxy.cfg
  EOC
  only_if{::File.exists?("/etc/haproxy/additional_config")}
  notifies :run,  resources(:execute => "reload-haproxy")
end

template "/etc/haproxy/additional_config" do
  owner 'root'
  group 'root'
  mode 0644
  source "addition_config.erb"
  variables({
    :backends => node['engineyard']['environment']['instances'].keep_if{|inst| inst['role'] =~ /app/ },
    :app_master_weight => node['members'].size < 51 ? (50 - (node['members'].size - 1)) : 0
  })
  notifies :run,  resources(:bash => "add-haproxy-config")
end

