class AccessesController < ApplicationController
  skip_before_filter :require_access
  before_filter :require_no_access
  
  def show
  end
  
  def create
    result = airset.create_token(complete_access_url)
    current_user.update_attribute :auth_token, result['authToken']
    redirect_to result['url']
  end
  
  def complete
    @result = airset.create_session(current_user.auth_token)
    if @result
      current_user.create_session!(@result['userId'], @result['sessionKey'])
    else
      flash[:notice] = "Failed to authorize with AirSet"
      redirect_to access_url
    end
  end
  
  protected
  
  def require_no_access
    redirect_to root_url if current_user.session_valid?
  end
end
