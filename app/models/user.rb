class User < ActiveRecord::Base
  def session_valid?
    !session_key.blank? && !session_valid_until.blank? && Time.now <= session_valid_until
  end
  
  def create_session!(user_id, session_key)
    session = {
      :session_key         => session_key,
      :session_valid_until => 1.day.from_now      
    }
    update_attributes(session.merge(
      :auth_token          => nil,
      :airset_id           => user_id
    ))
    self.class.update_all session, { :airset_id => user_id }
  end
  
  class << self
    def for(uid)
      user = find_by_uid(uid)  
      if user.blank?
        user = create(
          :uid     => uid,
          :name    => 'Unknown'
        )
      end
      user
    end
  end
end
