if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  directory "/data/final/current/public" do
    owner @node[:owner_name]
    group @node[:owner_name]
    recursive true
  end

  @node[:applications].keys.each do |app_name|
    link "/data/final/current/public/system" do
      to "/data/#{app_name}/shared/system"
      link_type :symbolic
    end
  end
end
