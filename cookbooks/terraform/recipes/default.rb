#
# Cookbook:: terraform
# Recipe:: default
# Owner:: lorxiong
# Copyright:: 2018, The Authors, All Rights Reserved.
#
#
remote_file "#{Chef::Config[:file_cache_path]}/terraform_0.11.5_linux_amd64.zip" do
  not_if "test -e #{Chef::Config[:file_cache_path]}/terraform_0.11.5_linux_amd64.zip"
  source 'https://releases.hashicorp.com/terraform/0.11.5/terraform_0.11.5_linux_amd64.zip'
end

execute 'unzip-terraform' do
  not_if "test -e /usr/local/bin/terraform"
  cwd '/usr/local/bin'
  command "unzip #{Chef::Config[:file_cache_path]}/terraform_0.11.5_linux_amd64.zip"
end
