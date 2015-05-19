php_version = '5.4'
if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  node['applications'].each do |app|
    app_name = app.first
    [:cli, :fpm].each do |exe_env|
      template "/etc/php/#{exe_env}-php#{php_version}/ext-active/#{app_name}_custom.ini" do
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

  execute "restarat php-fpm" do
    command "sudo monit restart all -g php-fpm"
  end
end
