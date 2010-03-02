class ApplicationController < ActionController::Base
  helper :all
  filter_parameter_logging :password
  protect_from_forgery
  ensure_application_is_installed_by_facebook_user
  
  attr_accessor :current_user
  helper_method :current_user
  before_filter :prepare_current_user
  before_filter :require_access
  
  protected
  
  def airset
    @airset ||= AirSet.new(APP_CONFIG['app_id'], APP_CONFIG['app_key'], session_key)
  end
  
  def prepare_current_user
    set_facebook_session
    if facebook_session && facebook_session.secured? && !request_is_facebook_tab?
      self.current_user = User.for(facebook_session.user.to_i)
    end
  end
  
  def session_key
    current_user && current_user.session_valid? ? current_user.session_key : nil
  end
  
  def require_access
    redirect_to access_url if session_key.blank?
  end  
end
