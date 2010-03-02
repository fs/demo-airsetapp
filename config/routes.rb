ActionController::Routing::Routes.draw do |map|
  map.resource :access, :only => [:show, :create, :complete], :member => { :complete => :get }
  map.root :controller => 'home', :action => 'show'
end
