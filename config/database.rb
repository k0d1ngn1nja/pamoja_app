configure do
  # Log queries to STDOUT in development
  if Sinatra::Application.development?
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end

  set :database, {
    adapter: "sqlite3",
    database: "db/db.sqlite3"
  }

 # Load all models from app/models, using autoload instead of require
 # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end
<<<<<<< HEAD

  # itterate through files in uploaders
  Dir[APP_ROOT.join('app', 'uploader', '*.rb')].each { |file| require file }
=======
  Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file}
>>>>>>> 9ab80f0eb2485d73aa684a37f6c1fd5ef077aa1d
end
