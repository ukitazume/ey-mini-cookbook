license_key = "your new key"
config_file = "/etc/newrelic/nrsysmond.cfg"
execute 'replace New Relic license key' do
  command "mv #{config_file} #{config_file}.old && sed 's/license_key=.*$/license_key=#{license_key}/' #{config_file}.old > #{config_file}"
  user "root"
  not_if "grep -q #{license_key} #{config_file}"
end

execute "restart nrsysmond" do
  command "/etc/init.d/newrelic-sysmond restart"
  user "root"
end
