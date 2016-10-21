unless node[:opsworks][:skip_uninstall_of_other_rails_stack]
  include_recipe "apache2::uninstall"
end

# setup Unicorn service per app
node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping rubyd::rails application #{application} as it is not an Rails app")
    next
  end

  opsworks_deploy_user do
    deploy_data deploy
  end

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  service "rubyd_#{application}" do
    start_command "#{deploy[:deploy_to]}/bin/aggregator start"
    stop_command "#{deploy[:deploy_to]}/bin/aggregator stop"
    restart_command "#{deploy[:deploy_to]}/bin/aggregator restart"
    status_command "#{deploy[:deploy_to]}/bin/aggregator status"
    action :nothing
  end

end
