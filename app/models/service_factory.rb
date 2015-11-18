class ServiceFactory

  def self.create_service(logged_in_user, service_name)
    create_service_class(service_name).new(user_auth_info(logged_in_user, service_name))
  end


  private

  def self.user_auth_info(logged_in_user, service_name)
    logged_in_user.authorizations.find_by_provider(service_name)
  end

  def self.create_service_class(name)
    "#{name.to_s.capitalize}Service".constantize
  end
end
