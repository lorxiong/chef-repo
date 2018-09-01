#
# Cookbook:: docker
# Recipe:: default
# Owner:: lorxiong
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#
# Install required packages
%w(yum-utils
   device-mapper-persistent-data
   lvm2).each do |package|
  yum_package "#{package}" do
    action :install
  end
end

# Create docker repo
template '/etc/yum.repos.d/docker-ce.repo' do
  source 'docker-ce.repo.erb'
  owner 'root'
  group 'root'
  mode 0644
end

# create docker group
group 'docker' do
  action :create
  gid 987
end

# create docker user
user 'docker' do
  action :create
  manage_home true
  uid 11111
  gid 987
end

# install docker package
yum_package 'docker-ce' do
  flush_cache before: true
  action :install
end

service "docker" do
  action [ :enable, :start ]
end
