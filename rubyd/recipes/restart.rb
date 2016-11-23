# stop Unicorn service per app
node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping rails application #{application} as it is not an Rails app")
    next
  end

  execute "Restart deamon" do
    command "./bin/aggregator/restart"
    cwd "#{deploy[:deploy_to]}/current"
    environment node[:deploy]['tsr_v2'][:environment_variables]
  end
end
