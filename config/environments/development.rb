require File.expand_path('../../extras/load_config', __FILE__)

P1::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Action mailer configuration
  if APP_CONFIG['send_email']
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = {:host => APP_CONFIG['default_url_host']}
    config.action_mailer.smtp_settings = {
      :address => APP_CONFIG['smtp_address'],
      :port => APP_CONFIG['smtp_port'],
      :domain => APP_CONFIG['smtp_domain'],
      :user_name => APP_CONFIG['email_username'],
      :password => APP_CONFIG['email_password'],
      :authentication => 'plain',
      :enable_starttls_auto => true
    }
  else
    config.action_mailer.default_url_options = {:host => 'localhost:3000'}
  end

  # Paperclip file location configuration
  Paperclip::Attachment.default_options[:url] = "/system/:attachment/:class/:id/:style.:extension"
  Paperclip::Attachment.default_options[:path] = ":rails_root/public/system/:attachment/:class/:id/:style.:extension"
  Paperclip::Attachment.default_options[:default_url] = "missing/:style/missing.png"
end
