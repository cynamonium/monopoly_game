Rake::Task["deploy:assets:backup_manifest"].clear_actions

namespace :deploy do
  namespace :assets do
    task :backup_manifest do
      puts "************ NOTHING *****************"
    end
  end
end
