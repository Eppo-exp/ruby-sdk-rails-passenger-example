require 'eppo_client'

config = EppoClient::Config.new(ENV["EPPO_SDK_KEY"], log_level: "info")

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      EppoClient::init(config)
    end
  end
elsif defined?(Spring)
  Spring.after_fork do
    EppoClient::init(config)
  end
else
  EppoClient::init(config)
end

Rails.application.config.eppo_client = EppoClient::Client.instance
