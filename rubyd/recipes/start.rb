# stop Unicorn service per app
node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping rails application #{application} as it is not an Rails app")
    next
  end

  execute "start daemon" do
    command "#{deploy[:deploy_to]}/bin/aggregator/start"
    only_if do
      File.exists?("#{deploy[:deploy_to]}/bin/aggregator/start")
    end
  end
end
