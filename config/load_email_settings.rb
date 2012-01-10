# Custom application configuration file
config_file_path = "#{Rails.root}/config/email_settings.yml"
environment = Rails.env

begin
  APP_CONFIG = YAML.load_file(config_file_path)[environment]
rescue
  puts "Application not initialized. Be sure the following configuration file exists: #{config_file_path}
Also, for the current environment, check if the configuration file contains the #{environment} mapping.
Here is an example of valid content for development, test and production environments:
####################
development:
  send_email: true
  email_username: username@gmail.com
  email_password: password
  default_url_host: localhost:3000
  smtp_address: smtp.gmail.com
  smtp_port: 587
  smtp_domain: gmail.com

test:
  send_email: false

production:
  send_email: false
####################"
  
  exit
end
