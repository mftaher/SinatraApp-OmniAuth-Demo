$LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'/lib'))
require "yaml"
require "rack"

config = YAML.load_file(File.join(File.dirname(__FILE__),'config.yml'))

ENV['facebook_id'] = config['facebook']['app_id']
ENV['facebook_secret'] = config['facebook']['app_secret']
ENV['facebook_scope'] = config['facebook']['scope']

ENV['twitter_key']= config['twitter']['consumer_key']
ENV['twitter_secret'] = config['twitter']['consumer_secret']

require "social_auth"

run SinatraApp::SocialAuth::Demo.new