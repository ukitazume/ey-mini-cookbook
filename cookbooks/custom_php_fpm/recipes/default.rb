if ['solo', 'app', 'app_master'].include?(node[:instance_role])
      template "/etc/nginx/#{exe_env}-php5.4/ext-active/#{app_name}_custom.ini" do
        owner node[:owner_name]
        group node[:owner_name]
        backup false
        mode 0777
        source "custom.ini.erb"
        variables({
          :app => app_name
        })
      end
    end
  end
  service "php-fpm" do
    action :restart
  end
end
