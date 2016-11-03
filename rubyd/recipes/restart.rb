# stop Unicorn service per app
node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping rails application #{application} as it is not an Rails app")
    next
  end

  execute "Restart deamon" do
    command "#{deploy[:deploy_to]}/bin/aggregator/restart"
    only_if do
      File.exists?("#{deploy[:deploy_to]}/bin/aggregator/restart")
    end
  end
end
