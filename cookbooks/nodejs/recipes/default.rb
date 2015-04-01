enable_package "net-libs/nodejs" do
  version "0.10.30"
end

package "net-libs/nodejs" do
  version "0.10.30"
  action :install
end

link "/opt/nodejs/current" do
  to "/opt/nodejs/0.10.30"
end
