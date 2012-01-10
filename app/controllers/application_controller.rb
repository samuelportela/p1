class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  before_filter :store_location
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
  
  def default_url_options(options = {})
    options.merge({:locale => I18n.locale})
  end
  
  def store_location
    session[:user_return_to] = request.url unless params[:controller] == "devise/sessions"
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end
end
