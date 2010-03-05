set :application, "airsetapp"
set :repository,  "git://github.com/fs/demo-airsetapp.git"
set :scm, :git
set :branch, "master"
set :rails_env, "production"
set :deploy_to, "/var/www/rails/#{application}"
set :user, "admin"
set :use_sudo, false
set :deploy_via, :remote_cache
server "flatsoft-rails.flatsoft.com", :app, :web, :db, :primary => true

after "deploy:finalize_update", "deploy:symlink_configs"
after "deploy", "deploy:cleanup"

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Symlink config files"
  task :symlink_configs, :roles => :app do
    %w[facebooker.yml config.yml].each do |f|
      run "ln -sf #{shared_path}/config/#{f} #{release_path}/config/#{f}"
    end
    run "ln -sf #{shared_path}/production.sqlite3 #{release_path}/db/production.sqlite3"
  end
end
