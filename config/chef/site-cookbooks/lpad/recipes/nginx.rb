# add epel repository
remote_file "#{Chef::Config[:file_cache_path]}/epel-release-6-8.noarch.rpm" do
    source "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm" 
    action :create
end

rpm_package 'epel-release-6-8.noarch.rpm' do
    source "#{Chef::Config[:file_cache_path]}/epel-release-6-8.noarch.rpm"
    action :install
end

package "nginx"

# remove default nginx config
default_path = "/etc/nginx/conf.d/default"
execute "rm -f #{default_path}" do
  only_if { File.exists?(default_path) }
end

# start nginx
service "nginx" do
  supports [:status, :restart]
  action :start
end

# set custom nginx config
template "/etc/nginx/conf.d/#{node['app']}.conf" do
  source "nginx.conf.erb"
  mode 0644
  owner node['user']['name']
  group node['group']
  notifies :restart, "service[nginx]", :delayed
end
