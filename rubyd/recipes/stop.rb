# stop Unicorn service per app
node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping rails application #{application} as it is not an Rails app")
    next
  end

  execute "stop daemon" do
    command "#{deploy[:deploy_to]}/bin/aggregator/stop"
    only_if do
      File.exists?("#{deploy[:deploy_to]}/bin/aggregator/stop")
    end
  end
end
