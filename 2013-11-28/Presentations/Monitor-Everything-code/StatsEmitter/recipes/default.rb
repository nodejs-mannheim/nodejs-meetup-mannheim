include_recipe 'apt::default'
include_recipe 'basic-stats::default'
include_recipe 'statsd::default'

# This is simply for the sake of an example, do not run your
# node.js applications as root in real life!

git "/usr/local/src/app" do
  repository "https://github.com/alappe/intro-to-express.git"
  user "root"
  group "root"
end

template "/etc/init/blog.conf" do
  source 'blog.erb'
  owner 'root'
  group 'root'
  mode 00644
  variables(
    :home => "/usr/local/src/app",
    :user_name => "root",
    :group_name => "root"
  )
end

service "blog" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :status => true
  action [:enable, :start]
end

execute "update npm packages" do
  cwd "/usr/local/src/app"
  user "root"
  group "root"
  command "npm install"
  notifies :restart, "service[blog]"
end
