bash 'install_flannel' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  if [ ! -f /usr/local/bin/flanneld ]; then
    yum install wget -y
    wget --max-redirect 255 https://github.com/coreos/flannel/releases/download/v0.8.0/flannel-0.8.0-linux-amd64.tar.gz
    tar zxvf flannel-0.8.0-linux-amd64.tar.gz
    cd flannel-0.8.0
    cp flanneld /usr/local/bin
    cp mk-docker-opts.sh /opt/
  fi
  EOH
end

template "/etc/init.d/flanneld" do
	mode "0755"
	owner "root"
	source "flanneld.erb"
	variables :elb_url => node['etcd']['elb_url']
	notifies :disable, 'service[flanneld]', :delayed
end


service "flanneld" do
	action :nothing
end

