#
# Cookbook:: nginx
# Recipe:: default
# Owner:: lorxiong
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

# Create nginx repo
template '/etc/yum.repos.d/nginx.repo' do
  source 'nginx.repo.erb'
  owner 'root'
  group 'root'
  mode 0644
end

# install nginx
yum_package 'nginx' do
  action :install
end

# configure service
template '/etc/systemd/system/nginx.service' do
  source 'nginx.service.erb'
  owner 'root'
  group 'root'
  mode 0644
  notifies :run, 'bash[daemon-reload]', :immediately
end

bash 'daemon-reload' do
  user 'root'
  cwd '/root'
  code <<-EOH
    systemctl daemon-reload
  EOH
  action :nothing
end

# start and enable nginx service
service "nginx.service" do
  provider Chef::Provider::Service::Systemd
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end
