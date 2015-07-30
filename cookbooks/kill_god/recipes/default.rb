execute "remove-god-from-inittab" do
  command "sed -i '/^god:.*/d' /etc/inittab"
end
execute "remove-god0-from-inittab" do
  command "sed -i '/^god0:.*/d' /etc/inittab"
end

execute "telinit-q" do
  command "telinit q"
end

execute "kill god" do
  command "killall ruby19"
  only_if 'ps aux | grep ruby19 | grep -v grep'
end

node[:applications].each do |app_name, _|
  template "/engineyard/bin/app_#{app_name}" do
    owner node[:owner_name]
    group node[:owner_name]
    backup false
    mode 0755
    source "app_init.erb"
    variables({
      :app => app_name
    })
  end
end


