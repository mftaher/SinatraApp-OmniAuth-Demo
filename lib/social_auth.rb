require "sinatra/base"
require "haml"
require "omniauth-facebook"
require "omniauth-twitter"

module SinatraApp
  module SocialAuth
    class Demo < Sinatra::Base
      use Rack::Session::Pool
      
      set :root, File.dirname(__FILE__)
      set :app_path, '/'
      
      before do
        @scope = ENV["facebook_scope"]
        @fb_id = ENV["facebook_id"]
      end
      
      use OmniAuth::Builder do 
        provider :facebook, ENV["facebook_id"], ENV["facebook_secret"], :scope => ENV["facebook_scope"]
        provider :twitter, ENV["twitter_key"], ENV["twitter_secret"]
      end
      
      get '/' do
        haml :index
      end
      
      get '/auth/:provider/callback' do
        @user = request.env['omniauth.auth'].info.to_json
        haml :secure
      end
      
      get '/auth/failure' do
        @message = params
        haml :fail
      end
      
    end  
  end
end
