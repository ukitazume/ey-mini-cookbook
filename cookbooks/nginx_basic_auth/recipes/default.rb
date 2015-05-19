node[:applications].each do |app_name, _|
  if ['solo', 'app', 'app_master'].include?(node[:instance_role])
    template "/etc/nginx/servers/#{app_name}/custom.conf" do
      owner node[:owner_name]
      group node[:owner_name]
      backup false
      mode 0777
      source "custom.conf.erb"
      variables({
        :app => app_name
      })
    end

    template "/etc/nginx/servers/#{app_name}/.htpasswd" do
      owner node[:owner_name]
      group node[:owner_name]
      backup false
      mode 0777
      source "htpasswd.erb"
    end
  end
end

service "nginx" do
  action :reload
end
