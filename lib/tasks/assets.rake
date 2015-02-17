# our custom assets precompile task
namespace :assets do
  task :precompile do
    chdir 'assets'
    sh 'npm install'
    sh 'npm install bower'
    sh 'nodejs ./node_modules/bower/bin/bower install'
    sh 'RAILS_ENV=production nodejs ./node_modules/webpack/bin/webpack.js  --config webpack.config.js'
    chdir '..'
  end
end
