require 'bundler/capistrano'

set :application, "dinesafe"
set :repository,  "git@github.com:nomatteus/dinesafe.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/home/ruten/webapps/dinesafe" 

role :web, "web239.webfaction.com"                          # Your HTTP server, Apache/etc
role :app, "web239.webfaction.com"                          # This may be the same as your `Web` server
role :db,  "web239.webfaction.com", :primary => true # This is where Rails migrations will run

default_environment['PATH'] = "/home/ruten/webapps/dinesafe/bin:$PATH"
default_environment['GEM_HOME'] = "/home/ruten/webapps/dinesafe/gems"
default_environment['RUBYLIB'] = "/home/ruten/webapps/dinesafe/lib"
default_environment = {
  'PATH' => "/home/ruten/webapps/dinesafe/bin:$PATH",
  'GEM_HOME' => "/home/ruten/webapps/dinesafe/gems",
  'RUBYLIB' => "/home/ruten/webapps/dinesafe/lib"
}

set :user, "ruten"
set :scm_username, "nomatteus"
set :use_sudo, false
default_run_options[:pty] = true


namespace :deploy do
  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end

  task :link_settings, :roles => :app do
    run "ln -s #{shared_path}/config/settings.yml #{release_path}/config/settings.yml"
    run "ln -s #{shared_path}/config/newrelic.yml #{release_path}/config/newrelic.yml"
  end
end

after 'deploy:finalize_update', 'deploy:link_settings'

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
require './config/boot'
require 'airbrake/capistrano'
