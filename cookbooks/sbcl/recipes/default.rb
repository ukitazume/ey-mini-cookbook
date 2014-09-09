remote_file "/tmp/sbcl-1.2.3-x86-64-linux-binary.tar.bz2" do
  source "http://sourceforge.net/projects/sbcl/files/sbcl/1.2.3/sbcl-1.2.3-x86-64-linux-binary.tar.bz2"
  mode "0644"
  not_if { File.exists?("/tmp/sbcl-1.2.3-x86-64-linux-binary.tar.bz2") }
end

bash "unzip sbcl" do
  user "root"
  cwd "/tmp"
  code %(tar xvfj /tmp/sbcl-1.2.3-x86-64-linux-binary.tar.bz2)
  not_if { File.exists? "/tmp/sbcl-1.2.3-x86-64-linux" }
end

bash "install sbcl" do
  user "root"
  cwd "/tmp/sbcl-1.2.3-x86-64-linux"
  code %(INSTALL_ROOT=/usr/local sh install.sh)
  not_if { File.exists? "/usr/local/lib/sbcl/lib" }
end
