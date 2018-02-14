bash 'install_etcd' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  if [ ! -f /usr/local/bin/etcd ]; then
    yum install wget -y
    wget --max-redirect 255 https://github.com/coreos/etcd/releases/download/v2.3.6/etcd-v2.3.6-linux-amd64.tar.gz
    tar zxvf etcd-v2.3.6-linux-amd64.tar.gz
    cd etcd-v2.3.6-linux-amd64
    cp etcd etcdctl /usr/local/bin
  fi
  EOH
end

template "/etc/init.d/etcd" do
	mode "0755"
	owner "root"
	source "etcd.erb"
end

