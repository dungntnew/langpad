#
# Cookbook Name:: lpad
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# update package database
execute 'yum update'

# install development group
execute 'yum groupinstall "Development Tools"'

# install some packages
%w[ telnet postfix curl git zlib mysql3 ].each do |pkg|
    package "#{pkg}" do 
       action :install
    end
end

# set timezone
bash "set timezone" do
   
end
