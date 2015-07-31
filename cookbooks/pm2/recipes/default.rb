execute "install pm2" do
  command "npm install pm2 -g"
  notifies :run, "execute[link pm2]"
end

execute "link pm2" do
  command "ln -s /opt/nodejs/current/bin/pm2  /usr/bin/pm2"
  not_if { File.exists?("/usr/bin/pm2") }
  notifies :run, "execute[init script and rc level]"
end

# TODO: https://github.com/Unitech/PM2/issues/1063
execute 'init script and rc level' do
  command "pm2 startup gentoo || mv /etc/init.d/pm2-init.sh  /etc/init.d/pm2 && chmod +x /etc/init.d/pm2 && rc-update add pm2 default"
  only_if { ::File.exists?("/usr/bin/pm2") }
end
