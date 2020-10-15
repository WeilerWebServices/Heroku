Typus.setup do |config|

  # Define authentication: +:none+, +:http_basic+, +:session+
  config.authentication = :session

  # Define master_role.
  # config.master_role = "admin"

  # Define relationship.
  # config.relationship = "typus_users"

  # Define user_class_name.
  config.user_class_name = "<%= options[:user_class_name] %>"

  # Define user_fk.
  config.user_fk = "<%= options[:user_fk] %>"

end
