class HomeController < ApplicationController
  def show
    @name = airset.user_name
  end
end
