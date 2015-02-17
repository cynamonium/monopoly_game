namespace :misc do

  def with_release_bundler(cmd)
    on roles(:app) do
      within(release_path) do
        with RAILS_ENV: fetch(:stage) do
          execute(:bundle, cmd)
        end
      end
    end
  end

  task :create_env_file do
    on roles :all do
      within (release_path) do
        execute "/usr/bin/env echo  #{fetch(:stage)} >  #{release_path}/ENVIRONMENT"
      end
    end
  end
  after 'deploy:updating', 'misc:create_env_file'

  desc "Dummy data for now, replace later with seed migrations"
  task :run_seeds do
    # just boot rails once
    with_release_bundler( %Q[exec rake db:create db:migrate db:seed ] )
  end
  after 'deploy:updated', 'misc:run_seeds'
end


# http://stackoverflow.com/questions/22213575/capistrano-3-error-when-deploy
namespace :deploy do
  desc 'Copies .git folder'
  task :copy_git do
    on roles(:app) do
        puts release_path
        within release_path do
              execute :cp, '-r', repo_path, '.git'
        end
    end
  end

  before 'bundler:install', 'deploy:copy_git'
end
