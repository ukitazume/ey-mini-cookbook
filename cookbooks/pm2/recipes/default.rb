execute "install pm2" do
  command "npm install pm2 -g"
end

execute "link pm2" do
  command "ln -s /opt/nodejs/current/bin/pm2  /usr/bin/pm2"
  not_if { File.exists?("/usr/bin/pm2") }
end
