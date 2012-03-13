# Custom application configuration file
config_file_path = "#{Rails.root}/config/config.yml"
environment = Rails.env

begin
  APP_CONFIG = YAML.load_file(config_file_path)[environment]
rescue
  puts "Application not initialized. Be sure the following configuration file exists: #{config_file_path}
Also, for the current environment, check if the configuration file contains the #{environment} mapping.
Here is an example of valid content for development, test and production environments:
####################
development:
  
  # whitelist cofiguration
  check_whitelist: true
  whitelist:
    - 127.0.0.1
    - 127.0.0.2
    
  # email cofiguration
  send_email: true
  email_username: username@gmail.com
  email_password: password
  default_url_host: localhost:3000
  smtp_address: smtp.gmail.com
  smtp_port: 587
  smtp_domain: gmail.com

test:
  
  # whitelist cofiguration
  check_whitelist: true
  whitelist:
    - 127.0.0.1
    - 127.0.0.2
    
  # email cofiguration
  send_email: false

production:
  
  # whitelist cofiguration
  check_whitelist: true
  whitelist:
    - 127.0.0.1
    - 127.0.0.2
    
  # email cofiguration
  send_email: false
####################"
  
  exit
end
