#
# Cookbook Name:: lpad
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# update package database
execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

# install develop group
# execute "yum-groupinstall 'Development Tools'"

# set timezone
bash "set timezone" do
  code <<-EOH
    mv /etc/localtime /etc/localtime.bk
    ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
  EOH
  not_if "date | grep -q 'JST'"
end
