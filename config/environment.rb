require 'rubygems'
require 'bundler/setup'
require 'active_support/all'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/contrib/all' # Requires cookies, among other things
require 'pry'
#require 'stripe'

APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))
APP_NAME = APP_ROOT.basename.to_s

# Sinatra configuration
configure do
  set :root, APP_ROOT.to_path
  set :server, :puma

  enable :sessions
  set :session_secret, ENV['SESSION_KEY'] || 'lighthouselabssecret'

  set :views, File.join(Sinatra::Application.root, "app", "views")
end

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Load the routes / actions
require APP_ROOT.join('app', 'actions')

#set :publishable_key, ENV['PUBLISHABLE_KEY']
#set :secret_key, ENV['SECRET_KEY']
#
#Stripe.api_key = settings.secret_key

#Stripe.api_key = "sk_test_BQokikJOvBiI2HlWgH4olfQ2"
#
#Stripe::Charge.create(
#   :amount => 400,
#   :currency => "usd",
#   :source => {
#   :number => "4242424242424242",
#   :exp_month => 8,
#   :exp_year => 2016,
#   :cvc => "314"
#    },
#  :description => "Charge for test@example.com"
#)
