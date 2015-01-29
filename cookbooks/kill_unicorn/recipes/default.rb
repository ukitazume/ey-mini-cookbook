node[:applications].each do |app_name, _|
  file "/etc/monit.d/unicorn_#{app_name}.monitrc" do
    action :delete
  end

  execute "reload monit" do 
    command %Q{ 
      monit reload 
    } 
  end

  execute "kill unicorn" do 
    command %Q{ 
      /etc/init.d/unicorn_#{app_name} stop
    } 
  end
end
