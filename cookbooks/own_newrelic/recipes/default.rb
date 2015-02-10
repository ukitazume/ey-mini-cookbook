yourkey = "789852443cc9bd38bb3589d8050104d0671995d2"
execute 'replace license key' do
  command "cp /etc/newrelic/nrsysmond.cfg /etc/newrelic/nrsysmond.cfg.old && sed 's/license_key=.*$/license_key=#{yourkey}/' /etc/newrelic/nrsysmond.cfg.old > /etc/newrelic/nrsysmond.cfg"
  user "root"
end

execute "restart nrsysmond do" do
  command "/etc/init.d/newrelic-sysmond restart"
  user "root"
end
