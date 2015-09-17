node[:applications].each do |app_name, _|
  if ['solo', 'app', 'app_master'].include?(node[:instance_role])
    template "/etc/nginx/servers/#{app_name}/customer.ssl_cipher" do
      owner node[:owner_name]
      group node[:owner_name]
      backup false
      mode 0777
      source "customer.ssl_cipher.erb"
      variables({
        :app_name => app_name
      })
      notifies :reload, "service[nginx]"
    end
  end
end

service "nginx" do
  action :reload
end
