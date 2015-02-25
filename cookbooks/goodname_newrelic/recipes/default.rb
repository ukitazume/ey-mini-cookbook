execute 'remove hostname config' do
  command "cp /etc/newrelic/nrsysmond.cfg /etc/newrelic/nrsysmond.cfg.old && sed 's/^hostname=.*$//' /etc/newrelic/nrsysmond.cfg.old > /etc/newrelic/nrsysmond.cfg"
  user "root"
end

execute 'add hostanme' do
  environment_name = node['environment']['name']
  instance_id = node['engineyard']['this']
  hostname = "#{environment_name}/#{instance_id}"
  command "echo 'hostname=#{hostname}' >> /etc/newrelic/nrsysmond.cfg"
  user "root"
end

execute "restart nrsysmond do" do
  command "/etc/init.d/newrelic-sysmond restart"
  user "root"
end
